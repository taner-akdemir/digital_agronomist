import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/cache/cache_store.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/repositories/caching_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/domain/yield_class.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

/// Ağı açılıp kapanabilen iç depo.
class _Net extends MockRepository {
  _Net() : super(latency: Duration.zero, loadAsset: _disk);

  /// null: çevrimiçi; dolu: bu hata fırlatılır.
  Object? failure;

  Future<T> _gate<T>(Future<T> Function() f) async {
    if (failure case final e?) throw e;
    return f();
  }

  @override
  Future<List<Animal>> animals() => _gate(super.animals);

  @override
  Future<LiveSession> liveSession({required String hallId}) =>
      _gate(() => super.liveSession(hallId: hallId));

  @override
  Future<void> ackAlert(String alertId) => _gate(() => super.ackAlert(alertId));
}

DioException _offline() => DioException(
  requestOptions: RequestOptions(path: '/x'),
  type: DioExceptionType.connectionError,
);

void main() {
  late _Net net;
  late MemoryCacheStore store;
  late List<DateTime?> events; // offline(at) → at, online → null
  var clock = DateTime.utc(2026, 9, 25, 6, 0);

  CachingRepository repo({String scope = 'mtcache:v1:t1:u1:'}) =>
      CachingRepository(
        inner: net,
        store: store,
        scope: scope,
        onOffline: events.add,
        onOnline: () => events.add(null),
        now: () => clock,
      );

  setUp(() {
    net = _Net();
    store = MemoryCacheStore();
    events = [];
    clock = DateTime.utc(2026, 9, 25, 6, 0);
  });

  test('çevrimdışıyken son veri ve anı döner', () async {
    final r = repo();
    final online = await r.animals();
    expect(events, [null]);

    net.failure = _offline();
    clock = DateTime.utc(2026, 9, 25, 9, 0);
    final cached = await r.animals();
    expect(cached, online);
    expect(events.last, DateTime.utc(2026, 9, 25, 6, 0), reason: 'verinin anı');

    net.failure = null;
    await r.animals();
    expect(events.last, isNull, reason: 'bağlantı döndü');
  });

  test('önbellek yoksa ağ hatası yukarı çıkar', () async {
    net.failure = _offline();
    await expectLater(repo().animals(), throwsA(isA<DioException>()));
  });

  test('sunucu hatası önbellekle örtülmez', () async {
    final r = repo();
    await r.animals();
    net.failure = DioException(
      requestOptions: RequestOptions(path: '/x'),
      type: DioExceptionType.badResponse,
      response: Response(
        requestOptions: RequestOptions(path: '/x'),
        statusCode: 500,
      ),
    );
    await expectLater(r.animals(), throwsA(isA<DioException>()));
  });

  test('yazma çevrimdışıyken hata verir, önbelleğe düşmez', () async {
    net.failure = _offline();
    await expectLater(repo().ackAlert('a1'), throwsA(isA<DioException>()));
    expect(store.values, isEmpty);
  });

  test('başka kullanıcının önbelleği görünmez', () async {
    await repo().animals();
    net.failure = _offline();
    await expectLater(
      repo(scope: 'mtcache:v1:t1:u2:').animals(),
      throwsA(isA<DioException>()),
    );
  });

  test('canlı kare ve hayvan alanları kayıpsız saklanır', () async {
    final r = repo();
    final live = await r.liveSession(hallId: 'h');
    final a = (await r.animals()).first;
    // Donmuş sınıfın tarihi de korunmalı (ADR 0055).
    final withClass = a.copyWith(
      yieldClass: YieldClass.high,
      yieldClassAt: DateTime.utc(2026, 9, 12),
    );
    await store.write(
      'mtcache:v1:t1:u1:animals',
      (await store.read('mtcache:v1:t1:u1:animals'))!.replaceFirst(
        '"yieldClassAt":null',
        '"yieldClassAt":"2026-09-12T00:00:00.000Z"',
      ),
    );

    net.failure = _offline();
    final cachedLive = await r.liveSession(hallId: 'h');
    expect(cachedLive, live);
    expect(
      cachedLive.updates.whereType<SpoutUpdate>().any(
        (u) => u.unmatchedTag != null,
      ),
      isTrue,
      reason: 'tanınmayan küpe de önbellekte',
    );
    final cachedAnimal = (await r.animals()).first;
    expect(cachedAnimal.yieldClassAt, withClass.yieldClassAt);
  });

  test('önbellek öneki çıkışta silinir', () async {
    await repo().animals();
    await store.write('başka', 'kalır');
    await store.clear('mtcache:v1:');
    expect(store.values.keys, ['başka']);
  });
}
