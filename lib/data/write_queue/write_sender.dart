import 'dart:math';

import 'package:dio/dio.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/repositories/caching_repository.dart'
    show isNetworkError;
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/write_queue/pending_write.dart';

/// Kuyruk kaydının istek alanları (backend ADR 0140). Tek kaynak: ekran
/// kaydı bununla kurar, ilk gönderim de kuyruktan yeniden gönderim de
/// [sendPendingWrite] ile aynı alanlardan yapılır — iki ayrı istek kurucusu
/// zamanla ayrışırdı.
///
/// Tarihler GÜN olarak (`YYYY-AA-GG`) tutulur: saat dilimi kaydırması
/// olmasın, ve JSON'a çevrilince kayıpsız dönsün.
abstract final class PendingPayload {
  static Map<String, dynamic> note(String note) => {'note': note};

  static Map<String, dynamic> breeding({
    required String kind,
    required DateTime date,
    String sire = '',
    String? result,
    String note = '',
  }) => {
    'kind': kind,
    'date': day(date),
    'sire': sire,
    'result': ?result,
    'note': note,
  };

  static Map<String, dynamic> treatment({
    required String drug,
    required DateTime startedOn,
    required DateTime withdrawalUntil,
    String note = '',
  }) => {
    'drug': drug,
    'startedOn': day(startedOn),
    'withdrawalUntil': day(withdrawalUntil),
    'note': note,
  };

  /// [planName] yalnızca listede göstermek için; gönderilmez.
  static Map<String, dynamic> vaccination({
    required String planId,
    required List<String> animalIds,
    required DateTime givenOn,
    String note = '',
    String planName = '',
  }) => {
    'planId': planId,
    'animalIds': animalIds,
    'givenOn': day(givenOn),
    'note': note,
    'planName': planName,
  };

  static Map<String, dynamic> calving(DateTime date) => {'date': day(date)};

  static String day(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  /// `YYYY-AA-GG` → yerel gece yarısı (depolar günü yerel tarihten okur).
  static DateTime parseDay(Object? s) {
    final p = (s! as String).split('-').map(int.parse).toList();
    return DateTime(p[0], p[1], p[2]);
  }
}

/// Kaydı depoya gönderir; sunucunun cevabını döner (not, üreme olayı,
/// tedavi, aşıda yazılan sayı, buzağılamada hayvan).
Future<Object?> sendPendingWrite(MilkTraceRepository repo, PendingWrite w) {
  final p = w.payload;
  String str(String k) => (p[k] as String?) ?? '';
  final key = w.id;
  return switch (w.kind) {
    PendingKind.note => repo.addAnimalNote(
      w.animalId!,
      str('note'),
      idempotencyKey: key,
    ),
    PendingKind.breeding => repo.addBreeding(
      w.animalId!,
      kind: str('kind'),
      date: PendingPayload.parseDay(p['date']),
      sire: str('sire'),
      result: p['result'] as String?,
      note: str('note'),
      idempotencyKey: key,
    ),
    PendingKind.treatment => repo.addTreatment(
      w.animalId!,
      drug: str('drug'),
      startedOn: PendingPayload.parseDay(p['startedOn']),
      withdrawalUntil: PendingPayload.parseDay(p['withdrawalUntil']),
      note: str('note'),
      idempotencyKey: key,
    ),
    PendingKind.vaccination => repo.addVaccinations(
      planId: str('planId'),
      animalIds: [for (final a in p['animalIds']! as List) a as String],
      givenOn: PendingPayload.parseDay(p['givenOn']),
      note: str('note'),
      idempotencyKey: key,
    ),
    PendingKind.calving => repo.recordCalving(
      w.animalId!,
      PendingPayload.parseDay(p['date']),
      idempotencyKey: key,
    ),
  };
}

/// Bir gönderim hatasının sonucu (backend ADR 0140/7).
enum WriteOutcome {
  /// Ağ hatası: yeniden dene, sınırsız (yaş sınırı var).
  retryNetwork,

  /// Geçici sunucu hatası (5xx, 408, 429): artan bekleme, sınırlı.
  retryServer,

  /// 401: boşaltmayı durdur, kayda dokunma.
  unauthorized,

  /// Hedef durum sunucuda zaten var (buzağılama/kızgınlıkta 409).
  delivered,

  /// Sunucu reddetti: gönderilemeyenlere.
  rejected,
}

/// Hatanın HTTP durumu ve kodu; HTTP hatası değilse null.
({int? status, String? code}) _httpOf(Object e) => switch (e) {
  DioException(:final response) => (
    status: response?.statusCode,
    code: switch (response?.data) {
      {'error': {'code': final String c}} => c,
      _ => null,
    },
  ),
  ApiException(:final status, :final code) => (status: status, code: code),
  _ => (status: null, code: null),
};

WriteOutcome classifyWriteError(Object e, PendingWrite w) {
  if (isNetworkError(e)) return WriteOutcome.retryNetwork;
  final (:status, :code) = _httpOf(e);
  if (status == null) {
    // Cevap çözümlenemedi ya da beklenmeyen hata: geçici say, sınır var.
    return WriteOutcome.retryServer;
  }
  if (status == 401) return WriteOutcome.unauthorized;
  if (status >= 500 || status == 408 || status == 429) {
    return WriteOutcome.retryServer;
  }
  if (status == 409) {
    // Idempotency ara katmanı (ADR 0140/11): ilk istek hâlâ işleniyor.
    if (code == 'IDEMPOTENCY_IN_PROGRESS') return WriteOutcome.retryServer;
    // Aynı gün/tarih zaten kayıtlı: önceki denemenin cevabı yolda kaybolmuş
    // ya da bir meslektaş girmiş; hedef durum sunucuda var.
    final heat = w.kind == PendingKind.breeding && w.payload['kind'] == 'heat';
    if (w.kind == PendingKind.calving || heat) return WriteOutcome.delivered;
  }
  return WriteOutcome.rejected;
}

/// Sunucu hatasından sonraki bekleme: 15 sn, 30 sn, 1 dk … en çok 15 dk.
Duration retryBackoff(int serverErrors) {
  final s = 15 * pow(2, max(0, serverErrors - 1)).toInt();
  return Duration(seconds: min(s, 15 * 60));
}

final _rand = Random.secure();

/// RFC 4122 sürüm 4 UUID; `Idempotency-Key` ve kuyruk kimliği.
String newIdempotencyKey() {
  final b = List<int>.generate(16, (_) => _rand.nextInt(256));
  b[6] = (b[6] & 0x0f) | 0x40;
  b[8] = (b[8] & 0x3f) | 0x80;
  String hex(int from, int to) => [
    for (var i = from; i < to; i++) b[i].toRadixString(16).padLeft(2, '0'),
  ].join();
  return '${hex(0, 4)}-${hex(4, 6)}-${hex(6, 8)}-${hex(8, 10)}-${hex(10, 16)}';
}
