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
    'device_error' => Icons.error_outline,
    // Mastitis şüphesi (backend ADR 0087): iletkenlik yükseldi.
    'high_conductivity' => Icons.health_and_safety_outlined,
    // Tank teslim farkı (backend ADR 0089): tanker ile sayaçlar tutmadı.
    'delivery_mismatch' => Icons.local_shipping_outlined,
    // Kalibrasyon zamanı (backend ADR 0097).
    'calibration_due' => Icons.build_circle_outlined,
    // Sağım başlamadı (backend ADR 0099).
    'milking_missed' => Icons.alarm_off,
    // Tank sütünde yüksek somatik hücre (backend ADR 0110).
    'high_scc' => Icons.science_outlined,
    // Nokta farklı hayvanlarda düşük debi ölçüyor (backend ADR 0113).
    'spout_low_flow' => Icons.plumbing,
    // Kuruya çıkarma ve beklenen doğum (backend ADR 0118).
    'dry_off_due' => Icons.event_available_outlined,
    'calving_due' => Icons.child_friendly_outlined,
    // Beklenen kızgınlık (backend ADR 0121).
    'heat_expected' => Icons.favorite_border,
    // Isı stresi (backend ADR 0119).
    'heat_stress' => Icons.thermostat,
    // Aşı zamanı geldi (backend ADR 0112).
    'vaccination_due' => Icons.vaccines_outlined,
    // Sayaç elle ölçüme göre sapıyor (backend ADR 0124).
    'meter_drift' => Icons.speed,
    _ => Icons.notifications_none_outlined,
  };
}
