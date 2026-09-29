import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/farm.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'farm_location_screen.g.dart';

/// İşletmenin tesisleri (konum ekranı için).
@riverpod
Future<List<Farm>> farmList(Ref ref) => ref.watch(repositoryProvider).farms();

/// "39.9208, 32.8541" → (enlem, boylam); biçim ya da aralık bozuksa null.
/// Google Haritalar'ın kopyaladığı biçim budur.
(double, double)? parseCoordinate(String raw) {
  final parts = raw
      .split(RegExp(r'[,;\s]+'))
      .where((p) => p.isNotEmpty)
      .toList();
  if (parts.length != 2) return null;
  final lat = double.tryParse(parts[0]);
  final lon = double.tryParse(parts[1]);
  if (lat == null || lon == null || lat.abs() > 90 || lon.abs() > 180) {
    return null;
  }
  return (lat, lon);
}

/// Tesis konumu (backend ADR 0119): ısı stresi tahmini için. Hesap
/// kartından, yalnızca işletme sahibine.
class FarmLocationScreen extends ConsumerWidget {
  const FarmLocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farms = ref.watch(farmListProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.farmLocationTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: AsyncView(
        value: farms,
        errorMessage: l10n.commonLoadFailed,
        onRetry: () => ref.invalidate(farmListProvider),
        builder: (list) => ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              l10n.farmLocationIntro,
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
            ),
            const SizedBox(height: AppSpacing.md),
            for (final f in list) _FarmRow(farm: f),
          ],
        ),
      ),
    );
  }
}

class _FarmRow extends ConsumerStatefulWidget {
  const _FarmRow({required this.farm});

  final Farm farm;

  @override
  ConsumerState<_FarmRow> createState() => _FarmRowState();
}

class _FarmRowState extends ConsumerState<_FarmRow> {
  late final _ctl = TextEditingController(
    text: widget.farm.latitude == null
        ? ''
        : '${widget.farm.latitude}, ${widget.farm.longitude}',
  );
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  Future<void> _save({bool clear = false}) async {
    final c = clear ? null : parseCoordinate(_ctl.text);
    if (!clear && c == null) {
      setState(() => _error = l10n.farmLocationInvalid);
      return;
    }
    setState(() {
      _error = null;
      _busy = true;
    });
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(repositoryProvider)
          .setFarmLocation(widget.farm.id, c?.$1, c?.$2);
      if (clear) _ctl.clear();
      ref.invalidate(farmListProvider);
      messenger.showSnackBar(SnackBar(content: Text(l10n.farmLocationSaved)));
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.commonSaveFailed(e)),
          backgroundColor: AppColors.dangerFill,
        ),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.farm.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _ctl,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
            decoration: InputDecoration(
              labelText: l10n.farmLocationCoordinates,
              errorText: _error,
              border: const OutlineInputBorder(borderRadius: AppRadius.mdAll),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              FilledButton(
                onPressed: _busy ? null : _save,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.brandFill,
                ),
                child: Text(l10n.commonSave),
              ),
              if (widget.farm.latitude != null) ...[
                const SizedBox(width: AppSpacing.sm),
                TextButton(
                  onPressed: _busy ? null : () => _save(clear: true),
                  child: Text(l10n.farmLocationClear),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
