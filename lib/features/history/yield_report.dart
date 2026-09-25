import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'yield_report.g.dart';

/// Rapor dosyasını sistemin paylaşım penceresine verir (WhatsApp, e-posta,
/// Dosyalar). Testte yerine sahte konur.
@riverpod
Future<void> Function(ReportFile) reportSharer(Ref ref) => (f) async {
  await SharePlus.instance.share(
    ShareParams(
      files: [
        XFile.fromData(
          f.bytes,
          name: f.name,
          mimeType:
              'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        ),
      ],
      fileNameOverrides: [f.name],
      subject: 'Milk Trace verim raporu',
    ),
  );
};

/// Rapor dönemleri (gün). Backend en çok 92 gün veriyor (ADR 0064).
const reportPeriods = [7, 30, 90];

/// Verim raporu: dönem seçilir, .xlsx indirilir ve paylaşılır (backend ADR
/// 0064). Bütün roller; okuru çoğunlukla veteriner ya da danışman.
Future<void> showYieldReportSheet(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      // Kısa ekranda ya da büyük yazıda hata satırı eklenince taşmasın.
      isScrollControlled: true,
      builder: (_) => const _ReportSheet(),
    );

class _ReportSheet extends ConsumerStatefulWidget {
  const _ReportSheet();

  @override
  ConsumerState<_ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends ConsumerState<_ReportSheet> {
  int? _busyDays;
  String? _error;

  Future<void> _run(int days) async {
    setState(() {
      _busyDays = days;
      _error = null;
    });
    try {
      final now = DateTime.now();
      final to = DateTime(now.year, now.month, now.day);
      final file = await ref
          .read(repositoryProvider)
          .yieldReport(
            from: to.subtract(Duration(days: days - 1)),
            to: to,
          );
      await ref.read(reportSharerProvider)(file);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        setState(() => _error = userMessage(e) ?? 'Rapor alınamadı: $e');
      }
    } finally {
      if (mounted) setState(() => _busyDays = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Verim raporu',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.darkGreenColor,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              const Text(
                'Hayvan başına günlük verim (litre), Excel dosyası. '
                'Veterinere ya da danışmana gönderebilirsiniz.',
                style: TextStyle(fontSize: 13, color: AppColors.onSurfaceMuted),
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final d in reportPeriods)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: _busyDays == d
                      ? const SizedBox.square(
                          dimension: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.table_view_outlined),
                  title: Text('Son $d gün'),
                  enabled: _busyDays == null,
                  onTap: () => _run(d),
                ),
              if (_error != null)
                Text(
                  _error!,
                  style: const TextStyle(color: AppColors.darkRedColor),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
