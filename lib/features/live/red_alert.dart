import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/features/live/live_providers.dart';
import 'package:milktrace/providers/settings_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'red_alert.g.dart';

/// Canlı ekranda kırmızı uyarısı (backend ADR 0091): bir nokta KIRMIZIYA
/// geçince titreşim + kısa ses, aynı sağım için bir kez.
///
/// Renk sunucunundur (§6.2): ısınma ve bitiş bastırması orada uygulanmış
/// olarak gelir, burada ikinci bir kural yok.

/// Uyarının çalınması; testte sahtesi konur.
@Riverpod(keepAlive: true)
void Function() redAlertSink(Ref ref) => () {
  HapticFeedback.vibrate();
  SystemSound.play(SystemSoundType.alert);
};

/// Uyarı açık mı; cihazda saklanır, varsayılan açık.
@Riverpod(keepAlive: true)
class RedAlertEnabled extends _$RedAlertEnabled {
  static const _key = 'live.redAlert';

  @override
  bool build() {
    _load();
    return true;
  }

  Future<void> _load() async {
    try {
      final v = await ref.read(settingsStoreProvider).readBool(_key);
      if (v != null) state = v;
    } on Object {
      // Depo okunamazsa varsayılan (açık) kalır.
    }
  }

  Future<void> set(bool value) async {
    state = value;
    try {
      await ref.read(settingsStoreProvider).writeBool(_key, value);
    } on Object {
      // Kaydedilemese de bu oturumda geçerli.
    }
  }
}

/// Uyarılacak yeni kırmızılar: [seen]'de olmayan, sağımda ve kırmızı
/// noktalar. [seen] güncellenir. Anahtar nokta + hayvan: aynı noktaya yeni
/// hayvan bağlanınca yeni sağımdır.
bool takeNewReds(Iterable<SpoutUpdate> updates, Set<String> seen) {
  var fresh = false;
  for (final u in updates) {
    final a = u.animal;
    if (a == null) continue;
    if (u.state != SpoutState.milking || u.flowColor != MilkColor.red) {
      continue;
    }
    if (seen.add('${u.spoutId}:${a.id}')) fresh = true;
  }
  return fresh;
}

/// Bölgenin canlı akışını dinler ve yeni kırmızıda uyarır. Ekran açılırken
/// zaten kırmızı olanlar uyarılmaz (geçiş değil, durum).
class RedAlertListener extends ConsumerStatefulWidget {
  const RedAlertListener({
    super.key,
    required this.hallId,
    required this.child,
  });

  final String hallId;
  final Widget child;

  @override
  ConsumerState<RedAlertListener> createState() => _RedAlertListenerState();
}

class _RedAlertListenerState extends ConsumerState<RedAlertListener> {
  final _seen = <String>{};
  String? _session;

  @override
  Widget build(BuildContext context) {
    ref.listen(liveBoardProvider(widget.hallId), (prev, next) {
      final live = next.value;
      if (live == null) return;
      final first = _session != live.session.id;
      if (first) {
        _session = live.session.id;
        _seen.clear();
      }
      final fresh = takeNewReds(live.updates, _seen);
      if (fresh && !first && ref.read(redAlertEnabledProvider)) {
        ref.read(redAlertSinkProvider)();
      }
    });
    return widget.child;
  }
}
