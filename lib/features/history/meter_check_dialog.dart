import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/core/volume.dart';
import 'package:milktrace/data/models/animal_milking.dart';
import 'package:milktrace/data/models/meter_check.dart';
import 'package:milktrace/features/devices/devices_providers.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

/// Elle ölçüm girebilir mi (backend ADR 0124): sahip ve operatör — kovayı
/// tartan sağımcı. Backend diğer rollere 403.
bool canCheckMeter(String? role) =>
    role == 'tenant_owner' || role == 'tenant_operator';

/// Sayaç kontrolü (backend ADR 0124): sağımın sütünü elle ölçülen miktarla
/// karşılaştırır. Sapmayı ve sayacın özetini SUNUCU hesaplar; uygulama
/// katsayıyı DEĞİŞTİRMEZ (kurulum ekibinin işi). Kaydedilirse sonuç.
Future<MeterCheckResult?> showMeterCheck(
  BuildContext context,
  WidgetRef ref, {
  required AnimalMilking milking,
  String? species,
}) async {
  final volume = ref.read(volumeFormatProvider);
  final ml = await showDialog<int>(
    context: context,
    builder: (_) =>
        _MeterCheckDialog(milking: milking, volume: volume, species: species),
  );
  if (ml == null || !context.mounted) return null;
  final messenger = ScaffoldMessenger.of(context);
  try {
    final r = await ref.read(repositoryProvider).addMeterCheck(milking.id, ml);
    ref.invalidate(meterSummariesProvider);
    final s = r.summary;
    final line = l10n.meterCheckResult(
      signedPct(r.check.deviationPct),
      s.checks,
      signedPct(s.avgDeviationPct),
    );
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          s.needsCalibration ? '$line\n${l10n.meterCheckCalibrate}' : line,
        ),
        backgroundColor: s.needsCalibration
            ? AppColors.warningFill
            : AppColors.brandFill,
      ),
    );
    return r;
  } catch (e) {
    // Sayaçsız sağım 422: sunucunun metni olduğu gibi.
    messenger.showSnackBar(
      SnackBar(
        content: Text(userMessage(e) ?? l10n.commonSaveFailed(e)),
        backgroundColor: AppColors.dangerFill,
      ),
    );
    return null;
  }
}

/// Miktar işletmenin biriminde. kg girilirse HAYVANIN TÜRÜNÜN yoğunluğuyla
/// mL'ye çevrilir — ekranda aynı sağımın kg'ı da o yoğunlukla gösteriliyor;
/// tür bilinmiyorsa varsayılan (1,03). Tank fişinden farkı bu: orada süt
/// karışık, burada tek hayvanın.
class _MeterCheckDialog extends StatefulWidget {
  const _MeterCheckDialog({
    required this.milking,
    required this.volume,
    this.species,
  });

  final AnimalMilking milking;
  final VolumeFormat volume;
  final String? species;

  @override
  State<_MeterCheckDialog> createState() => _MeterCheckDialogState();
}

class _MeterCheckDialogState extends State<_MeterCheckDialog> {
  final _amount = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  void _save() {
    final v = double.tryParse(_amount.text.trim().replaceAll(',', '.'));
    if (v == null || v <= 0) {
      setState(() => _error = l10n.meterCheckEnterAmount);
      return;
    }
    final density = widget.volume.isKg
        ? widget.volume.density[widget.species] ?? VolumeFormat.defaultDensity
        : 1.0;
    Navigator.of(context).pop((v / density * 1000).round());
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(borderRadius: AppRadius.mdAll);
    final m = widget.milking;
    final started = m.startedAt;
    final when = started == null
        ? Fmt.sessionType(m.sessionType)
        : '${Fmt.dayMonth(started)} ${Fmt.sessionType(m.sessionType)}';
    return AlertDialog(
      title: Text(l10n.meterCheckTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.meterCheckIntro(
              when,
              widget.volume.amount(m.volumeMl, species: widget.species),
            ),
            style: TextStyle(fontSize: 13, color: AppColors.onSurfaceMuted),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _amount,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
            ],
            decoration: InputDecoration(
              labelText: l10n.meterCheckAmountLabel(widget.volume.label),
              border: border,
            ),
            onSubmitted: (_) => _save(),
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(_error!, style: TextStyle(color: AppColors.darkRedColor)),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: _save,
          style: FilledButton.styleFrom(backgroundColor: AppColors.brandFill),
          child: Text(l10n.commonSave),
        ),
      ],
    );
  }
}
