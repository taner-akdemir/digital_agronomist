import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/cache/cache_store.dart';
import 'package:milktrace/data/models/alert.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_import.dart';
import 'package:milktrace/data/models/animal_milking.dart';
import 'package:milktrace/data/models/animal_note.dart';
import 'package:milktrace/data/models/animal_trend.dart';
import 'package:milktrace/data/models/dashboard_summary.dart';
import 'package:milktrace/data/models/device.dart';
import 'package:milktrace/data/models/farm.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/notification_channel.dart';
import 'package:milktrace/data/models/session_milking.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/spout.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/data/models/unmatched_tag_row.dart';
import 'package:milktrace/data/models/vacuum.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';

/// Ağ hatası mı: sunucuya ULAŞILAMADI (bağlantı, zaman aşımı). Sunucunun
/// verdiği hata (403, 422, 500) değil: onları önbellekle örtmek, kullanıcıya
/// eski veriyi "doğru" diye göstermek olurdu.
///
/// 502/503/504 de ulaşılamama sayılır: gateway "servise şu anda
/// ulaşılamıyor" diyor, verinin kendisi hakkında bir yargı yok. Sahada
/// gateway ya da servis yeniden başlarken ekranın boşalmaması gerekiyor
/// (cihazda bulundu).
bool isNetworkError(Object e) => switch (e) {
  DioException(:final type, :final response) =>
    type == DioExceptionType.connectionError ||
        type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.sendTimeout ||
        type == DioExceptionType.receiveTimeout ||
        _unavailable(response?.statusCode),
  ApiException(:final code, :final status) =>
    (code == 'NETWORK' && status == null) || _unavailable(status),
  _ => false,
};

bool _unavailable(int? status) =>
    status == 502 || status == 503 || status == 504;

/// Çevrimdışı okuma önbelleği (§18/7, ürün kararı "son veriyi göster").
///
/// OKUMALAR: sunucudan gelen her cevap cihaza yazılır; sunucuya
/// ulaşılamazsa son cevap döner ve [onOffline] o verinin anıyla çağrılır.
/// Hiç önbellek yoksa hata olduğu gibi yukarı çıkar.
///
/// YAZMALAR (eşleştirme, not, buzağılama…) önbelleğe ALINMAZ ve kuyruğa
/// konmaz: çevrimdışıyken hata verir. Kuyruk, iki telefonun aynı noktaya
/// farklı hayvan bağlaması gibi çakışmaları sonradan çözmeyi gerektirirdi;
/// ürün kararı bunu şimdilik dışarıda bıraktı.
///
/// Canlı akış (WebSocket) önbelleklenmez: kendi yeniden bağlanma döngüsü
/// var; tahta son anlık görüntüyle açılır.
///
/// Anahtarlar kullanıcı ve işletmeye göre ayrılır ([scope]): aynı telefonda
/// başka bir hesapla giriş, öncekinin verisini görmemeli.
class CachingRepository implements MilkTraceRepository {
  CachingRepository({
    required this._inner,
    required this._store,
    required this._scope,
    required this._onOffline,
    required this._onOnline,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final MilkTraceRepository _inner;
  final CacheStore _store;
  final String _scope;
  final void Function(DateTime) _onOffline;
  final void Function() _onOnline;
  final DateTime Function() _now;

  Future<T> _read<T>(
    String key,
    Future<T> Function() fetch,
    T Function(Object? json) decode,
  ) async {
    final k = '$_scope$key';
    try {
      final v = await fetch();
      _onOnline();
      await _store.write(
        k,
        jsonEncode({'at': _now().toUtc().toIso8601String(), 'v': v}),
      );
      return v;
    } catch (e) {
      if (!isNetworkError(e)) rethrow;
      final raw = await _store.read(k);
      if (raw == null) rethrow;
      final m = jsonDecode(raw) as Map<String, dynamic>;
      final v = decode(m['v']);
      _onOffline(DateTime.parse(m['at'] as String));
      return v;
    }
  }

  /// Yazma ve önbelleksiz okuma: başarı bağlantının döndüğünü söyler.
  Future<T> _net<T>(Future<T> Function() call) async {
    final v = await call();
    _onOnline();
    return v;
  }

  static List<T> _list<T>(
    Object? json,
    T Function(Map<String, dynamic>) fromJson,
  ) => [for (final e in json! as List) fromJson(e as Map<String, dynamic>)];

  static Map<String, dynamic> _map(Object? json) =>
      json! as Map<String, dynamic>;

  static String _day(DateTime? d) =>
      d == null ? '' : d.toUtc().toIso8601String();

  // ------------------------------------------------------ önbellekli okumalar

  @override
  Future<List<Species>> species() =>
      _read('species', _inner.species, (j) => _list(j, Species.fromJson));

  @override
  Future<List<Thresholds>> thresholds() => _read(
    'thresholds',
    _inner.thresholds,
    (j) => _list(j, Thresholds.fromJson),
  );

  @override
  Future<List<Farm>> farms() =>
      _read('farms', _inner.farms, (j) => _list(j, Farm.fromJson));

  @override
  Future<List<Hall>> halls() =>
      _read('halls', _inner.halls, (j) => _list(j, Hall.fromJson));

  @override
  Future<List<Vacuum>> vacuums({String? hallId}) => _read(
    'vacuums:${hallId ?? ''}',
    () => _inner.vacuums(hallId: hallId),
    (j) => _list(j, Vacuum.fromJson),
  );

  @override
  Future<List<Spout>> spouts({String? vacuumId}) => _read(
    'spouts:${vacuumId ?? ''}',
    () => _inner.spouts(vacuumId: vacuumId),
    (j) => _list(j, Spout.fromJson),
  );

  @override
  Future<List<Device>> devices() =>
      _read('devices', _inner.devices, (j) => _list(j, Device.fromJson));

  @override
  Future<List<Animal>> animals() =>
      _read('animals', _inner.animals, (j) => _list(j, Animal.fromJson));

  @override
  Future<List<AnimalNote>> animalNotes(String animalId) => _read(
    'notes:$animalId',
    () => _inner.animalNotes(animalId),
    (j) => _list(j, AnimalNote.fromJson),
  );

  @override
  Future<LiveSession> liveSession({required String hallId}) => _read(
    'live:$hallId',
    () => _inner.liveSession(hallId: hallId),
    (j) => LiveSession.fromJson(_map(j)),
  );

  @override
  Future<List<MilkingSession>> sessions({
    String? hallId,
    DateTime? from,
    DateTime? to,
  }) => _read(
    'sessions:${hallId ?? ''}:${_day(from)}:${_day(to)}',
    () => _inner.sessions(hallId: hallId, from: from, to: to),
    (j) => _list(j, MilkingSession.fromJson),
  );

  @override
  Future<List<AnimalMilking>> animalHistory(
    String animalId, {
    DateTime? from,
    DateTime? to,
  }) => _read(
    'history:$animalId:${_day(from)}:${_day(to)}',
    () => _inner.animalHistory(animalId, from: from, to: to),
    (j) => _list(j, AnimalMilking.fromJson),
  );

  @override
  Future<List<SessionMilking>> sessionMilkings(String sessionId) => _read(
    'milkings:$sessionId',
    () => _inner.sessionMilkings(sessionId),
    (j) => _list(j, SessionMilking.fromJson),
  );

  @override
  Future<AnimalTrend> animalTrend(String animalId) => _read(
    'trend:$animalId',
    () => _inner.animalTrend(animalId),
    (j) => AnimalTrend.fromJson(_map(j)),
  );

  @override
  Future<DashboardSummary> dashboard() => _read(
    'dashboard',
    _inner.dashboard,
    (j) => DashboardSummary.fromJson(_map(j)),
  );

  @override
  Future<List<Alert>> alerts() =>
      _read('alerts', _inner.alerts, (j) => _list(j, Alert.fromJson));

  @override
  Future<List<UnmatchedTagRow>> unmatchedTags() => _read(
    'unmatched',
    _inner.unmatchedTags,
    (j) => _list(j, UnmatchedTagRow.fromJson),
  );

  // --------------------------------------------- yazmalar ve önbelleksizler

  @override
  Future<Animal> saveAnimal(Animal animal) =>
      _net(() => _inner.saveAnimal(animal));

  @override
  Future<void> dismissUnmatchedTag(String rfid) =>
      _net(() => _inner.dismissUnmatchedTag(rfid));

  @override
  Future<AnimalNote> addAnimalNote(String animalId, String note) =>
      _net(() => _inner.addAnimalNote(animalId, note));

  /// Önbelleklenmez: dosya her seferinde güncel üretilmeli; çevrimdışıyken
  /// eski raporu yeni diye paylaşmak yanıltıcı olurdu.
  @override
  Future<ReportFile> yieldReport({DateTime? from, DateTime? to}) =>
      _net(() => _inner.yieldReport(from: from, to: to));

  @override
  Future<AnimalImportReport> importAnimals(
    List<int> file, {
    String? speciesId,
    required bool dryRun,
  }) => _net(
    () => _inner.importAnimals(file, speciesId: speciesId, dryRun: dryRun),
  );

  @override
  Future<Animal> recordCalving(String animalId, DateTime date) =>
      _net(() => _inner.recordCalving(animalId, date));

  @override
  Future<Thresholds> updateThresholds(Thresholds thresholds) =>
      _net(() => _inner.updateThresholds(thresholds));

  @override
  Future<MilkingSession> startSession({
    required String hallId,
    required String type,
  }) => _net(() => _inner.startSession(hallId: hallId, type: type));

  @override
  Future<void> assignAnimal({
    required String sessionId,
    required String spoutId,
    required String animalId,
  }) => _net(
    () => _inner.assignAnimal(
      sessionId: sessionId,
      spoutId: spoutId,
      animalId: animalId,
    ),
  );

  @override
  Future<void> unassignAnimal({
    required String sessionId,
    required String spoutId,
  }) =>
      _net(() => _inner.unassignAnimal(sessionId: sessionId, spoutId: spoutId));

  @override
  Future<MilkingSession> endSession(String sessionId) =>
      _net(() => _inner.endSession(sessionId));

  /// Canlı akıştan gelen her kare sunucuya ulaşıldığını söyler: gateway
  /// dönünce canlı tahtada oturan kullanıcı başka bir ekrana geçmeden
  /// "çevrimdışı" bandı kalkmalı (cihazda denenerek bulundu).
  @override
  Stream<SpoutUpdate> watchSession(String sessionId) =>
      _inner.watchSession(sessionId).map((u) {
        _onOnline();
        return u;
      });

  @override
  Future<void> registerPushToken({
    required String token,
    required String platform,
  }) => _net(() => _inner.registerPushToken(token: token, platform: platform));

  @override
  Future<void> unregisterPushToken(String token) =>
      _net(() => _inner.unregisterPushToken(token));

  @override
  Future<int> sendTestPush() => _net(_inner.sendTestPush);

  // Bildirim kanalları yalnızca işletme sahibinin ayar ekranı; sahada
  // çevrimdışı görülmeleri gerekmiyor ve sır durumu taşıyorlar.
  @override
  Future<List<NotificationProvider>> notificationProviders() =>
      _net(_inner.notificationProviders);

  @override
  Future<List<NotificationChannel>> notificationChannels() =>
      _net(_inner.notificationChannels);

  @override
  Future<NotificationChannel> createNotificationChannel(
    NotificationChannelDraft draft,
  ) => _net(() => _inner.createNotificationChannel(draft));

  @override
  Future<NotificationChannel> updateNotificationChannel(
    String id,
    NotificationChannelDraft draft,
  ) => _net(() => _inner.updateNotificationChannel(id, draft));

  @override
  Future<void> deleteNotificationChannel(String id) =>
      _net(() => _inner.deleteNotificationChannel(id));

  @override
  Future<void> testNotificationChannel(String id) =>
      _net(() => _inner.testNotificationChannel(id));

  @override
  Future<void> ackAlert(String alertId) => _net(() => _inner.ackAlert(alertId));
}
