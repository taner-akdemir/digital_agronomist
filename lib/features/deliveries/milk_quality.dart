import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/data/models/delivery.dart';
import 'package:milktrace/l10n/l10n.dart';

/// Mandıra analizi (backend ADR 0110): yağ, protein, somatik hücre ve
/// bakteri tanker fişinden, isteğe bağlı. Sınır kararını sunucu verir
/// (`Delivery.highScc`); burada ikinci kural yok.

/// Analiz girilmiş mi.
bool hasQuality(Delivery d) =>
    d.fatPct != null ||
    d.proteinPct != null ||
    d.sccK != null ||
    d.bacteriaK != null;

/// "Yağ %3,8 · Protein %3,3 · Hücre 250 · Bakteri 40"; girilmeyen "—".
String qualityLine(Delivery d) {
  String pct(double? v) => v == null ? '—' : v.toStringAsFixed(2);
  String k(int? v) => v == null ? '—' : '$v';
  return l10n.qualitySummary(
    pct(d.fatPct),
    pct(d.proteinPct),
    k(d.sccK),
    k(d.bacteriaK),
  );
}

/// Girilen analiz; boş alan null.
class QualityDraft {
  const QualityDraft({this.fatPct, this.proteinPct, this.sccK, this.bacteriaK});

  final double? fatPct;
  final double? proteinPct;
  final int? sccK;
  final int? bacteriaK;
}

/// Analiz alanlarının denetleyicileri; pencere tutar ve atar.
class QualityControllers {
  final fat = TextEditingController();
  final protein = TextEditingController();
  final scc = TextEditingController();
  final bacteria = TextEditingController();

  void dispose() {
    fat.dispose();
    protein.dispose();
    scc.dispose();
    bacteria.dispose();
  }

  /// Okur; boş alan null, sayı olmayan alan varsa null döner (hata).
  QualityDraft? read() {
    double? dec(TextEditingController c, {required bool Function(double) ok}) {
      final t = c.text.trim().replaceAll(',', '.');
      if (t.isEmpty) return null;
      final v = double.tryParse(t);
      return v != null && ok(v) ? v : double.nan;
    }

    final fat = dec(this.fat, ok: (v) => v > 0 && v <= 15);
    final protein = dec(this.protein, ok: (v) => v > 0 && v <= 10);
    final scc = dec(this.scc, ok: (v) => v >= 1 && v <= 10000);
    final bacteria = dec(this.bacteria, ok: (v) => v >= 1 && v <= 100000);
    if ([fat, protein, scc, bacteria].any((v) => v != null && v.isNaN)) {
      return null;
    }
    return QualityDraft(
      fatPct: fat,
      proteinPct: protein,
      sccK: scc?.round(),
      bacteriaK: bacteria?.round(),
    );
  }
}

/// Teslim penceresindeki açılır "Mandıra analizi" bölümü.
class QualityInputs extends StatelessWidget {
  const QualityInputs({super.key, required this.controllers});

  final QualityControllers controllers;

  Widget _field(TextEditingController c, String label, {bool decimal = true}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: TextField(
          controller: c,
          keyboardType: TextInputType.numberWithOptions(decimal: decimal),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              decimal ? RegExp(r'[0-9.,]') : RegExp('[0-9]'),
            ),
          ],
          decoration: InputDecoration(
            labelText: label,
            isDense: true,
            border: const OutlineInputBorder(borderRadius: AppRadius.mdAll),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      title: Text(l10n.qualityTitle, style: const TextStyle(fontSize: 14)),
      subtitle: Text(
        l10n.qualityOptional,
        style: TextStyle(fontSize: 11, color: AppColors.onSurfaceMuted),
      ),
      children: [
        _field(controllers.fat, l10n.qualityFat),
        _field(controllers.protein, l10n.qualityProtein),
        _field(controllers.scc, l10n.qualityScc, decimal: false),
        _field(controllers.bacteria, l10n.qualityBacteria, decimal: false),
      ],
    );
  }
}

/// Teslim satırındaki analiz satırı; sınır aşıldıysa kırmızı uyarı.
class QualityLine extends StatelessWidget {
  const QualityLine({
    super.key,
    required this.delivery,
    required this.sccLimitK,
  });

  final Delivery delivery;
  final int sccLimitK;

  @override
  Widget build(BuildContext context) {
    if (!hasQuality(delivery)) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            qualityLine(delivery),
            style: TextStyle(fontSize: 12, color: AppColors.onSurface),
          ),
          if (delivery.highScc)
            Text(
              l10n.qualityHighScc(sccLimitK),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.darkRedColor,
              ),
            ),
        ],
      ),
    );
  }
}

/// Son 90 günün somatik hücre eğilimi ve sınır çizgisi. Ana seri koyu
/// yeşil (chartPrimary), sınır nötr gri: §6.2 durum renkleri seri rengi
/// olarak kullanılmaz.
class QualityTrendCard extends StatelessWidget {
  const QualityTrendCard({
    super.key,
    required this.items,
    required this.sccLimitK,
    required this.today,
  });

  final List<Delivery> items;
  final int sccLimitK;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final from = today.subtract(const Duration(days: 90));
    final points =
        items
            .where((d) => d.sccK != null && d.deliveredOn.isAfter(from))
            .toList()
          ..sort((a, b) => a.deliveredOn.compareTo(b.deliveredOn));
    if (!items.any(hasQuality)) return const SizedBox.shrink();

    final spots = [
      for (final d in points)
        FlSpot(
          d.deliveredOn.difference(from).inDays.toDouble(),
          d.sccK!.toDouble(),
        ),
    ];
    final maxY = [
      sccLimitK.toDouble(),
      ...spots.map((s) => s.y),
    ].reduce((a, b) => a > b ? a : b);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${l10n.qualityScc} · ${l10n.qualityTrendTitle}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (spots.length < 2)
            Text(
              l10n.qualityTrendEmpty,
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
            )
          else
            SizedBox(
              height: 140,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 90,
                  minY: 0,
                  maxY: maxY * 1.15,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      color: AppColors.chartPrimary,
                      barWidth: 2.5,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: sccLimitK.toDouble(),
                        color: AppColors.chartContext,
                        strokeWidth: 1.5,
                        dashArray: [6, 4],
                      ),
                    ],
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    bottomTitles: const AxisTitles(),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) => Text(
                          value == meta.max ? '' : value.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.onSurfaceMuted,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
