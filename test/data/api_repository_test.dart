import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/data/repositories/api_repository.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/domain/yield_class.dart';

import 'package:stream_channel/stream_channel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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

/// FakeSocket, testin elinde tuttuğu WebSocket kanalı.
///
/// Gerçek bir sunucuya bağlanmak yerine çerçeveler elle besleniyor:
/// yeniden bağlanma, oturum sonu ve bozuk çerçeve gibi durumlar ancak
/// böyle deterministik kurulabilir.
class FakeSocket {
  FakeSocket() : _in = StreamController<String>();

  final StreamController<String> _in;
  bool sinkClosed = false;

  WebSocketChannel get channel => _FakeChannel(this);

  void send(Object payload) => _in.add(jsonEncode(payload));

  /// Bağlantının kopmasını taklit eder.
  void drop() => _in.close();
}

class _FakeChannel extends StreamChannelMixin<dynamic>
    implements WebSocketChannel {
  _FakeChannel(this._socket);

  final FakeSocket _socket;

  @override
  Stream<dynamic> get stream => _socket._in.stream;

  @override
  WebSocketSink get sink => _FakeSink(_socket);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError(
    'testte kullanılmıyor: ${invocation.memberName}',
  );
}

class _FakeSink implements WebSocketSink {
  _FakeSink(this._socket);

  final FakeSocket _socket;

  @override
  Future<void> close([int? closeCode, String? closeReason]) async {
    _socket.sinkClosed = true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError(
    'testte kullanılmıyor: ${invocation.memberName}',
  );
}

/// rig, sahte backend ve sahte WebSocket'e bağlı bir ApiRepository kurar.
({
  ApiRepository repo,
  FakeAdapter adapter,
  List<FakeSocket> sockets,
  List<Uri> dialed,
  List<Map<String, dynamic>> headers,
})
rig(
  Future<ResponseBody> Function(RequestOptions) handler, {
  List<FakeSocket>? sockets,
  String? token,
}) {
  final adapter = FakeAdapter(handler);
  final dio = Dio(BaseOptions(baseUrl: 'http://test/api/v1'))
    ..httpClientAdapter = adapter;

  final queue = sockets ?? [FakeSocket()];
  final made = <FakeSocket>[];
  final dialed = <Uri>[];
  final headers = <Map<String, dynamic>>[];

  return (
    repo: ApiRepository(
      dio: dio,
      wsBaseUrl: 'ws://test/api/v1',
      accessToken: () => token,
      connect: (uri, hdr) {
        dialed.add(uri);
        headers.add(hdr);
        final s = queue.isEmpty ? FakeSocket() : queue.removeAt(0);
        made.add(s);
        return s.channel;
      },
      // Gerçek 3 sn beklemek yeniden bağlanma testini yavaşlatırdı.
      reconnectDelay: const Duration(milliseconds: 5),
    ),
    adapter: adapter,
    sockets: made,
    dialed: dialed,
    headers: headers,
  );
}

/// activeLive, açık oturumun anlık görüntüsü.
ResponseBody activeLive(List<Map<String, dynamic>> updates) =>
    okEnvelope({'session': session('s1', 'active'), 'updates': updates});

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

  // İLK BAĞLANTIDA anlık görüntünün yayınlandığını doğrular.
  //
  // Yalnızca WebSocket dinlenseydi, sağımın ortasında açılan bir ekran ilk
  // güncelleme gelene kadar (nokta başına ~2 sn) boş kalırdı.
  test('bağlanınca önce anlık görüntü yayınlanır', () async {
    final r = rig(
      (o) async => activeLive([
        update(_spout1, '2026-09-22T06:10:00Z'),
        update(_spout2, '2026-09-22T06:10:00Z'),
      ]),
    );

    final got = await r.repo
        .watchSession('s1')
        .take(2)
        .map((u) => u.spoutId)
        .toList();

    expect(got, [_spout1, _spout2]);
    expect(r.adapter.requests.single.path, '/sessions/s1/live');
  });

  test('WebSocket güncellemeleri akışa düşer', () async {
    final socket = FakeSocket();
    final r = rig((o) async => activeLive([]), sockets: [socket]);

    final got = r.repo
        .watchSession('s1')
        .take(2)
        .map((u) => u.spoutId)
        .toList();

    await Future<void>.delayed(const Duration(milliseconds: 20));
    socket.send({
      'type': 'spout.update',
      ...update(_spout1, '2026-09-22T06:10:01Z'),
    });
    socket.send({
      'type': 'spout.update',
      ...update(_spout2, '2026-09-22T06:10:02Z'),
    });

    expect(await got, [_spout1, _spout2]);
  });

  // Token'ın BAŞLIKTA gittiğini doğrular.
  //
  // Sorgu dizesinde gitseydi sunucu loglarına ve proxy geçmişine düşerdi.
  test('token Authorization başlığıyla gönderilir', () async {
    final socket = FakeSocket();
    final r = rig(
      (o) async => activeLive([]),
      sockets: [socket],
      token: 'tok-1',
    );

    final done = r.repo.watchSession('s1').take(1).toList();
    await Future<void>.delayed(const Duration(milliseconds: 20));
    socket.send({
      'type': 'spout.update',
      ...update(_spout1, '2026-09-22T06:10:01Z'),
    });
    await done;

    expect(r.dialed.single, Uri.parse('ws://test/api/v1/ws?sessionId=s1'));
    expect(r.headers.single, {'Authorization': 'Bearer tok-1'});
  });

  // Oturum KAPANDIĞINDA akışın bittiğini doğrular.
  //
  // Duyuru olmadan telefon sessiz ama açık bir bağlantıda kalır ve canlı
  // ekran son kareyi sonsuza dek gösterirdi.
  test('session.ended akışı bitirir', () async {
    final socket = FakeSocket();
    final r = rig((o) async => activeLive([]), sockets: [socket]);

    final got = r.repo.watchSession('s1').toList();

    await Future<void>.delayed(const Duration(milliseconds: 20));
    socket.send({
      'type': 'spout.update',
      ...update(_spout1, '2026-09-22T06:10:01Z'),
    });
    socket.send({'type': 'session.ended', 'sessionId': 's1'});

    expect(await got, hasLength(1), reason: 'kapanıştan sonra yayın olmamalı');
    expect(socket.sinkClosed, isTrue, reason: 'bağlantı kapatılmalı');
  });

  // Zaten KAPANMIŞ bir oturuma bağlanılmadığını doğrular.
  test('oturum kapalıysa hiç bağlanılmaz', () async {
    final r = rig(
      (o) async => okEnvelope({
        'session': session('s1', 'ended'),
        'updates': [update(_spout1, '2026-09-22T06:10:00Z')],
      }),
    );

    expect(await r.repo.watchSession('s1').toList(), isEmpty);
    expect(r.dialed, isEmpty);
  });

  // KOPAN bağlantıda yeniden bağlanıldığını ve anlık görüntünün tekrar
  // çekildiğini doğrular.
  //
  // Kopukluk boyunca kaçırılan kareleri kurtarmaya çalışmak yerine tam
  // durumu okumak doğrusu — canlı veride en son değer geçerli olandır.
  test('kopan bağlantı yeniden kurulur ve görüntü tazelenir', () async {
    final first = FakeSocket();
    final second = FakeSocket();
    var snapshots = 0;
    final r = rig((o) async {
      snapshots++;
      return activeLive([
        update(
          _spout1,
          '2026-09-22T06:10:0$snapshots'
          'Z',
        ),
      ]);
    }, sockets: [first, second]);

    // Üçüncü olay YENİ bağlantıdan gelir; ikiyle yetinseydik akışın
    // yeniden bağlandığı değil yalnızca görüntüyü tazelediği doğrulanırdı.
    final got = r.repo
        .watchSession('s1')
        .take(3)
        .map((u) => u.spoutId)
        .toList();

    await Future<void>.delayed(const Duration(milliseconds: 20));
    first.drop();
    await Future<void>.delayed(const Duration(milliseconds: 40));
    second.send({
      'type': 'spout.update',
      ...update(_spout2, '2026-09-22T06:11:00Z'),
    });

    expect(await got, [_spout1, _spout1, _spout2]);
    expect(snapshots, 2, reason: 'her bağlanışta görüntü tazelenmeli');
    expect(r.dialed, hasLength(2));
  });

  // TANINMAYAN mesajın akışı düşürmediğini doğrular.
  //
  // Backend ileride uyarı gibi başka tipler yayınlayabilir; eski bir
  // uygulama sürümü onlar yüzünden canlı ekranı kaybetmemeli.
  test('tanınmayan mesaj yok sayılır', () async {
    final socket = FakeSocket();
    final r = rig((o) async => activeLive([]), sockets: [socket]);

    final got = r.repo
        .watchSession('s1')
        .take(1)
        .map((u) => u.spoutId)
        .toList();

    await Future<void>.delayed(const Duration(milliseconds: 20));
    socket.send({'type': 'alert.raised', 'alertId': 'al1'});
    socket._in.add('bozuk-json');
    socket.send({
      'type': 'spout.update',
      ...update(_spout1, '2026-09-22T06:10:01Z'),
    });

    expect(await got, [_spout1]);
  });

  // Oturum kimliği BOŞKEN hiçbir şey yapılmadığını doğrular.
  test('boş oturum kimliğinde ne istek ne bağlantı olur', () async {
    final r = rig((o) async => okEnvelope({}));

    expect(await r.repo.watchSession('').toList(), isEmpty);
    expect(r.adapter.requests, isEmpty);
    expect(r.dialed, isEmpty);
  });

  // Geçmiş sorgusunun tarih aralığını UTC olarak GÖNDERDİĞİNİ doğrular.
  //
  // Ekranlar Europe/Istanbul'da çalışıyor (§16); yerel gece yarısını olduğu
  // gibi göndermek backend'de üç saat kayık bir aralık sorgulamak olurdu.
  test('geçmiş sorgusu tarihleri UTC gönderir', () async {
    final r = rig((o) async => okEnvelope2([]));

    await r.repo.animalHistory(
      'a1',
      from: DateTime.utc(2026, 9, 1, 3),
      to: DateTime.utc(2026, 9, 22, 3),
    );

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
    final r = rig(
      (o) async => okEnvelope2([
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
        },
      ]),
    );

    final history = await r.repo.animalHistory('a1');

    expect(history.single.volumeMl, 9500);
    expect(history.single.color, MilkColor.yellow);
    expect(history.single.sessionType, 'evening');
  });

  test('trend parse edilir', () async {
    final r = rig(
      (o) async => okEnvelope({
        'animalId': 'a1',
        'yieldClass': 'declining',
        'ma7Ml': 17200,
        'ma30Ml': 21800,
        'trendSlope': -142.5,
        'daily': [
          {
            'date': '2026-09-21',
            'totalMl': 17000,
            'milkingCount': 2,
            'ma7Ml': 17200,
          },
        ],
      }),
    );

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
    final r = rig(
      (o) async =>
          okEnvelope({'animalId': 'a1', 'yieldClass': 'pregnant_hold'}),
    );

    expect((await r.repo.animalTrend('a1')).yieldClass, YieldClass.normal);
  });

  test('oturum listesi bölge ve aralıkla sorgulanır', () async {
    final r = rig((o) async => okEnvelope2([session('s1', 'ended')]));

    final sessions = await r.repo.sessions(
      hallId: _hallId,
      from: DateTime.utc(2026, 9, 1),
    );

    expect(sessions.single.status, 'ended');
    expect(r.adapter.requests.single.queryParameters, {
      'from': '2026-09-01T00:00:00.000Z',
      'hallId': _hallId,
    });
  });

  test('uyarılar parse edilir', () async {
    final r = rig(
      (o) async => okEnvelope2([
        {
          'id': 'al1',
          'animalId': 'a1',
          'type': 'low_flow',
          'severity': 'critical',
          'message': 'Benekli düşük debiyle sağılıyor.',
          'createdAt': '2026-09-22T06:14:00Z',
        },
      ]),
    );

    final alerts = await r.repo.alerts();

    expect(r.adapter.requests.single.path, '/alerts');
    expect(alerts.single.severity, 'critical');
    expect(alerts.single.isAcknowledged, isFalse);
  });

  // BİLİNMEYEN tür ve şiddetin parse'ı düşürmediğini doğrular.
  //
  // §8.4 bu sütunların alacağı değerleri saymıyor; kapalı bir enum yazmak,
  // backend yeni bir uyarı türü eklediğinde listenin komple kaybolması
  // demekti.
  test('bilinmeyen uyarı türü listeyi düşürmez', () async {
    final r = rig(
      (o) async => okEnvelope2([
        {
          'id': 'al1',
          'type': 'udder_temp',
          'severity': 'fatal',
          'message': 'x',
        },
      ]),
    );

    expect((await r.repo.alerts()).single.type, 'udder_temp');
  });

  test('okundu işareti POST edilir', () async {
    final r = rig((o) async => okEnvelope({}));

    await r.repo.ackAlert('al1');

    expect(r.adapter.requests.single.path, '/alerts/al1/ack');
    expect(r.adapter.requests.single.method, 'POST');
  });

  test('dashboard özeti parse edilir', () async {
    final r = rig(
      (o) async => okEnvelope({
        'date': '2026-09-22',
        'totalMl': 412300,
        'milkingCount': 28,
        'animalCount': 28,
        'activeSessions': 1,
        'openAlerts': 5,
        'bySpecies': [
          {'speciesId': 'sp1', 'totalMl': 380000, 'animalCount': 20},
          {'speciesId': 'sp2', 'totalMl': 32300, 'animalCount': 8},
        ],
        'classDistribution': [
          {'yieldClass': 'high', 'count': 3},
          {'yieldClass': 'dry_off_candidate', 'count': 2},
        ],
      }),
    );

    final d = await r.repo.dashboard();

    expect(r.adapter.requests.single.path, '/dashboard');
    expect(d.totalMl, 412300);
    expect(d.bySpecies, hasLength(2));
    expect(d.classDistribution.last.yieldClass, YieldClass.dryOffCandidate);
  });

  // Eksik alanların özeti düşürmediğini doğrular: backend bir alanı
  // göndermezse dashboard boş değil, o satırı eksik gösterir.
  test('eksik alanlar varsayılana düşer', () async {
    final r = rig((o) async => okEnvelope({'totalMl': 1000}));

    final d = await r.repo.dashboard();

    expect(d.totalMl, 1000);
    expect(d.openAlerts, 0);
    expect(d.classDistribution, isEmpty);
  });

  // Push jetonu uçları (VARSAYIM: §8.5 bunları listelemiyor, `notification`
  // servisi yazılırken doğrulanmalı).
  test('push jetonu kaydedilir', () async {
    final r = rig((o) async => okEnvelope({}));

    await r.repo.registerPushToken(token: 'tok-1', platform: 'android');

    final req = r.adapter.requests.single;
    expect(req.path, '/me/push-tokens');
    expect(req.method, 'POST');
    expect(req.data, {'token': 'tok-1', 'platform': 'android'});
  });

  // Test bildirimi (backend ADR 0048): kabul edilen telefon sayısı döner.
  test('test bildirimi gönderilir', () async {
    final r = rig((o) async => okEnvelope({'sent': 2, 'invalid': 0}));

    expect(await r.repo.sendTestPush(), 2);
    expect(r.adapter.requests.single.path, '/me/push-tokens/test');
    expect(r.adapter.requests.single.method, 'POST');
  });

  // Hayvan formu: ekleme POST, düzenleme PUT (tam kayıt). Gövdede kimlik ve
  // verim sınıfı YOK; tarihler gün olarak; boş alanlar null (backend ADR 0049).
  test('hayvan eklenir ve düzenlenir', () async {
    final r = rig(
      (o) async => okEnvelope({
        'id': 'a1',
        'speciesId': 'sp1',
        'earTag': 'TR1',
        'lactationNo': 2,
        'status': 'dry',
      }),
    );

    final draft = Animal(
      id: '',
      speciesId: 'sp1',
      earTag: 'TR1',
      birthDate: DateTime(2021, 3, 5, 14, 30),
      lactationNo: 2,
      status: 'dry',
      yieldClass: YieldClass.high,
    );
    final saved = await r.repo.saveAnimal(draft);
    expect(saved.id, 'a1');

    final post = r.adapter.requests.single;
    expect(post.method, 'POST');
    expect(post.path, '/animals');
    final body = post.data as Map<String, dynamic>;
    expect(body.containsKey('id'), isFalse);
    expect(body.containsKey('yieldClass'), isFalse, reason: 'gece hesabının alanı');
    expect(body['birthDate'], '2021-03-05T00:00:00.000Z');
    expect(body['rfid'], isNull);
    expect(body['status'], 'dry');

    await r.repo.saveAnimal(draft.copyWith(id: 'a1'));
    expect(r.adapter.requests.last.method, 'PUT');
    expect(r.adapter.requests.last.path, '/animals/a1');
  });

  test('push jetonu silinir', () async {
    final r = rig((o) async => okEnvelope({}));

    await r.repo.unregisterPushToken('tok-1');

    expect(r.adapter.requests.single.path, '/me/push-tokens/tok-1');
    expect(r.adapter.requests.single.method, 'DELETE');
  });

  // Eşik güncellemesinin TAM NESNE ile PUT edildiğini doğrular.
  //
  // Kısmi güncelleme, iki kullanıcı aynı anda kaydettiğinde hangi alanın
  // kazandığını belirsiz bırakırdı.
  test('eşikler tam nesne olarak PUT edilir', () async {
    final r = rig(
      (o) async => okEnvelope({
        'speciesId': 'sp1',
        'flowLow': 1.2,
        'flowHigh': 2.5,
        'dryOffDailyMl': 9000,
      }),
    );

    final saved = await r.repo.updateThresholds(
      const Thresholds(
        speciesId: 'sp1',
        flowLow: 1.2,
        flowHigh: 2.5,
        dryOffDailyMl: 9000,
      ),
    );

    final req = r.adapter.requests.single;
    expect(req.path, '/species/thresholds');
    expect(req.method, 'PUT');
    expect((req.data as Map)['speciesId'], 'sp1');
    expect((req.data as Map)['flowLow'], 1.2);

    // Dönen kayıt SUNUCUNUNKİ: backend değerleri normalize edebilir ve
    // ekran kendi yazdığını doğru sanmamalı.
    expect(saved.dryOffDailyMl, 9000);
  });

  // ------------------------------------------------- sağım kontrolü --

  test('sağım başlatılır', () async {
    final r = rig((o) async => okEnvelope(session('yeni', 'active')));

    final v = await r.repo.startSession(hallId: _hallId, type: 'morning');

    final req = r.adapter.requests.single;
    expect(req.path, '/sessions');
    expect(req.method, 'POST');
    expect(req.data, {'hallId': _hallId, 'type': 'morning'});
    expect(v.status, 'active');
  });

  test('hayvan noktaya eşleştirilir', () async {
    final r = rig((o) async => okEnvelope({}));

    await r.repo.assignAnimal(
      sessionId: 's1',
      spoutId: _spout1,
      animalId: 'a1',
    );

    final req = r.adapter.requests.single;
    expect(req.path, '/sessions/s1/spouts/$_spout1/animal');
    expect(req.method, 'PUT');
    expect(req.data, {'animalId': 'a1'});
  });

  test('sağım bitirilir', () async {
    final r = rig((o) async => okEnvelope(session('s1', 'ended')));

    final v = await r.repo.endSession('s1');

    expect(r.adapter.requests.single.path, '/sessions/s1/end');
    expect(r.adapter.requests.single.method, 'POST');
    expect(v.status, 'ended');
  });

  // Backend'in TÜRKÇE hatasının yukarı taşındığını doğrular (§16).
  //
  // "bu bölgede zaten açık bir sağım oturumu var" cevabını kendi metnimizle
  // değiştirmek, kullanıcının gerçek sebebi görmesini engellerdi.
  test('çakışan sağım hatası olduğu gibi yukarı taşınır', () async {
    final r = rig(
      (o) async => errEnvelope(
        409,
        'CONFLICT',
        'bu bölgede zaten açık bir sağım oturumu var',
      ),
    );

    await expectLater(
      r.repo.startSession(hallId: _hallId, type: 'morning'),
      throwsA(isA<DioException>()),
    );
  });
}
