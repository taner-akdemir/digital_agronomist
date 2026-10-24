import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/activity.dart';
import 'package:milktrace/data/models/device.dart';
import 'package:milktrace/features/activity/activity_providers.dart';
import 'package:milktrace/features/activity/activity_status.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';

/// Tasmayı hayvana bağlayıp çözebilen roller (backend ADR 0145 §2). Ayrı
/// bir yönetici rolü yok: sahip ve operatör bağlar; görüntüleyici, kiosk ve
/// mandıra hesabı bağlamaz. Sunucu yetkiyi ayrıca denetler.
const activityBindRoles = {'tenant_owner', 'tenant_operator'};

/// Hayvan sayfasındaki Aktivite kartı (backend ADR 0145 §10): durum,
/// 48 saatlik saatlik ve 14 günlük günlük mini grafik, geviş, cihaz;
/// sahip tasmayı bağlar / çözer.
class ActivityCard extends ConsumerWidget {
  const ActivityCard({super.key, required this.animalId});

  final String animalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(animalActivityProvider(animalId));
    final user = ref.watch(authProvider).user;
    // Kiosk bir rol değil, hesap bayrağı (rolü operatör olabilir).
    final canBind =
        user != null && !user.kiosk && activityBindRoles.contains(user.role);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.border),
      ),
      child: AsyncView(
        value: value,
        errorMessage: l10n.activityLoadFailed,
        onRetry: () => ref.invalidate(animalActivityProvider(animalId)),
        builder: (a) => _Content(activity: a, canBind: canBind),
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({required this.activity, required this.canBind});

  final AnimalActivity activity;
  final bool canBind;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final device = activity.device;
    final hint = device == null ? null : ActivityStatus.hint(activity.status);
    final rumination = _rumination24h(activity.hourly);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.activityTitle,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (device != null) ActivityStatusChip(status: activity.status),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        if (device == null) ...[
          Text(
            l10n.activityEmpty,
            style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
          ),
        ] else ...[
          if (hint != null) ...[
            Text(
              hint,
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          if (!activity.hasData)
            Text(
              l10n.activityNoDataYet,
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
            )
          else ...[
            if (activity.hourly.isNotEmpty) ...[
              _ChartLabel(l10n.activityHourlyTitle),
              ActivityBars(
                values: [for (final h in activity.hourly) _hourValue(h)],
                labels: [for (final h in activity.hourly) Fmt.time(h.hour)],
                tooltips: [
                  for (final h in activity.hourly)
                    '${Fmt.dayMonth(h.hour)} ${Fmt.time(h.hour)}',
                ],
              ),
            ],
            if (activity.daily.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              _ChartLabel(l10n.activityDailyTitle(activity.daily.length)),
              ActivityBars(
                values: [for (final d in activity.daily) _dayValue(d)],
                labels: [for (final d in activity.daily) Fmt.dayMonth(d.day)],
                tooltips: [for (final d in activity.daily) Fmt.dayMonth(d.day)],
              ),
            ],
            if (rumination != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(l10n.activityRumination(rumination.round())),
            ],
          ],
          const SizedBox(height: AppSpacing.sm),
          Text(
            device.lastSeen == null
                ? l10n.activityDeviceNoData(device.serial)
                : l10n.activityDevice(
                    device.serial,
                    Fmt.since(device.lastSeen!),
                  ),
            style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
          ),
        ],
        if (canBind)
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: device == null
                ? TextButton.icon(
                    onPressed: () => _bind(context, ref),
                    icon: const Icon(Icons.link, size: 18),
                    label: Text(l10n.activityBind),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.darkGreenColor,
                    ),
                  )
                : TextButton.icon(
                    onPressed: () => _unbind(context, ref, device),
                    icon: const Icon(Icons.link_off, size: 18),
                    label: Text(l10n.activityUnbind),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.darkGreenColor,
                    ),
                  ),
          ),
      ],
    );
  }

  /// Birincil işaret adım; cihaz adım göndermiyorsa aktivite endeksi
  /// (sunucunun tespit kuralıyla aynı, ADR 0145 §5).
  static double? _hourValue(ActivityHour h) =>
      h.steps?.toDouble() ?? h.activityIndex;

  static double? _dayValue(ActivityDay d) =>
      d.steps?.toDouble() ?? d.activityIndex;

  /// Son 24 saatin geviş toplamı; hiç geviş verisi yoksa null.
  static double? _rumination24h(List<ActivityHour> hourly) {
    final last = hourly.length > 24
        ? hourly.sublist(hourly.length - 24)
        : hourly;
    final values = [for (final h in last) ?h.ruminationMin];
    if (values.isEmpty) return null;
    return values.fold<double>(0, (a, b) => a + b);
  }

  void _refresh(WidgetRef ref) {
    ref
      ..invalidate(animalActivityProvider(activity.animalId))
      ..invalidate(activityOverviewProvider)
      ..invalidate(freeActivityDevicesProvider);
  }

  Future<void> _bind(BuildContext context, WidgetRef ref) async {
    final device = await showDialog<Device>(
      context: context,
      builder: (_) => const _BindDialog(),
    );
    if (device == null || !context.mounted) return;
    await _run(
      context,
      ref,
      () => ref
          .read(repositoryProvider)
          .bindActivityDevice(device.id, activity.animalId),
      l10n.activityBindDone,
    );
  }

  Future<void> _unbind(
    BuildContext context,
    WidgetRef ref,
    ActivityDevice device,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.activityUnbindTitle),
        content: Text(l10n.activityUnbindBody(device.serial)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.activityUnbind),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    await _run(
      context,
      ref,
      () => ref.read(repositoryProvider).bindActivityDevice(device.id, null),
      l10n.activityUnbindDone,
    );
  }

  Future<void> _run(
    BuildContext context,
    WidgetRef ref,
    Future<void> Function() call,
    String done,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await call();
      _refresh(ref);
      messenger.showSnackBar(
        SnackBar(content: Text(done), backgroundColor: AppColors.brandFill),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(activityBindError(e)),
          backgroundColor: AppColors.dangerFill,
        ),
      );
    }
  }
}

/// Bağlama hatasının kullanıcı metni (ADR 0145 §2 kodları).
String activityBindError(Object e) {
  // ApiRepository DioException fırlatır, mock ApiException; ikisi de.
  final code = switch (e) {
    final ApiException a => a.code,
    final DioException d => ApiException.from(d).code,
    _ => null,
  };
  return switch (code) {
    'ANIMAL_HAS_DEVICE' => l10n.activityErrorAnimalHasDevice,
    'NOT_ACTIVITY_DEVICE' => l10n.activityErrorNotActivityDevice,
    _ => userMessage(e) ?? l10n.activityBindFailed('$e'),
  };
}

class _ChartLabel extends StatelessWidget {
  const _ChartLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
    child: Text(
      text,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    ),
  );
}

/// Boş tasmaları listeleyen seçim penceresi.
class _BindDialog extends ConsumerWidget {
  const _BindDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(freeActivityDevicesProvider);
    return AlertDialog(
      title: Text(l10n.activityBindTitle),
      content: SizedBox(
        width: 360,
        child: AsyncView(
          value: value,
          errorMessage: l10n.activityLoadFailed,
          builder: (devices) => devices.isEmpty
              ? Text(l10n.activityBindNoFree)
              : ListView(
                  shrinkWrap: true,
                  children: [
                    for (final d in devices)
                      ListTile(
                        leading: const Icon(Icons.watch_outlined),
                        title: Text(d.serialNo),
                        subtitle: d.lastSeenAt == null
                            ? null
                            : Text(Fmt.since(d.lastSeenAt!)),
                        onTap: () => Navigator.of(context).pop(d),
                      ),
                  ],
                ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
      ],
    );
  }
}

/// Mini çubuk grafik: saatlik ya da günlük aktivite. Eksen etiketleri
/// yalnız ilk / orta / son (dar ekranda okunur kalsın). Taban çizgisi YOK:
/// API taban serisi göndermiyor; istemcide uydurulan bir çizgi sunucunun
/// tespit tabanıyla (aynı saat dilimi, önceki 7 gün) karıştırılırdı.
class ActivityBars extends StatelessWidget {
  const ActivityBars({
    super.key,
    required this.values,
    required this.labels,
    required this.tooltips,
    this.height = 110,
  });

  final List<double?> values;
  final List<String> labels;
  final List<String> tooltips;
  final double height;

  @override
  Widget build(BuildContext context) {
    final present = [for (final v in values) ?v];
    final maxY = present.isEmpty
        ? 1.0
        : present.reduce((a, b) => a > b ? a : b);
    final n = values.length;
    final mid = (n - 1) ~/ 2;
    final barWidth = n > 24 ? 3.0 : 8.0;

    return SizedBox(
      height: height,
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: maxY <= 0 ? 1 : maxY * 1.15,
          barGroups: [
            for (var i = 0; i < n; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: values[i] ?? 0,
                    width: barWidth,
                    color: AppColors.chartPrimary,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(2),
                    ),
                  ),
                ],
              ),
          ],
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) =>
                FlLine(color: AppColors.chartGrid, strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 38,
                getTitlesWidget: (value, meta) => Text(
                  value == meta.max ? '' : value.toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.onSurfaceMuted,
                  ),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 20,
                getTitlesWidget: (value, meta) {
                  final i = value.round();
                  if (i < 0 || i >= n || (i != 0 && i != mid && i != n - 1)) {
                    return const SizedBox.shrink();
                  }
                  return SideTitleWidget(
                    meta: meta,
                    space: AppSpacing.xs,
                    fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
                    child: Text(
                      labels[i],
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.onSurfaceMuted,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => AppColors.brandFill,
              getTooltipItem: (group, _, rod, _) => BarTooltipItem(
                '${tooltips[group.x]}\n${rod.toY.toStringAsFixed(0)}',
                TextStyle(color: AppColors.onFill, fontSize: 11),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
