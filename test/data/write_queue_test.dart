import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/cache/cache_store.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_note.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/breeding.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/data/write_queue/pending_write.dart';
import 'package:milktrace/data/write_queue/write_sender.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/offline_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/providers/write_queue_providers.dart';

/// Ağ hatası: sunucuya hiç ulaşılamadı.
DioException netErr() => DioException(
  requestOptions: RequestOptions(path: '/x'),
  type: DioExceptionType.connectionError,
);

/// Sunucunun zarfıyla dönen HTTP hatası.
DioException httpErr(int status, {String code = 'X', String msg = 'hata'}) {
  final o = RequestOptions(path: '/x');
  return DioException(
    requestOptions: o,
    type: DioExceptionType.badResponse,
    response: Response<dynamic>(
      requestOptions: o,
      statusCode: status,
      data: {
        'success': false,
        'error': {'code': code, 'message': msg},
      },
    ),
  );
}

/// Yazma uçlarını senaryoyla yanıtlayan depo: her çağrı [script]'ten bir
/// hata alır (null → başarı) ve kaydedilir.
class _Repo extends MockRepository {
  _Repo() : super(latency: Duration.zero);

  final List<Object?> script = [];
  final calls = <({String what, String? key})>[];

  Future<void> _step(String what, String? key) async {
    calls.add((what: what, key: key));
    final e = script.isEmpty ? null : script.removeAt(0);
    if (e != null) throw e;
  }

  @override
  Future<AnimalNote> addAnimalNote(
    String animalId,
    String note, {
    String? idempotencyKey,
  }) async {
    await _step('note:$note', idempotencyKey);
    return AnimalNote(
      id: 'n',
      animalId: animalId,
      note: note,
      createdAt: DateTime.utc(2026, 10, 18),
    );
  }

  @override
  Future<BreedingEvent> addBreeding(
    String animalId, {
    required String kind,
    required DateTime date,
    String sire = '',
    String? result,
    String note = '',
    String? idempotencyKey,
  }) async {
    await _step('breeding:$kind', idempotencyKey);
    throw UnimplementedError('dönüş değeri testte okunmaz');
  }

  @override
  Future<Animal> recordCalving(
    String animalId,
    DateTime date, {
    String? idempotencyKey,
  }) async {
    await _step('calving', idempotencyKey);
    throw UnimplementedError('dönüş değeri testte okunmaz');
  }
}

class _Auth extends Auth {
  _Auth(this.initial);

  final AuthState initial;

  @override
  AuthState build() => initial;

  void become(String tenant, String user) => state = signedIn(tenant, user);
}

AuthState signedIn(String tenant, String user) => AuthState(
  status: AuthStatus.signedIn,
  user: AuthUser(
    id: user,
    email: '$user@x.tr',
    fullName: user,
    role: 'tenant_operator',
    tenantId: tenant,
  ),
);

class _Rig {
  _Rig({MemoryCacheStore? store, AuthState? auth})
    : store = store ?? MemoryCacheStore(),
      auth = _Auth(auth ?? signedIn('t1', 'u1'));

  final MemoryCacheStore store;
  final repo = _Repo();
  final _Auth auth;
  DateTime now = DateTime.utc(2026, 10, 18, 6);

  late final container = ProviderContainer(
    overrides: [
      cacheStoreProvider.overrideWithValue(store),
      repositoryProvider.overrideWithValue(repo),
      authProvider.overrideWith(() => auth),
      writeQueueClockProvider.overrideWithValue(() => now),
    ],
  );

  WriteQueue get queue => container.read(writeQueueProvider.notifier);
  List<PendingWrite> get items => container.read(writeQueueProvider);

  Future<void> start() async {
    // Uygulamada gösterge izler; izleyen olmazsa oturum değişimi tembel kurulur.
    container.listen(writeQueueProvider, (_, _) {});
    await pumpEventQueue();
  }

  Future<WriteResult> note(String text, {String animal = 'a1'}) => queue.submit(
    kind: PendingKind.note,
    animalId: animal,
    payload: PendingPayload.note(text),
  );

  /// İlk gönderim ağ hatasıyla düşer, kayıt kuyruğa girer.
  Future<PendingWrite> queued(String text) async {
    repo.script.add(netErr());
    final r = await note(text);
    return (r as WriteQueued).item;
  }
}

/// Bir tutucu: hatayı yutup türünü döner.
Future<Object?> caught(Future<Object?> f) async {
  try {
    await f;
    return null;
  } catch (e) {
    return e;
  }
}

void main() {
  late _Rig r;

  setUp(() async {
    r = _Rig();
    await r.start();
  });

  tearDown(() => r.container.dispose());

  test('sunucuya ulaşılınca doğrudan gönderilir, kuyruk boş kalır', () async {
    final res = await r.note('Mastitis');
    expect(res, isA<WriteSent>());
    expect(r.items, isEmpty);
    expect(r.repo.calls.single.key, isNotNull);
  });

  test('ağ hatasında kuyruğa girer ve diske yazılır', () async {
    final w = await r.queued('Topallık');
    expect(w.isPending, isTrue);
    expect(r.items.single.id, w.id);
    final raw = r.store.values['mtqueue:v1:t1:u1']!;
    expect((jsonDecode(raw) as List).single['id'], w.id);
  });

  test('4xx doğrudan gönderimde kuyruğa GİRMEZ, hata ekrana çıkar', () async {
    r.repo.script.add(httpErr(400, msg: 'not boş olamaz'));
    expect(await caught(r.note('')), isA<DioException>());
    expect(r.items, isEmpty);
  });

  test('kuyruk uygulama yeniden açılınca diskten geri gelir', () async {
    final w = await r.queued('A');
    final again = _Rig(store: r.store);
    // Açılışta boşaltma denenir; bağlantı hâlâ yok.
    again.repo.script.add(netErr());
    await again.start();
    expect(again.items.single.id, w.id);
    expect(again.items.single.payload, {'note': 'A'});
    again.container.dispose();
  });

  test('sırayla (FIFO) ve her denemede AYNI Idempotency-Key ile', () async {
    final a = await r.queued('A');
    final b = await r.queued('B');
    r.repo.calls.clear();
    await r.queue.flush();
    expect(r.repo.calls.map((c) => c.what), ['note:A', 'note:B']);
    expect(r.repo.calls.map((c) => c.key), [a.id, b.id]);
    expect(r.items, isEmpty);
  });

  test('ağ hatası boşaltmayı durdurur, sıra korunur', () async {
    await r.queued('A');
    await r.queued('B');
    r.repo.calls.clear();
    r.repo.script.add(netErr());
    await r.queue.flush();
    expect(r.repo.calls.map((c) => c.what), ['note:A']);
    expect(r.items.map((w) => w.payload['note']), ['A', 'B']);
    expect(r.items.first.attempts, 1);
    expect(r.items.first.serverErrors, 0);
  });

  test('4xx gönderilemeyenlere düşer, sıradaki gönderilir', () async {
    await r.queued('A');
    await r.queued('B');
    r.repo.script.add(httpErr(422, msg: 'hayvan bulunamadı'));
    await r.queue.flush();
    expect(r.items.single.payload['note'], 'A');
    expect(r.items.single.isFailed, isTrue);
    expect(r.items.single.failure, PendingFailure.rejected);
    expect(r.items.single.error, 'hayvan bulunamadı');
  });

  test('5xx artan beklemeyle yeniden denenir, 8. hatada bırakılır', () async {
    final w = await r.queued('A');
    r.repo.script.add(httpErr(500));
    await r.queue.flush();
    var head = r.items.single;
    expect(head.isPending, isTrue);
    expect(head.serverErrors, 1);
    expect(head.nextAttemptAt, r.now.add(const Duration(seconds: 15)));

    // Bekleme dolmadan deneme yok.
    r.repo.calls.clear();
    await r.queue.flush();
    expect(r.repo.calls, isEmpty);

    for (var i = 2; i <= writeQueueMaxServerErrors; i++) {
      r.repo.script.add(httpErr(500));
      await r.queue.flush(force: true);
    }
    head = r.items.single;
    expect(head.id, w.id);
    expect(head.isFailed, isTrue);
    expect(head.failure, PendingFailure.retries);
  });

  test('401 boşaltmayı durdurur, kayda dokunmaz', () async {
    await r.queued('A');
    r.repo.script.add(httpErr(401));
    await r.queue.flush();
    expect(r.items.single.isPending, isTrue);
    expect(r.items.single.serverErrors, 0);
  });

  test('buzağılamada 409: hedef durum sunucuda, teslim sayılır', () async {
    r.repo.script.add(netErr());
    await r.queue.submit(
      kind: PendingKind.calving,
      animalId: 'a1',
      payload: PendingPayload.calving(DateTime(2026, 10, 17)),
    );
    r.repo.script.add(httpErr(409, msg: 'bu güne buzağılama girilmiş'));
    await r.queue.flush();
    expect(r.items, isEmpty);
    expect(r.container.read(writeQueueDeliveredProvider), 1);
  });

  test('bağlantı dönünce (bir istek sunucuya ulaşınca) boşaltılır', () async {
    await r.queued('A');
    r.container.read(offlineStatusProvider.notifier).offline(r.now);
    r.container.read(offlineStatusProvider.notifier).online();
    await pumpEventQueue();
    expect(r.items, isEmpty);
  });

  test('kuyruk kullanıcı ve işletmeye göre ayrı', () async {
    await r.queued('t1-u1');
    r.auth.become('t2', 'u1');
    await pumpEventQueue();
    expect(r.items, isEmpty, reason: 't2 kuyruğu ayrı');
    await r.queued('t2-u1');

    r.auth.become('t1', 'u2');
    await pumpEventQueue();
    expect(r.items, isEmpty, reason: 'başka kullanıcı görmez');

    r.repo.script.add(netErr());
    r.auth.become('t1', 'u1');
    await pumpEventQueue();
    expect(r.items.single.payload['note'], 't1-u1');
    expect(
      r.store.values.keys,
      containsAll(['mtqueue:v1:t1:u1', 'mtqueue:v1:t2:u1']),
    );
  });

  test('girişsiz kuyruk yok; ağ hatası olduğu gibi atılır', () async {
    final out = _Rig(auth: AuthState.signedOut);
    await out.start();
    out.repo.script.add(netErr());
    expect(await caught(out.note('A')), isA<DioException>());
    out.container.dispose();
  });

  test('7 günden eski bekleyen gönderilmez, süresi doldu', () async {
    await r.queued('A');
    r.now = r.now.add(const Duration(days: 8));
    r.repo.calls.clear();
    await r.queue.flush();
    expect(r.repo.calls, isEmpty);
    expect(r.items.single.failure, PendingFailure.expired);

    // Yeniden dene: süresi tazelenir ve gönderilir.
    await r.queue.retry(r.items.single.id);
    expect(r.items, isEmpty);
  });

  test('gönderilemeyen 30 gün sonra silinir', () async {
    await r.queued('A');
    r.repo.script.add(httpErr(400));
    await r.queue.flush();
    expect(r.items.single.isFailed, isTrue);
    r.now = r.now.add(const Duration(days: 31));
    await r.queue.flush();
    expect(r.items, isEmpty);
  });

  test('200 kayıt sınırı', () async {
    final full = [
      for (var i = 0; i < writeQueueMaxItems; i++)
        PendingWrite(
          id: 'w$i',
          kind: PendingKind.note,
          animalId: 'a1',
          payload: const {'note': 'x'},
          createdAt: r.now,
          state: PendingState.failed,
          failure: PendingFailure.rejected,
          failedAt: r.now,
        ).toJson(),
    ];
    final big = _Rig()..store.values['mtqueue:v1:t1:u1'] = jsonEncode(full);
    await big.start();
    big.repo.script.add(netErr());
    final e = await caught(big.note('fazla'));
    expect(e, isA<ApiException>());
    expect((e! as ApiException).code, 'QUEUE_FULL');
    big.container.dispose();
  });

  test('sil ve hepsini temizle', () async {
    final a = await r.queued('A');
    await r.queued('B');
    await r.queue.discard(a.id);
    expect(r.items.single.payload['note'], 'B');
    await r.queue.clear();
    expect(r.items, isEmpty);
    expect(jsonDecode(r.store.values['mtqueue:v1:t1:u1']!), isEmpty);
  });

  group('hata sınıflandırması', () {
    final note = PendingWrite(
      id: 'k',
      kind: PendingKind.note,
      createdAt: DateTime.utc(2026),
    );
    final heat = note.copyWith(
      kind: PendingKind.breeding,
      payload: {'kind': 'heat'},
    );
    final insem = note.copyWith(
      kind: PendingKind.breeding,
      payload: {'kind': 'insemination'},
    );

    test('ağ ve 502/503/504 → ağ', () {
      expect(classifyWriteError(netErr(), note), WriteOutcome.retryNetwork);
      expect(classifyWriteError(httpErr(503), note), WriteOutcome.retryNetwork);
    });

    test('500, 408, 429 → sunucu (artan bekleme)', () {
      for (final s in [500, 408, 429]) {
        expect(classifyWriteError(httpErr(s), note), WriteOutcome.retryServer);
      }
    });

    test('401 → dur; 400/403/422 → reddedildi', () {
      expect(classifyWriteError(httpErr(401), note), WriteOutcome.unauthorized);
      for (final s in [400, 403, 404, 422]) {
        expect(classifyWriteError(httpErr(s), note), WriteOutcome.rejected);
      }
    });

    test('409: kızgınlık teslim, tohumlama reddedildi, sürüyor → bekle', () {
      expect(classifyWriteError(httpErr(409), heat), WriteOutcome.delivered);
      expect(classifyWriteError(httpErr(409), insem), WriteOutcome.rejected);
      expect(
        classifyWriteError(httpErr(409, code: 'IDEMPOTENCY_IN_PROGRESS'), note),
        WriteOutcome.retryServer,
      );
    });

    test('artan bekleme 15 sn ile başlar, 15 dk ile sınırlı', () {
      expect(retryBackoff(1), const Duration(seconds: 15));
      expect(retryBackoff(3), const Duration(minutes: 1));
      expect(retryBackoff(20), const Duration(minutes: 15));
    });

    test('anahtar UUID v4 ve her seferinde farklı', () {
      final a = newIdempotencyKey();
      expect(
        a,
        matches(
          RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          ),
        ),
      );
      expect(newIdempotencyKey(), isNot(a));
    });
  });
}
