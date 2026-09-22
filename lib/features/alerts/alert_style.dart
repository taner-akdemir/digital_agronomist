import 'package:flutter/material.dart';
import 'package:milktrace/domain/flow_color.dart';

/// Uyarının ikonu ve renk bandı.
///
/// Bildirim merkezi ile dashboard AYNI eşlemeyi kullanır: aynı uyarının iki
/// ekranda farklı renk veya ikonla çıkması, rengin taşıdığı anlamı
/// (§6.2 bantları) zayıflatırdı.
abstract final class AlertStyle {
  /// Şiddet → §6.2 renk bandı.
  ///
  /// Bilinmeyen şiddet SARIdır, kırmızı değil: tanımadığımız bir uyarıyı en
  /// yüksek aciliyetle göstermek yanlış alarm üretirdi.
  static MilkColor color(String severity) => switch (severity) {
        'critical' => MilkColor.red,
        'info' => MilkColor.grey,
        _ => MilkColor.yellow,
      };

  /// Tür → ikon.
  ///
  /// Bilinmeyen tür genel zil ikonunu alır: §8.4 tür listesini sabitlemedi
  /// ve backend yenisini ekleyebilir.
  static IconData icon(String type) => switch (type) {
        'low_flow' => Icons.water_drop_outlined,
        'low_yield' => Icons.trending_down,
        'declining' => Icons.trending_down,
        'no_milk' => Icons.report_gmailerrorred_outlined,
        'dry_off' => Icons.event_available_outlined,
        'device_offline' => Icons.sensors_off_outlined,
        _ => Icons.notifications_none_outlined,
      };
}
