import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/core/volume.dart';
import 'package:milktrace/data/models/delivery.dart';
import 'package:milktrace/features/deliveries/milk_quality.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:milktrace/widgets/text_prompt_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deliveries_screen.g.dart';

/// Tank teslimleri (backend ADR 0089).
@riverpod
Future<Deliveries> deliveries(Ref ref) =>
    ref.watch(repositoryProvider).deliveries();

/// "+%4.6 · sayaçlar fazla" / "−%2.1 · sayaçlar eksik".
String diffLabel(Delivery d) {
  final pct = d.diffPct.abs().toStringAsFixed(1);
  return d.diffPct >= 0
      ? l10n.deliveriesDiffOver(pct)
      : l10n.deliveriesDiffUnder(pct);
}

/// Teslim girebilir mi: sahip ve operatör (fişi tankerle karşılayan).
bool canEnterDelivery(String? role) =>
    role == 'tenant_owner' || role == 'tenant_operator';

/// Tanker fişi penceresini açar; kaydedilirse true.
Future<bool> showAddDelivery(
  BuildContext context,
  WidgetRef ref, {
  DateTime? today,
}) async {
  final volume = ref.read(volumeFormatProvider);
  final draft = await showDialog<_Draft>(
    context: context,
    builder: (_) =>
        _DeliveryDialog(today: today ?? DateTime.now(), volume: volume),
  );
  if (draft == null || !context.mounted) return false;
  final messenger = ScaffoldMessenger.of(context);
  try {
    final d = await ref
        .read(repositoryProvider)
        .addDelivery(
          day: draft.day,
          volumeMl: draft.ml,
          note: draft.note,
          fatPct: draft.quality.fatPct,
          proteinPct: draft.quality.proteinPct,
          sccK: draft.quality.sccK,
          bacteriaK: draft.quality.bacteriaK,
        );
    ref.invalidate(deliveriesProvider);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          d.mismatch
              ? l10n.deliveriesSavedMismatch(diffLabel(d))
              : d.highScc
              ? l10n.qualityHighScc(
                  ref.read(deliveriesProvider).value?.sccLimitK ?? 400,
                )
              : l10n.deliveriesSaved,
        ),
        backgroundColor: d.mismatch || d.highScc
            ? AppColors.darkAmberColor
            : AppColors.darkGreenColor,
      ),
    );
    return true;
  } catch (e) {
    messenger.showSnackBar(
      SnackBar(
        content: Text(userMessage(e) ?? l10n.commonSaveFailed(e)),
        backgroundColor: AppColors.flowRed,
      ),
    );
    return false;
  }
}

/// Teslim listesi: her satırda tanker, sayaçlar ve fark. Sahip eşiği
/// değiştirir ve yanlış kaydı siler.
class DeliveriesScreen extends ConsumerWidget {
  const DeliveriesScreen({super.key, this.today});

  /// Test için; null ise bugün.
  final DateTime? today;

  Future<void> _tolerance(
    BuildContext context,
    WidgetRef ref,
    double current,
  ) async {
    final raw = await showTextPrompt(
      context,
      title: l10n.deliveriesToleranceTitle,
      label: l10n.deliveriesToleranceLabel,
      helper: l10n.deliveriesToleranceHelper,
      initial: current.toStringAsFixed(1),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
    final pct = raw == null ? null : double.tryParse(raw.replaceAll(',', '.'));
    if (pct == null || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(repositoryProvider).setDeliveryTolerance(pct);
      ref.invalidate(deliveriesProvider);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.commonSaveFailed(e)),
          backgroundColor: AppColors.flowRed,
        ),
      );
    }
  }

  /// Somatik hücre sınırı (backend ADR 0110); fark eşiği aynen gider.
  Future<void> _sccLimit(
    BuildContext context,
    WidgetRef ref,
    Deliveries v,
  ) async {
    final raw = await showTextPrompt(
      context,
      title: l10n.qualitySccLimit,
      label: l10n.qualitySccLimit,
      helper: l10n.qualitySccLimitHelper,
      initial: '${v.sccLimitK}',
      keyboardType: TextInputType.number,
    );
    if (raw == null || !context.mounted) return;
    final limit = int.tryParse(raw.trim());
    final messenger = ScaffoldMessenger.of(context);
    if (limit == null || limit < 50 || limit > 2000) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.qualitySccLimitRange),
          backgroundColor: AppColors.flowRed,
        ),
      );
      return;
    }
    try {
      await ref
          .read(repositoryProvider)
          .setDeliveryTolerance(v.tolerancePct, sccLimitK: limit);
      ref.invalidate(deliveriesProvider);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.commonSaveFailed(e)),
          backgroundColor: AppColors.flowRed,
        ),
      );
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, Delivery d) async {
    final volume = ref.read(volumeFormatProvider);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deliveriesDeleteTitle),
        content: Text(
          l10n.deliveriesDeleteBody(
            Fmt.dayMonthYear(d.deliveredOn),
            volume.amount(d.volumeMl),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.flowRed),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(repositoryProvider).deleteDelivery(d.id);
      ref.invalidate(deliveriesProvider);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.commonDeleteFailed(e)),
          backgroundColor: AppColors.flowRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(deliveriesProvider);
    final role = ref.watch(authProvider).user?.role;
    final isOwner = role == 'tenant_owner';
    final volume = ref.watch(volumeFormatProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.deliveriesTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      floatingActionButton: canEnterDelivery(role)
          ? FloatingActionButton.extended(
              onPressed: () => showAddDelivery(context, ref, today: today),
              backgroundColor: AppColors.darkGreenColor,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: Text(l10n.deliveriesEnter),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(deliveriesProvider.future),
        child: AsyncView(
          value: list,
          errorMessage: l10n.deliveriesLoadFailed,
          onRetry: () => ref.invalidate(deliveriesProvider),
          builder: (v) => ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              96,
            ),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.deliveriesExplainer(
                        v.tolerancePct.toStringAsFixed(1),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.onSurfaceMuted,
                      ),
                    ),
                  ),
                  if (isOwner)
                    IconButton(
                      tooltip: l10n.deliveriesToleranceTitle,
                      icon: const Icon(Icons.tune),
                      onPressed: () => _tolerance(context, ref, v.tolerancePct),
                    ),
                  if (isOwner)
                    IconButton(
                      tooltip: l10n.qualitySccLimit,
                      icon: const Icon(Icons.science_outlined),
                      onPressed: () => _sccLimit(context, ref, v),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              QualityTrendCard(
                items: v.items,
                sccLimitK: v.sccLimitK,
                today: today ?? DateTime.now(),
              ),
              if (v.items.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Text(
                    l10n.deliveriesEmpty,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.onSurfaceMuted),
                  ),
                )
              else
                for (final d in v.items)
                  DeliveryTile(
                    delivery: d,
                    volume: volume,
                    sccLimitK: v.sccLimitK,
                    onDelete: isOwner ? () => _delete(context, ref, d) : null,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tek teslim satırı: tanker, sayaçlar ve fark (eşik aşıldıysa amber).
class DeliveryTile extends StatelessWidget {
  const DeliveryTile({
    super.key,
    required this.delivery,
    required this.volume,
    this.sccLimitK = 400,
    this.onDelete,
  });

  final Delivery delivery;
  final VolumeFormat volume;

  /// Somatik hücre sınırı (bin/mL), uyarı satırı için.
  final int sccLimitK;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final d = delivery;
    final String detail;
    if (!d.compared) {
      detail = l10n.deliveriesNotCompared;
    } else {
      final from = d.periodFrom;
      final span = from == null || from == d.deliveredOn
          ? ''
          : '${Fmt.dayMonthYear(from)} – ';
      detail = l10n.deliveriesMetered(
        span,
        Fmt.dayMonthYear(d.deliveredOn),
        volume.amount(d.meteredMl),
        d.withheldMl > 0
            ? l10n.deliveriesWithheld(volume.amount(d.withheldMl))
            : '',
      );
    }
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(
          color: d.mismatch || d.highScc
              ? AppColors.amberColor
              : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.deliveriesTankerLine(
                    Fmt.dayMonthYear(d.deliveredOn),
                    volume.amount(d.volumeMl),
                  ),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceMuted,
                  ),
                ),
                if (d.compared)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xs),
                    child: Text(
                      diffLabel(d),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: d.mismatch
                            ? AppColors.darkAmberColor
                            : AppColors.darkGreenColor,
                      ),
                    ),
                  ),
                QualityLine(delivery: d, sccLimitK: sccLimitK),
                if (d.note.isNotEmpty || (d.authorName ?? '').isNotEmpty)
                  Text(
                    [
                      if (d.note.isNotEmpty) d.note,
                      if ((d.authorName ?? '').isNotEmpty) d.authorName!,
                    ].join(' · '),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.onSurfaceMuted,
                    ),
                  ),
              ],
            ),
          ),
          if (onDelete != null)
            IconButton(
              tooltip: l10n.commonDeleteWrongRecord,
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }
}

class _Draft {
  const _Draft(this.day, this.ml, this.note, this.quality);

  final DateTime day;
  final int ml;
  final String note;
  final QualityDraft quality;
}

/// Tanker fişi: gün (bugün ya da geçmiş) ve miktar işletmenin biriminde.
/// kg girilirse varsayılan yoğunlukla mL'ye çevrilir: fiş tankın
/// karışık sütü, tek bir türün yoğunluğu yok.
class _DeliveryDialog extends StatefulWidget {
  const _DeliveryDialog({required this.today, required this.volume});

  final DateTime today;
  final VolumeFormat volume;

  @override
  State<_DeliveryDialog> createState() => _DeliveryDialogState();
}

class _DeliveryDialogState extends State<_DeliveryDialog> {
  late DateTime _day = DateTime(
    widget.today.year,
    widget.today.month,
    widget.today.day,
  );
  final _amount = TextEditingController();
  final _note = TextEditingController();
  final _quality = QualityControllers();
  String? _error;

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    _quality.dispose();
    super.dispose();
  }

  void _save() {
    final v = double.tryParse(_amount.text.trim().replaceAll(',', '.'));
    if (v == null || v <= 0) {
      setState(() => _error = l10n.deliveriesEnterAmount);
      return;
    }
    final quality = _quality.read();
    if (quality == null) {
      setState(() => _error = l10n.qualityInvalid);
      return;
    }
    final litres = widget.volume.isKg ? v / VolumeFormat.defaultDensity : v;
    Navigator.of(
      context,
    ).pop(_Draft(_day, (litres * 1000).round(), _note.text.trim(), quality));
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(borderRadius: AppRadius.mdAll);
    return AlertDialog(
      title: Text(l10n.deliveriesTankDelivery),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedButton(
              onPressed: () async {
                final today = DateTime(
                  widget.today.year,
                  widget.today.month,
                  widget.today.day,
                );
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _day,
                  firstDate: today.subtract(const Duration(days: 60)),
                  lastDate: today,
                );
                if (picked != null) setState(() => _day = picked);
              },
              child: Text(l10n.deliveriesDay(Fmt.dayMonthYear(_day))),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _amount,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              decoration: InputDecoration(
                labelText: l10n.deliveriesAmountLabel(widget.volume.label),
                border: border,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _note,
              decoration: InputDecoration(
                labelText: l10n.commonNoteOptional,
                border: border,
              ),
            ),
            QualityInputs(controllers: _quality),
            if (_error != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                _error!,
                style: const TextStyle(color: AppColors.darkRedColor),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(onPressed: _save, child: Text(l10n.commonSave)),
      ],
    );
  }
}
