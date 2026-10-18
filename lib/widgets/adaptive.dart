import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';

/// Material 3 pencere boyu sınıfları (backend ADR 0141).
///
/// Karar CİHAZ TÜRÜNE değil GENİŞLİĞE göre verilir: yatay telefon da
/// tablettir, bölünmüş ekrandaki tablet de telefon. Yükseklik bakılmaz.
enum WindowSize {
  /// < 600: telefon dikey. Alt menü, tek bölme.
  compact,

  /// 600–839: küçük tablet, büyük tablet dikey, katlanabilir. Yan ray.
  medium,

  /// ≥ 840: tablet yatay. Yan ray (≥ [kExtendedRailMinWidth] açık ray).
  expanded;

  static WindowSize fromWidth(double width) => width < 600
      ? compact
      : width < 840
      ? medium
      : expanded;

  static WindowSize of(BuildContext context) =>
      fromWidth(MediaQuery.sizeOf(context).width);

  bool get isCompact => this == compact;
}

/// Bu genişlikten itibaren yan ray etiketli ve açık çizilir (M3 "large").
/// 840'ta açık ray (256) liste–detayı sıkıştırırdı.
const double kExtendedRailMinWidth = 1200;

/// Formların ve okunacak metin sütunlarının en geniş hali: tablette satır
/// boyu ekran boyunca uzayınca alan adı ile değeri arasında göz kayboluyor.
const double kFormMaxWidth = 640;

/// Tam ekran formun kaydırma dolgusu: dar ekranda [base], geniş ekranda
/// içerik [maxWidth] sütununa ortalanır. Dolgu olarak verilir ki kaydırma
/// alanı (ve çubuğu) ekran boyu kalsın; kenardan da kaydırılabilsin.
EdgeInsets formPadding(
  BuildContext context, {
  EdgeInsets base = const EdgeInsets.all(AppSpacing.lg),
  double maxWidth = kFormMaxWidth,
}) {
  final width = MediaQuery.sizeOf(context).width;
  final extra = math.max(0.0, (width - base.horizontal - maxWidth) / 2);
  if (extra == 0) return base;
  return base.copyWith(left: base.left + extra, right: base.right + extra);
}
