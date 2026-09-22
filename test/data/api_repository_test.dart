import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/repositories/api_repository.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/domain/yield_class.dart';

import '../auth/fake_backend.dart';

const _hallId = '0192a1f0-0030-7000-8000-000000000001';
const _spout1 = '0192a1f0-0050-7000-8000-000000000001';
const _spout2 = '0192a1f0-0050-7000-8000-000000000002';

/// session, GET /sessions listesindeki bir satır.
Map<String, dynamic> session(String id, String status) => {
      'id': id,
      'hallId': _hallId,
      'type': 'morning',
      'status': status,
      'startedAt': '2026-09-22T06:00:00Z',
    };

/// update, §8.5'teki spout.update payload'ı.
Map<String, dynamic> update(String spoutId, String ts, {double flow = 2.5}) => {
      'sessionId': 's1',
      'spoutId': spoutId,
      'flowRate': flow,
      'volumeMl': 5000,
      'expectedMl': 11000,
      'yieldPct': 45.5,
      'flowColor': 'green',
      'yieldColor': 'yellow',
      'state': 'milking',
      'ts': ts,
    };

/// rig, sahte backend'e bağlı bir ApiRepository kurar.
///
/// Yoklama aralığı kısaltılıyor: varsayılan 5 sn ile akış testleri onlarca
/// saniye sürerdi ve kimse test paketini çalıştırmazdı.
({ApiRepository repo, FakeAdapter adapter}) rig(
    Future<ResponseBody> Function(RequestOptions) handler) {
  final adapter = FakeAdapter(handler);
  final dio = Dio(BaseOptions(baseUrl: 'http://test/api/v1'))
    ..httpClientAdapter = adapter;
  return (
    repo: ApiRepository(
      dio: dio,
      // Gerçek 5 sn beklemek akış testlerini yarım dakikaya çıkarırdı.
      pollInterval: const Duration(milliseconds: 5),
    ),
    adapter: adapter,
  );
}

void main() {
  // AÇIK oturumun listeden DOĞRU seçildiğini doğrular.
  //
  // GET /sessions durum parametresi almıyor ve oturumları başlangıç saatine
  // göre TERSTEN döndürüyor. Listenin ilkini körlemesine almak, bölgede son
  // sağım bitmişse KAPALI bir oturumu canlı sanmak olurdu.
  test('kapalı oturumlar atlanır, açık olan seçilir', () async {
    final r = rig((o) async {
      if (o.path == '/sessions') {
        return okEnvelope2([
          session('kapali-2', 'ended'),
          session('acik-1', 'active'),
          session('kapali-1', 'ended'),
        ]);
      }
      return okEnvelope({
        'session': session('acik-1', 'active'),
        'updates': [update(_spout1, '2026-09-22T06:10:00Z')],
      });
    });

    final live = await r.repo.liveSession(hallId: _hallId);

    expect(live.session.id, 'acik-1');
    expect(live.updates, hasLength(1));
    expect(r.adapter.requests.last.path, '/sessions/acik-1/live');
  });

  // Açık oturum YOKKEN "oturum yok" durumu döndüğünü doğrular.
  //
  // Boş liste dönseydi ekran "oturum var ama nokta yok" ile karıştırır ve
  // "sağım başlatın" diyemezdi.
  test('açık oturum yoksa status none döner', () async {
    final r = rig((o) async => okEnvelope2([session('kapali', 'ended')]));

    final live = await r.repo.liveSession(hallId: _hallId);

    expect(live.session.status, 'none');
    expect(live.session.id, isEmpty);
    expect(live.updates, isEmpty);
  });

  test('hiç oturum yoksa da status none döner', () async {
    final r = rig((o) async => okEnvelope2([]));

    expect((await r.repo.liveSession(hallId: _hallId)).session.status, 'none');
  });

  // Yoklamanın YALNIZCA DEĞİŞEN noktaları yayınladığını doğrular.
  //
  // Değişmeyeni tekrar yayınlamak ekranı her yoklamada baştan çizdirirdi.
  test('yoklama değişmeyen noktayı tekrar yayınlamaz', () async {
    var call = 0;
    final r = rig((o) async {
      call++;
      return okEnvelope({
        'session': session('s1', 'active'),
        'updates': [
          // 1. nokta her turda değişiyor, 2. nokta sabit.
          update(_spout1, '2026-09-22T06:10:0$call' 'Z'),
          update(_spout2, '2026-09-22T06:10:00Z'),
        ],
      });
    });

    final got = await r.repo
        .watchSession('s1')
        .take(3)
        .map((u) => u.spoutId)
        .toList();

    expect(got, [_spout1, _spout2, _spout1],
        reason: '2. nokta yalnızca ilk turda yayınlanmalı');
  });

  // Oturum KAPANINCA akışın bittiğini doğrular.
  test('oturum kapanınca akış biter', () async {
    var call = 0;
    final r = rig((o) async {
      call++;
      return okEnvelope({
        'session': session('s1', call >= 2 ? 'ended' : 'active'),
        'updates': [update(_spout1, '2026-09-22T06:10:0$call' 'Z')],
      });
    });

    final got = await r.repo.watchSession('s1').toList();

    expect(got, hasLength(1), reason: 'kapanıştan sonra yayın olmamalı');
  });

  // AĞ HATASININ akışı ÖLDÜRMEDİĞİNİ doğrular.
  //
  // Ahırda kapsama sık kopuyor; akışı kapatmak, bağlantı geri geldiğinde
  // ekranın ölü kalması demekti.
  test('ağ hatası akışı bitirmez, bağlantı dönünce sürer', () async {
    var call = 0;
    final r = rig((o) async {
      call++;
      if (call <= 2) {
        throw DioException.connectionError(
            requestOptions: o, reason: 'kapsama yok');
      }
      return okEnvelope({
        'session': session('s1', 'active'),
        'updates': [update(_spout1, '2026-09-22T06:10:0$call' 'Z')],
      });
    });

    final got = await r.repo.watchSession('s1').take(1).toList();

    expect(got, hasLength(1));
    expect(call, greaterThan(2), reason: 'hatalardan sonra yeniden denenmeli');
  });

  // Oturum kimliği BOŞKEN hiç istek atılmadığını doğrular.
  //
  // Atılsaydı "oturum yok" durumunda her 5 saniyede bir 404 alınırdı.
  test('boş oturum kimliğinde yoklama yapılmaz', () async {
    final r = rig((o) async => okEnvelope({}));

    expect(await r.repo.watchSession('').toList(), isEmpty);
    expect(r.adapter.requests, isEmpty);
  });

  // Geçmiş sorgusunun tarih aralığını UTC olarak GÖNDERDİĞİNİ doğrular.
  //
  // Ekranlar Europe/Istanbul'da çalışıyor (§16); yerel gece yarısını olduğu
  // gibi göndermek backend'de üç saat kayık bir aralık sorgulamak olurdu.
  test('geçmiş sorgusu tarihleri UTC gönderir', () async {
    final r = rig((o) async => okEnvelope2([]));

    await r.repo.animalHistory('a1',
        from: DateTime.utc(2026, 9, 1, 3), to: DateTime.utc(2026, 9, 22, 3));

    final q = r.adapter.requests.single.queryParameters;
    expect(r.adapter.requests.single.path, '/animals/a1/history');
    expect(q['from'], '2026-09-01T03:00:00.000Z');
    expect(q['to'], '2026-09-22T03:00:00.000Z');
  });

  test('tarih verilmezse from/to parametreleri hiç gönderilmez', () async {
    final r = rig((o) async => okEnvelope2([]));

    await r.repo.animalHistory('a1');

    expect(r.adapter.requests.single.queryParameters, isEmpty);
  });

  test('geçmiş kayıtları parse edilir', () async {
    final r = rig((o) async => okEnvelope2([
          {
            'id': 'm1',
            'sessionId': 's1',
            'animalId': 'a1',
            'volumeMl': 9500,
            'expectedMl': 11000,
            'yieldPct': 86.4,
            'color': 'yellow',
            'sessionType': 'evening',
            'startedAt': '2026-09-21T15:05:00Z',
          }
        ]));

    final history = await r.repo.animalHistory('a1');

    expect(history.single.volumeMl, 9500);
    expect(history.single.color, MilkColor.yellow);
    expect(history.single.sessionType, 'evening');
  });

  test('trend parse edilir', () async {
    final r = rig((o) async => okEnvelope({
          'animalId': 'a1',
          'yieldClass': 'declining',
          'ma7Ml': 17200,
          'ma30Ml': 21800,
          'trendSlope': -142.5,
          'daily': [
            {'date': '2026-09-21', 'totalMl': 17000, 'milkingCount': 2, 'ma7Ml': 17200},
          ],
        }));

    final trend = await r.repo.animalTrend('a1');

    expect(r.adapter.requests.single.path, '/animals/a1/trend');
    expect(trend.yieldClass, YieldClass.declining);
    expect(trend.trendSlope, -142.5);
    expect(trend.daily.single.ma30Ml, isNull);
  });

  // BİLİNMEYEN sınıfın listeyi düşürmediğini doğrular.
  //
  // Backend §6.4'e yeni bir sınıf eklerse eski uygulama parse hatası verip
  // hayvan listesini komple kaybetmemeli; normal'a düşer.
  test('bilinmeyen verim sınıfı normal sayılır', () async {
    final r = rig((o) async => okEnvelope({
          'animalId': 'a1',
          'yieldClass': 'pregnant_hold',
        }));

    expect((await r.repo.animalTrend('a1')).yieldClass, YieldClass.normal);
  });

  test('oturum listesi bölge ve aralıkla sorgulanır', () async {
    final r = rig((o) async => okEnvelope2([session('s1', 'ended')]));

    final sessions =
        await r.repo.sessions(hallId: _hallId, from: DateTime.utc(2026, 9, 1));

    expect(sessions.single.status, 'ended');
    expect(r.adapter.requests.single.queryParameters,
        {'from': '2026-09-01T00:00:00.000Z', 'hallId': _hallId});
  });
}
