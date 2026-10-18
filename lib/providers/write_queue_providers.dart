import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/cache/cache_store.dart';
import 'package:milktrace/data/repositories/caching_repository.dart'
    show isNetworkError;
import 'package:milktrace/data/write_queue/pending_write.dart';
import 'package:milktrace/data/write_queue/write_sender.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/offline_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'write_queue_providers.g.dart';

/// Kuyruk anahtarlarının öneki (backend ADR 0140/8). Önbellekten
/// ([offlineCachePrefix]) AYRI: çıkışta ve zorunlu çıkışta önbellek
/// silinir, kuyruk yalnızca kullanıcı onaylarsa.
const writeQueuePrefix = 'mtqueue:v1:';

/// Bekleyen + gönderilemeyen en çok kayıt (ADR 0140/10).
const writeQueueMaxItems = 200;

/// Bundan eski bekleyen kayıt gönderilmez, gönderilemeyenlere düşer.
const writeQueueMaxAge = Duration(days: 7);

/// Gönderilemeyen kayıt bu süreden sonra cihazdan silinir (KVKK).
const writeQueueFailedRetention = Duration(days: 30);

/// Bu kadar sunucu hatasından sonra kayıt gönderilemeyenlere düşer.
const writeQueueMaxServerErrors = 8;

/// Kuyruğun saati; testte sabitlenir.
@Riverpod(keepAlive: true)
DateTime Function() writeQueueClock(Ref ref) => DateTime.now;

/// Kuyruktan kayıt teslim edildikçe artar. Kayıt listelerini okuyan
/// sağlayıcılar (notlar, tedaviler, üreme, aşı, hayvanlar) bunu izler:
/// "Bekliyor" satırı kalkınca gerçek kayıt yerine gelsin.
@Riverpod(keepAlive: true)
class WriteQueueDelivered extends _$WriteQueueDelivered {
  @override
  int build() => 0;

  void bump() => state++;
}

/// Bir yazmanın sonucu: sunucuya gitti ya da kuyruğa alındı.
sealed class WriteResult {
  const WriteResult();
}

/// Sunucu kabul etti; [value] cevabı.
final class WriteSent extends WriteResult {
  const WriteSent(this.value);
  final Object? value;
}

/// Sunucuya ulaşılamadı; kayıt kuyrukta, ekran "Bekliyor" gösterir.
final class WriteQueued extends WriteResult {
  const WriteQueued(this.item);
  final PendingWrite item;
}

/// Çevrimdışı yazma kuyruğu (backend ADR 0140).
///
/// Durum: seçili kullanıcı + işletmenin kuyruğu, oluşturulma sırasıyla.
/// Ekranlar [submit] ile yazar: önce doğrudan gönderilir, yalnızca sunucuya
/// ULAŞILAMAZSA ([isNetworkError]) kayıt kuyruğa girer. Sunucunun verdiği
/// hata (4xx, 500) eskisi gibi ekrana çıkar.
///
/// Boşaltma ([flush]) katı FIFO'dur: yeniden denenecek hata boşaltmayı
/// durdurur, reddedilen kayıt gönderilemeyenlere alınır ve sıradakine
/// geçilir. Tetikleyiciler: bağlantı dönünce (burada), uygulama öne gelince
/// ve bekleyen varken periyodik (`WriteQueueListener`).
@Riverpod(keepAlive: true)
class WriteQueue extends _$WriteQueue {
  String? _scope;
  Future<void>? _loading;
  bool _flushing = false;
  bool _again = false;

  CacheStore? _storeCache;

  // Tembel: depo ilk kullanımda okunur (testlerde çoğu ekran kuyruğu hiç
  // kullanmaz ve gerçek depo kurulamaz). Örnek eskiyince de elde kalır.
  CacheStore get _store {
    final CacheStore s = _storeCache ?? ref.read(cacheStoreProvider);
    return _storeCache = s;
  }

  /// [scope] hâlâ bu örneğin seçili kapsamı mı? Riverpod 3'te oturum
  /// değişince sağlayıcı YENİ bir örnekle kurulur; eski örneğin süren
  /// boşaltması durumu (artık geçersiz) değil diski günceller.
  bool _current(String scope) => ref.mounted && _scope == scope;
  DateTime _now() => ref.read(writeQueueClockProvider)().toUtc();

  @override
  List<PendingWrite> build() {
    final (tenant, user) = ref.watch(
      authProvider.select((s) => (s.user?.tenantId, s.user?.id)),
    );
    // İşletmesi olmayan (platform yöneticisi) ya da girişsiz: kuyruk yok.
    final scope = tenant == null || user == null
        ? null
        : '$writeQueuePrefix$tenant:$user';
    _scope = scope;

    // Bağlantı döndü (bir istek sunucuya ulaştı): bekleyenleri gönder.
    ref.listen(offlineStatusProvider, (prev, next) {
      if (prev != null && next == null) unawaited(flush());
    });

    _loading = scope == null ? null : _load(scope);
    return const [];
  }

  Future<void> _load(String scope) async {
    final raw = await _read(scope);
    if (!_current(scope)) return;
    final items = _prune(raw);
    state = items;
    if (items.any((w) => w.isPending)) unawaited(flush());
  }

  Future<List<PendingWrite>> _read(String scope) async {
    try {
      final raw = await _store.read(scope);
      if (raw == null) return const [];
      return [
        for (final e in jsonDecode(raw) as List)
          PendingWrite.fromJson(e as Map<String, dynamic>),
      ];
    } catch (_) {
      // Bozuk kayıt kuyruğu kilitlemesin; okunamayan liste boş sayılır.
      return const [];
    }
  }

  Future<void> _write(String scope, List<PendingWrite> items) =>
      _store.write(scope, jsonEncode([for (final w in items) w.toJson()]));

  /// [scope]'un listesini değiştirir: seçiliyse durumda, değilse (işletme
  /// değişti, boşaltma sürüyordu) diskte. Değişiklikler kimliğe göre
  /// yapıldığı için arada eklenen kayıt ezilmez.
  Future<void> _update(
    String scope,
    List<PendingWrite> Function(List<PendingWrite>) f,
  ) async {
    if (_current(scope)) {
      state = f(state);
      await _write(scope, state);
    } else {
      await _write(scope, f(await _read(scope)));
    }
  }

  static List<PendingWrite> _replace(List<PendingWrite> l, PendingWrite w) => [
    for (final x in l) x.id == w.id ? w : x,
  ];

  static List<PendingWrite> _without(List<PendingWrite> l, String id) => [
    for (final x in l)
      if (x.id != id) x,
  ];

  /// Yaş sınırı: 7 günden eski bekleyen → gönderilemedi; 30 günden eski
  /// gönderilemeyen → silinir.
  List<PendingWrite> _prune(List<PendingWrite> items) {
    final now = _now();
    return [
      for (final w in items)
        if (w.isFailed &&
            now.difference(w.failedAt ?? w.createdAt) >
                writeQueueFailedRetention)
          ...const <PendingWrite>[]
        else if (w.isPending && now.difference(w.createdAt) > writeQueueMaxAge)
          w.copyWith(
            state: PendingState.failed,
            failure: PendingFailure.expired,
            failedAt: now,
          )
        else
          w,
    ];
  }

  /// Yazar: önce doğrudan; sunucuya ulaşılamazsa kuyruğa. Başka her hata
  /// olduğu gibi atılır.
  Future<WriteResult> submit({
    required PendingKind kind,
    String? animalId,
    String subject = '',
    required Map<String, dynamic> payload,
  }) async {
    final w = PendingWrite(
      id: newIdempotencyKey(),
      kind: kind,
      animalId: animalId,
      subject: subject,
      payload: payload,
      createdAt: _now(),
    );
    try {
      return WriteSent(await sendPendingWrite(ref.read(repositoryProvider), w));
    } catch (e) {
      final scope = _scope;
      if (!isNetworkError(e) || scope == null) rethrow;
      await _loading;
      if (!_current(scope)) rethrow;
      if (state.length >= writeQueueMaxItems) {
        throw ApiException(code: 'QUEUE_FULL', message: l10n.writeQueueFull);
      }
      await _update(scope, (l) => [...l, w]);
      return WriteQueued(w);
    }
  }

  /// Bekleyenleri sırayla gönderir. [force] artan beklemeyi yok sayar
  /// ("Şimdi gönder").
  Future<void> flush({bool force = false}) async {
    if (_flushing) {
      _again = true;
      return;
    }
    final scope = _scope;
    if (scope == null) return;
    _flushing = true;
    var delivered = 0;
    try {
      do {
        _again = false;
        await _loading;
        if (!_current(scope)) break;
        final pruned = _prune(state);
        if (!listEquals(pruned, state)) await _update(scope, (_) => pruned);
        delivered += await _drain(scope, force: force);
      } while (_again && _current(scope));
    } finally {
      _flushing = false;
      if (delivered > 0 && ref.mounted) {
        ref.read(writeQueueDeliveredProvider.notifier).bump();
      }
    }
  }

  /// Kuyruğu baştan boşaltır; teslim edilen sayıyı döner.
  Future<int> _drain(String scope, {required bool force}) async {
    var delivered = 0;
    while (_current(scope)) {
      final head = state.where((w) => w.isPending).firstOrNull;
      if (head == null) break;
      final now = _now();
      final wait = head.nextAttemptAt;
      if (!force && wait != null && wait.isAfter(now)) break;
      final tried = head.copyWith(attempts: head.attempts + 1);
      try {
        await sendPendingWrite(ref.read(repositoryProvider), tried);
        await _update(scope, (l) => _without(l, head.id));
        delivered++;
        continue;
      } catch (e) {
        switch (classifyWriteError(e, tried)) {
          case WriteOutcome.delivered:
            await _update(scope, (l) => _without(l, head.id));
            delivered++;
            continue;
          case WriteOutcome.rejected:
            await _update(
              scope,
              (l) => _replace(
                l,
                tried.copyWith(
                  state: PendingState.failed,
                  failure: PendingFailure.rejected,
                  error: userMessage(e) ?? '$e',
                  failedAt: now,
                ),
              ),
            );
            continue;
          case WriteOutcome.retryServer:
            final n = tried.serverErrors + 1;
            await _update(
              scope,
              (l) => _replace(
                l,
                n >= writeQueueMaxServerErrors
                    ? tried.copyWith(
                        serverErrors: n,
                        state: PendingState.failed,
                        failure: PendingFailure.retries,
                        error: userMessage(e),
                        failedAt: now,
                      )
                    : tried.copyWith(
                        serverErrors: n,
                        nextAttemptAt: now.add(retryBackoff(n)),
                      ),
              ),
            );
            // Sınır aşıldıysa kayıt kenara alındı; sıradakine geç.
            if (n >= writeQueueMaxServerErrors) continue;
            return delivered;
          case WriteOutcome.retryNetwork:
            await _update(scope, (l) => _replace(l, tried));
            return delivered;
          case WriteOutcome.unauthorized:
            return delivered;
        }
      }
    }
    return delivered;
  }

  /// Gönderilemeyen kaydı yeniden bekleyenlere alır ve hemen dener.
  Future<void> retry(String id) async {
    final scope = _scope;
    if (scope == null) return;
    await _update(scope, (l) {
      final w = l.where((x) => x.id == id).firstOrNull;
      if (w == null) return l;
      // Sıra: yeniden denenen kayıt oluşturulma yerinde kalır.
      return _replace(
        l,
        PendingWrite(
          id: w.id,
          kind: w.kind,
          animalId: w.animalId,
          subject: w.subject,
          payload: w.payload,
          createdAt: w.isFailed && w.failure == PendingFailure.expired
              ? _now()
              : w.createdAt,
          attempts: w.attempts,
        ),
      );
    });
    await flush(force: true);
  }

  /// Kaydı hiç göndermeden siler.
  Future<void> discard(String id) async {
    final scope = _scope;
    if (scope == null) return;
    await _update(scope, (l) => _without(l, id));
  }

  /// Seçili kapsamın bütün kuyruğunu siler (kullanıcının onayladığı çıkış).
  Future<void> clear() async {
    final scope = _scope;
    if (scope == null) return;
    await _loading;
    await _update(scope, (_) => const []);
  }
}
