import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/widgets/milk_palette.dart';

/// Aktivite durumu (backend ADR 0145 overview `status`): etiket ve renk.
///
/// Kızgınlık kırmızı, artış sarı, olağan yeşil; öğrenme / veri yok / gebe
/// gri — renk "bakılacak hayvan" anlamını taşır.
abstract final class ActivityStatus {
  static String label(String status) => switch (status) {
    'learning' => l10n.activityStatusLearning,
    'normal' => l10n.activityStatusNormal,
    'rising' => l10n.activityStatusRising,
    'heat' => l10n.activityStatusHeat,
    'pregnant' => l10n.activityStatusPregnant,
    _ => l10n.activityStatusNoData,
  };

  static MilkColor color(String status) => switch (status) {
    'heat' => MilkColor.red,
    'rising' => MilkColor.yellow,
    'normal' => MilkColor.green,
    _ => MilkColor.grey,
  };

  /// Durumun kısa açıklaması; açıklama gerektirmeyende null.
  static String? hint(String status) => switch (status) {
    'learning' => l10n.activityStatusLearningHint,
    'heat' => l10n.activityStatusHeatHint,
    'no_data' => l10n.activityStatusNoDataHint,
    _ => null,
  };
}

/// Durum rozeti.
class ActivityStatusChip extends StatelessWidget {
  const ActivityStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final p = MilkPalette.of(ActivityStatus.color(status));
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: AppRadius.smAll,
        border: Border.all(color: p.border),
      ),
      child: Text(
        ActivityStatus.label(status),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: p.foreground,
        ),
      ),
    );
  }
}
