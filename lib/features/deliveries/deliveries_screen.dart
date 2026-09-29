import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/core/volume.dart';
import 'package:milktrace/data/models/delivery.dart';
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
  return d.diffPct >= 0 ? '+%$pct · sayaçlar fazla' : '−%$pct · sayaçlar eksik';
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
        .addDelivery(day: draft.day, volumeMl: draft.ml, note: draft.note);
    ref.invalidate(deliveriesProvider);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          d.mismatch
              ? 'Teslim kaydedildi — sayaçlarla fark var: ${diffLabel(d)}'
              : 'Teslim kaydedildi',
        ),
        backgroundColor: d.mismatch
            ? AppColors.darkAmberColor
            : AppColors.darkGreenColor,
      ),
    );
    return true;
  } catch (e) {
    messenger.showSnackBar(
      SnackBar(
        content: Text(userMessage(e) ?? 'Kaydedilemedi: $e'),
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
      title: 'Fark eşiği',
      label: 'Uyarı için fark (%)',
      helper: 'Sayaçlar ile tanker bundan fazla ayrışırsa uyarı.',
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
          content: Text(userMessage(e) ?? 'Kaydedilemedi: $e'),
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
        title: const Text('Teslim silinsin mi?'),
        content: Text(
          '${Fmt.dayMonthYear(d.deliveredOn)} · ${volume.amount(d.volumeMl)}\n'
          'Yalnızca yanlış girilen kaydı silin; doğrusunu yeniden girin.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.flowRed),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sil'),
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
          content: Text(userMessage(e) ?? 'Silinemedi: $e'),
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
          tooltip: 'Geri',
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Tank teslimleri',
          style: TextStyle(
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
              label: const Text('Teslim gir'),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(deliveriesProvider.future),
        child: AsyncView(
          value: list,
          errorMessage: 'Teslimler yüklenemedi',
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
                      'Tanker fişi, önceki teslimden bu yana sayaçların '
                      'ölçtüğüyle karşılaştırılır (ayrılan süt hariç). Fark '
                      '%${v.tolerancePct.toStringAsFixed(1)} üstündeyse uyarı.',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.onSurfaceMuted,
                      ),
                    ),
                  ),
                  if (isOwner)
                    IconButton(
                      tooltip: 'Fark eşiği',
                      icon: const Icon(Icons.tune),
                      onPressed: () => _tolerance(context, ref, v.tolerancePct),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              if (v.items.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: Text(
                    'Henüz teslim girilmedi. İlk teslim karşılaştırılmaz; '
                    'fark ikinci teslimden itibaren hesaplanır.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.onSurfaceMuted),
                  ),
                )
              else
                for (final d in v.items)
                  DeliveryTile(
                    delivery: d,
                    volume: volume,
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
    this.onDelete,
  });

  final Delivery delivery;
  final VolumeFormat volume;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final d = delivery;
    final String detail;
    if (!d.compared) {
      detail = 'Karşılaştırılmadı (önceki teslim ya da sayaç verisi yok)';
    } else {
      final from = d.periodFrom;
      final span = from == null || from == d.deliveredOn
          ? ''
          : '${Fmt.dayMonthYear(from)} – ';
      detail =
          'Sayaçlar $span${Fmt.dayMonthYear(d.deliveredOn)}: '
          '${volume.amount(d.meteredMl)}'
          '${d.withheldMl > 0 ? ' (ayrılan ${volume.amount(d.withheldMl)} hariç)' : ''}';
    }
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(
          color: d.mismatch ? AppColors.amberColor : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${Fmt.dayMonthYear(d.deliveredOn)} · tanker '
                  '${volume.amount(d.volumeMl)}',
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
              tooltip: 'Yanlış kaydı sil',
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }
}

class _Draft {
  const _Draft(this.day, this.ml, this.note);

  final DateTime day;
  final int ml;
  final String note;
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
  String? _error;

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  void _save() {
    final v = double.tryParse(_amount.text.trim().replaceAll(',', '.'));
    if (v == null || v <= 0) {
      setState(() => _error = 'Tanker fişindeki miktarı girin.');
      return;
    }
    final litres = widget.volume.isKg ? v / VolumeFormat.defaultDensity : v;
    Navigator.of(
      context,
    ).pop(_Draft(_day, (litres * 1000).round(), _note.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(borderRadius: AppRadius.mdAll);
    return AlertDialog(
      title: const Text('Tank teslimi'),
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
              child: Text('Gün: ${Fmt.dayMonthYear(_day)}'),
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
                labelText: 'Teslim edilen (${widget.volume.label})',
                border: border,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _note,
              decoration: const InputDecoration(
                labelText: 'Not (isteğe bağlı)',
                border: border,
              ),
            ),
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
          child: const Text('Vazgeç'),
        ),
        FilledButton(onPressed: _save, child: const Text('Kaydet')),
      ],
    );
  }
}
