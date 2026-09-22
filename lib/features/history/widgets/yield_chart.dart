import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal_trend.dart';

/// Günlük verim ve 7 gün hareketli ortalaması (§15.1).
///
/// İKİ SERİ, TEK EKSEN: ikisi de litre. İkinci bir y ekseni eklemek
/// (ör. sağda sağım sayısı) iki eğriyi istenen her şekilde örtüştürebilirdi.
///
/// Günlük seri BAĞLAMDIR, ana sinyal değil: 90 nokta telefon genişliğinde
/// nokta başına ~4 piksel düşer ve tek tek okunamaz. Okunan çizgi kalın olan,
/// yani ortalamadır; günlük seri onun ne kadar oynadığını gösterir.
class YieldChart extends StatelessWidget {
  const YieldChart({super.key, required this.daily});

  /// Eskiden yeniye sıralı günlük seri.
  final List<AnimalDailyStat> daily;

  @override
  Widget build(BuildContext context) {
    if (daily.length < 2) {
      return const SizedBox(
        height: 180,
        child: Center(
          child: Text('Grafik için yeterli geçmiş yok',
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted)),
        ),
      );
    }

    final dailySpots = <FlSpot>[];
    final maSpots = <FlSpot>[];
    for (var i = 0; i < daily.length; i++) {
      dailySpots.add(FlSpot(i.toDouble(), daily[i].totalMl / 1000));
      final ma = daily[i].ma7Ml;
      if (ma != null) maSpots.add(FlSpot(i.toDouble(), ma / 1000));
    }

    final maxY = dailySpots.map((s) => s.y).reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // İKİ SERİ VARSA LEJANT ŞART: kimlik yalnızca renge bırakılmaz.
        const Row(
          children: [
            _LegendItem(color: AppColors.chartPrimary, label: '7 gün ort.'),
            SizedBox(width: AppSpacing.md),
            _LegendItem(color: AppColors.chartContext, label: 'Günlük'),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 180,
          child: LineChart(
            LineChartData(
              minY: 0,
              // Tavanda biraz pay: en yüksek gün çizginin tepesine yapışırsa
              // grafiğin kesildiği izlenimi doğuyor.
              maxY: maxY <= 0 ? 1 : maxY * 1.15,
              lineBarsData: [
                _bar(dailySpots, AppColors.chartContext, 1.2),
                _bar(maSpots, AppColors.chartPrimary, 2.5),
              ],
              gridData: FlGridData(
                show: true,
                // Dikey çizgi YOK: x ekseni gün ve 90 dikey çizgi grafiği
                // tarar. Yatay çizgiler okumaya yarıyor, onlar kalıyor.
                drawVerticalLine: false,
                getDrawingHorizontalLine: (_) =>
                    const FlLine(color: AppColors.chartGrid, strokeWidth: 1),
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 34,
                    getTitlesWidget: (value, meta) => Text(
                      value == meta.max ? '' : value.toStringAsFixed(0),
                      style: const TextStyle(
                          fontSize: 10, color: AppColors.onSurfaceMuted),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    // Üç etiket yeter: ilk, orta, son. Her günü yazmak
                    // telefon genişliğinde okunmaz bir şerit olurdu.
                    interval: (daily.length - 1) / 2,
                    getTitlesWidget: (value, meta) {
                      final i = value.round();
                      if (i < 0 || i >= daily.length) return const SizedBox();
                      // fitInside: SON etiket eksenin sağ ucunda ortalanıyor
                      // ve kartın dışına taşıp kırpılıyordu.
                      return SideTitleWidget(
                        meta: meta,
                        space: AppSpacing.xs,
                        fitInside:
                            SideTitleFitInsideData.fromTitleMeta(meta),
                        child: Text(
                          Fmt.dayMonth(daily[i].date),
                          style: const TextStyle(
                              fontSize: 10, color: AppColors.onSurfaceMuted),
                        ),
                      );
                    },
                  ),
                ),
              ),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (_) => AppColors.darkGreenColor,
                  getTooltipItems: (spots) => [
                    for (final s in spots)
                      LineTooltipItem(
                        s.barIndex == 1
                            ? '7 gün ort. ${s.y.toStringAsFixed(1)} L'
                            : '${Fmt.dayMonth(daily[s.x.round()].date)}  '
                                '${s.y.toStringAsFixed(1)} L',
                        const TextStyle(color: Colors.white, fontSize: 11),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Nokta işaretçisi YOK: 90 noktanın her birine daire koymak çizgiyi
  /// boncuk dizisine çevirir.
  static LineChartBarData _bar(List<FlSpot> spots, Color color, double width) =>
      LineChartBarData(
        spots: spots,
        color: color,
        barWidth: width,
        isCurved: true,
        curveSmoothness: 0.15,
        preventCurveOverShooting: true,
        dotData: const FlDotData(show: false),
      );
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 14, height: 3, color: color),
        const SizedBox(width: AppSpacing.xs),
        // Etiket METİN rengindedir, seri rengi DEĞİL: kimliği yanındaki
        // renkli çizgi taşır.
        Text(label,
            style: const TextStyle(
                fontSize: 11, color: AppColors.onSurfaceMuted)),
      ],
    );
  }
}
