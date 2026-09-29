import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_import.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/features/history/history_providers.dart';
import 'package:milktrace/l10n/l10n.dart';
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

/// Toplu hayvan içe aktarma (backend ADR 0063, 0101).
///
/// İki adım: dosya seçilince ÖNİZLEME (hiçbir şey yazılmaz, her satırın ne
/// olacağı görünür), sonra onay. "Kayıtlı hayvanları güncelle" açıksa
/// önizleme ve onay `update=true` ile gider: kayıtlı küpenin dolu hücreleri
/// yazılır, satırda alan alan eski → yeni görünür. Dosyayı okuyan backend: CSV/.xlsx, Türkçe
/// sütun adları, gün önde tarih orada çözülüyor; uygulamada ikinci bir
/// okuyucu ayrışırdı. Yalnızca işletme sahibi açar.
class AnimalImportScreen extends ConsumerWidget {
  const AnimalImportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.animalImportTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: AsyncView(
        value: ref.watch(speciesListProvider),
        errorMessage: l10n.animalImportSpeciesLoadFailed,
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

  /// Kayıtlı hayvanlar güncellensin mi (backend ADR 0101); kapalı başlar.
  bool _update = false;
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
          .importAnimals(
            f.bytes,
            speciesId: _speciesId,
            dryRun: true,
            update: _update,
          );
      if (mounted) setState(() => _preview = r);
    } catch (e) {
      if (mounted) {
        setState(
          () => _error = userMessage(e) ?? l10n.animalImportReadFailed('$e'),
        );
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
          .importAnimals(
            f.bytes,
            speciesId: _speciesId,
            dryRun: false,
            update: _update,
          );
      ref.invalidate(animalsProvider);
      // Güncellenen hayvanın grubu değişmiş, yeni grup açılmış olabilir.
      if (r.update > 0 || r.newGroups.isNotEmpty) {
        ref.invalidate(animalGroupsProvider);
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            r.update > 0
                ? l10n.animalImportSaved(r.create, r.update)
                : l10n.animalImportAdded(r.create),
          ),
        ),
      );
      context.pop();
    } catch (e) {
      if (mounted) {
        setState(
          () => _error = userMessage(e) ?? l10n.animalImportFailed('$e'),
        );
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
              Text(
                l10n.animalImportIntro,
                style: TextStyle(fontSize: 13, color: AppColors.onSurfaceMuted),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.animalImportColumns,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.animalImportRules,
                style: TextStyle(fontSize: 13, color: AppColors.onSurfaceMuted),
              ),
              const SizedBox(height: AppSpacing.lg),
              DropdownButtonFormField<String>(
                initialValue: _speciesId,
                decoration: InputDecoration(
                  labelText: l10n.animalImportDefaultSpecies,
                  isDense: true,
                  border: const OutlineInputBorder(
                    borderRadius: AppRadius.smAll,
                  ),
                ),
                items: [
                  for (final s in widget.species)
                    DropdownMenuItem(value: s.id, child: Text(s.displayName)),
                ],
                onChanged: _busy
                    ? null
                    : (v) {
                        setState(() => _speciesId = v);
                        // Tür satırların sonucunu değiştirir; önizleme tazelenir.
                        _runPreview();
                      },
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: _update,
                activeThumbColor: AppColors.darkGreenColor,
                title: Text(l10n.animalImportUpdateSwitch),
                subtitle: Text(
                  l10n.animalImportUpdateHint,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceMuted,
                  ),
                ),
                onChanged: _busy
                    ? null
                    : (v) {
                        setState(() => _update = v);
                        // Kayıtlı satırların sonucu değişir; önizleme tazelenir.
                        _runPreview();
                      },
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton.icon(
                onPressed: _busy ? null : _pick,
                icon: const Icon(Icons.upload_file),
                label: Text(
                  _file == null
                      ? l10n.animalImportPickFile
                      : l10n.animalImportPickOtherFile,
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                ),
              ),
              if (_file != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _file!.name,
                  style: TextStyle(color: AppColors.onSurfaceMuted),
                ),
              ],
              if (_busy) ...[
                const SizedBox(height: AppSpacing.lg),
                const Center(child: CircularProgressIndicator()),
              ],
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(_error!, style: TextStyle(color: AppColors.darkRedColor)),
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
                  onPressed: _busy || p.toWrite == 0 ? null : _commit,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.brandFill,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.lg,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.mdAll,
                    ),
                  ),
                  child: Text(_commitLabel(p)),
                ),
              ),
            ),
          ),
      ],
    );
  }

  static String _commitLabel(AnimalImportReport p) {
    if (p.update > 0) return l10n.animalImportSaveN(p.create, p.update);
    if (p.create > 0) return l10n.animalImportAddN(p.create);
    return p.updateExisting
        ? l10n.animalImportNothingToSave
        : l10n.animalImportNothingToAdd;
  }

  List<Widget> _report(AnimalImportReport p) {
    final errors = p.rows.where((r) => r.isError).toList();
    final warned = p.rows
        .where((r) => !r.isError && (r.warning ?? '').isNotEmpty)
        .toList();
    final create = p.rows.where((r) => r.outcome == 'create').toList();
    final exists = p.rows.where((r) => r.exists).toList();
    final update = p.rows.where((r) => r.outcome == 'update').toList();
    final unchanged = p.rows.where((r) => r.outcome == 'unchanged').toList();
    return [
      const SizedBox(height: AppSpacing.lg),
      Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          _Count(
            l10n.animalImportCountCreate(p.create),
            AppColors.lightGreenColor,
          ),
          if (p.updateExisting) ...[
            _Count(
              l10n.animalImportCountUpdate(p.update),
              AppColors.lightAmberColor,
            ),
            _Count(
              l10n.animalImportCountUnchanged(p.unchanged),
              AppColors.veryLightGreyColor,
            ),
          ] else
            _Count(
              l10n.animalImportCountExists(p.exists),
              AppColors.veryLightGreyColor,
            ),
          if (p.errors > 0)
            _Count(
              l10n.animalImportCountErrors(p.errors),
              AppColors.lightRedColor,
            ),
        ],
      ),
      if (p.newGroups.isNotEmpty) ...[
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.animalImportNewGroups(p.newGroups.join(', ')),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
      if (p.ignoredColumns.isNotEmpty) ...[
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.animalImportIgnoredColumns(p.ignoredColumns.join(', ')),
          style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
        ),
      ],
      if (errors.isNotEmpty) ...[
        _Section(l10n.animalImportSectionErrors),
        for (final r in errors)
          _RowTile(r, detail: r.message, color: AppColors.redColor),
      ],
      if (warned.isNotEmpty) ...[
        _Section(l10n.animalImportSectionWarnings),
        for (final r in warned)
          _RowTile(r, detail: r.warning, color: AppColors.darkAmberColor),
      ],
      if (create.isNotEmpty) ...[
        _Section(l10n.animalImportSectionCreate),
        for (final r in create) _RowTile(r),
      ],
      if (update.isNotEmpty) ...[
        _Section(l10n.animalImportSectionUpdate),
        for (final r in update)
          _RowTile(r, detail: r.changes.map(changeLabel).join('\n')),
      ],
      if (exists.isNotEmpty) ...[
        _Section(l10n.animalImportSectionExists),
        for (final r in exists) _RowTile(r),
      ],
      if (unchanged.isNotEmpty) ...[
        _Section(l10n.animalImportSectionUnchanged),
        for (final r in unchanged) _RowTile(r),
      ],
    ];
  }
}

/// "Ad: Sarıkız → Sarı". Değer ham gelir (backend ADR 0101): tarih
/// YYYY-AA-GG, durum kodu; boş değer "—". Tanınmayan alan ham gösterilir.
String changeLabel(AnimalImportChange c) {
  final label = switch (c.field) {
    'name' => l10n.animalImportFieldName,
    'breed' => l10n.animalImportFieldBreed,
    'rfid' => l10n.animalImportFieldRfid,
    'status' => l10n.animalImportFieldStatus,
    'birthDate' => l10n.animalImportFieldBirthDate,
    'lastCalvingDate' => l10n.animalImportFieldCalvingDate,
    'lactationNo' => l10n.animalImportFieldLactationNo,
    'group' => l10n.animalImportFieldGroup,
    'dam' => l10n.lineageDam,
    'sire' => l10n.lineageSire,
    _ => c.field,
  };
  String value(String v) {
    if (v.isEmpty) return '—';
    return switch (c.field) {
      'status' => Animal(
        id: '',
        speciesId: '',
        earTag: '',
        status: v,
      ).statusLabel,
      'birthDate' || 'lastCalvingDate' => switch (DateTime.tryParse(v)) {
        final d? => Fmt.dayMonthYear(d),
        null => v,
      },
      _ => v,
    };
  }

  return l10n.animalImportChange(label, value(c.from), value(c.to));
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
      style: TextStyle(
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
        style: TextStyle(color: AppColors.onSurfaceMuted),
      ),
      minLeadingWidth: AppSpacing.xl,
      title: Text(name == null ? tag : '$tag · $name'),
      subtitle: detail == null
          ? null
          : Text(detail!, style: TextStyle(color: color)),
    );
  }
}
