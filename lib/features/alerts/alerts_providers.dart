import 'package:milktrace/data/models/alert.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alerts_providers.g.dart';

/// Uyarı listesi (§8.5 GET /alerts).
///
/// SIRALAMA: önce açık uyarılar, sonra yeniden eskiye. Zamana göre düz
/// sıralamak, dün okunmuş bir uyarıyı bu sabahki açık uyarının üstüne
/// koyabilirdi.
@riverpod
class AlertList extends _$AlertList {
  @override
  Future<List<Alert>> build() async {
    final alerts = [...await ref.watch(repositoryProvider).alerts()];

    alerts.sort((a, b) {
      if (a.isAcknowledged != b.isAcknowledged) {
        return a.isAcknowledged ? 1 : -1;
      }
      final at = a.createdAt, bt = b.createdAt;
      if (at == null || bt == null) return 0;
      return bt.compareTo(at);
    });
    return List.unmodifiable(alerts);
  }

  /// Uyarıyı okundu işaretler.
  ///
  /// Önce EKRANDA işaretlenir, sonra sunucuya gidilir: ahırda bağlantı yavaş
  /// ve düğmeye basınca hiçbir şey olmaması, kullanıcıyı ikinci kez
  /// bastırıyordu. Sonuç ne olursa olsun liste tazelenir — hata durumunda
  /// iyimser işaret geri alınmış olur.
  Future<void> ack(String alertId) async {
    final current = state.value;
    if (current != null) {
      state = AsyncData([
        for (final a in current)
          if (a.id == alertId)
            a.copyWith(acknowledgedAt: DateTime.now(), acknowledgedBy: 'me')
          else
            a,
      ]);
    }

    try {
      await ref.read(repositoryProvider).ackAlert(alertId);
    } finally {
      ref.invalidateSelf();
    }
  }
}

/// Açık (okunmamış) uyarı sayısı — üst çubuktaki zilin rozeti.
@riverpod
int openAlertCount(Ref ref) =>
    ref
        .watch(alertListProvider)
        .value
        ?.where((a) => !a.isAcknowledged)
        .length ??
    0;
