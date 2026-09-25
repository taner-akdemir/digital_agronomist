import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/animal_import.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'animal_import_screen.g.dart';

/// Seçilen dosya: adı ve içeriği.
typedef ImportFile = ({String name, List<int> bytes});

/// Dosya seçici; testte yerine sahte konur.
@riverpod
Future<ImportFile?> Function() importFilePicker(Ref ref) => () async {
  final files = await FilePicker.pickFiles(
    type: FileType.custom,
    allowedExtensions: const ['xlsx', 'csv', 'txt'],
  );
  final f = files.firstOrNull;
  if (f == null) return null;
  return (name: f.name, bytes: await f.readAsBytes());
};

/// Toplu hayvan içe aktarma (backend ADR 0063).
///
/// İki adım: dosya seçilince ÖNİZLEME (hiçbir şey yazılmaz, her satırın ne
/// olacağı görünür), sonra onay. Dosyayı okuyan backend: CSV/.xlsx, Türkçe
/// sütun adları, gün önde tarih orada çözülüyor; uygulamada ikinci bir
/// okuyucu ayrışırdı. Yalnızca işletme sahibi açar.
class AnimalImportScreen extends ConsumerWidget {
  const AnimalImportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Listeden içe aktar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: AsyncView(
        value: ref.watch(speciesListProvider),
        errorMessage: 'Türler yüklenemedi',
        onRetry: () => ref.invalidate(speciesListProvider),
        builder: (species) => _Import(species: species),
      ),
    );
  }
}

class _Import extends ConsumerStatefulWidget {
  const _Import({required this.species});

  final List<Species> species;

  @override
  ConsumerState<_Import> createState() => _ImportState();
}

class _ImportState extends ConsumerState<_Import> {
  late String? _speciesId;
  ImportFile? _file;
  AnimalImportReport? _preview;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Türü yazılmamış satırlar için varsayılan: tek tür varsa o, yoksa inek
    // (sürülerin çoğu); kullanıcı değiştirebilir.
    final sp = widget.species;
    _speciesId =
        (sp.length == 1
                ? sp.first
                : sp.where((s) => s.code == 'cow').firstOrNull)
            ?.id ??
        sp.firstOrNull?.id;
  }

  Future<void> _pick() async {
    final f = await ref.read(importFilePickerProvider)();
    if (f == null || !mounted) return;
    setState(() => _file = f);
    await _runPreview();
  }

  Future<void> _runPreview() async {
    final f = _file;
    if (f == null) return;
    setState(() {
      _busy = true;
      _error = null;
      _preview = null;
    });
    try {
      final r = await ref
          .read(repositoryProvider)
          .importAnimals(f.bytes, speciesId: _speciesId, dryRun: true);
      if (mounted) setState(() => _preview = r);
    } catch (e) {
      if (mounted) {
        setState(() => _error = userMessage(e) ?? 'Dosya okunamadı: $e');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _commit() async {
    final f = _file;
    if (f == null) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final r = await ref
          .read(repositoryProvider)
          .importAnimals(f.bytes, speciesId: _speciesId, dryRun: false);
      ref.invalidate(animalsProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${r.create} hayvan eklendi')));
      context.pop();
    } catch (e) {
      if (mounted) {
        setState(() => _error = userMessage(e) ?? 'İçe aktarılamadı: $e');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = _preview;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              const Text(
                'Veterinerden, Birlik\'ten ya da Hayvan Bilgi Sistemi\'nden '
                'aldığınız listeyi yükleyin (Excel .xlsx ya da CSV). İlk satır '
                'sütun başlıkları olmalı; tarihler gün önde (03.04.2021).',
                style: TextStyle(fontSize: 13, color: AppColors.onSurfaceMuted),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Sütunlar: Küpe No (zorunlu) · Tür · Adı · Irkı · RFID · '
                'Doğum Tarihi · Son Buzağılama · Laktasyon · Durumu',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Küpesi zaten kayıtlı hayvanlar değiştirilmez. Hatalı satırlar '
                'atlanır; dosyayı düzeltip yeniden yüklemek güvenlidir.',
                style: TextStyle(fontSize: 13, color: AppColors.onSurfaceMuted),
              ),
              const SizedBox(height: AppSpacing.lg),
              DropdownButtonFormField<String>(
                initialValue: _speciesId,
                decoration: const InputDecoration(
                  labelText: 'Türü yazılmamış satırlar',
                  isDense: true,
                  border: OutlineInputBorder(borderRadius: AppRadius.smAll),
                ),
                items: [
                  for (final s in widget.species)
                    DropdownMenuItem(value: s.id, child: Text(s.nameTr)),
                ],
                onChanged: _busy
                    ? null
                    : (v) {
                        setState(() => _speciesId = v);
                        // Tür satırların sonucunu değiştirir; önizleme tazelenir.
                        _runPreview();
                      },
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton.icon(
                onPressed: _busy ? null : _pick,
                icon: const Icon(Icons.upload_file),
                label: Text(_file == null ? 'Dosya seç' : 'Başka dosya seç'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                ),
              ),
              if (_file != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _file!.name,
                  style: const TextStyle(color: AppColors.onSurfaceMuted),
                ),
              ],
              if (_busy) ...[
                const SizedBox(height: AppSpacing.lg),
                const Center(child: CircularProgressIndicator()),
              ],
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  _error!,
                  style: const TextStyle(color: AppColors.darkRedColor),
                ),
              ],
              if (p != null) ..._report(p),
            ],
          ),
        ),
        if (p != null)
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _busy || p.create == 0 ? null : _commit,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.darkGreenColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.lg,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.mdAll,
                    ),
                  ),
                  child: Text(
                    p.create == 0
                        ? 'Eklenecek hayvan yok'
                        : '${p.create} hayvanı ekle',
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> _report(AnimalImportReport p) {
    final errors = p.rows.where((r) => r.isError).toList();
    final warned = p.rows
        .where((r) => !r.isError && (r.warning ?? '').isNotEmpty)
        .toList();
    final create = p.rows.where((r) => r.outcome == 'create').toList();
    final exists = p.rows.where((r) => r.exists).toList();
    return [
      const SizedBox(height: AppSpacing.lg),
      Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          _Count('${p.create} eklenecek', AppColors.lightGreenColor),
          _Count('${p.exists} zaten kayıtlı', AppColors.veryLightGreyColor),
          if (p.errors > 0)
            _Count('${p.errors} hatalı, atlanacak', AppColors.lightRedColor),
        ],
      ),
      if (p.ignoredColumns.isNotEmpty) ...[
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Alınmayan sütunlar: ${p.ignoredColumns.join(', ')}',
          style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
        ),
      ],
      if (errors.isNotEmpty) ...[
        const _Section('Hatalı satırlar'),
        for (final r in errors)
          _RowTile(r, detail: r.message, color: AppColors.redColor),
      ],
      if (warned.isNotEmpty) ...[
        const _Section('Uyarılar'),
        for (final r in warned)
          _RowTile(r, detail: r.warning, color: AppColors.darkAmberColor),
      ],
      if (create.isNotEmpty) ...[
        const _Section('Eklenecek'),
        for (final r in create) _RowTile(r),
      ],
      if (exists.isNotEmpty) ...[
        const _Section('Zaten kayıtlı (değiştirilmez)'),
        for (final r in exists) _RowTile(r),
      ],
    ];
  }
}

class _Count extends StatelessWidget {
  const _Count(this.text, this.color);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.xs,
    ),
    decoration: BoxDecoration(color: color, borderRadius: AppRadius.smAll),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );
}

class _Section extends StatelessWidget {
  const _Section(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.xs),
    child: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.darkGreenColor,
      ),
    ),
  );
}

class _RowTile extends StatelessWidget {
  const _RowTile(this.row, {this.detail, this.color});

  final AnimalImportRow row;
  final String? detail;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tag = row.earTag.isEmpty ? '—' : row.earTag;
    final name = row.name;
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Text(
        '${row.line}',
        style: const TextStyle(color: AppColors.onSurfaceMuted),
      ),
      minLeadingWidth: AppSpacing.xl,
      title: Text(name == null ? tag : '$tag · $name'),
      subtitle: detail == null
          ? null
          : Text(detail!, style: TextStyle(color: color)),
    );
  }
}
