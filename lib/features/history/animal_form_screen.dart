import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/features/history/history_providers.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';

/// Hayvan ekleme ve düzenleme (§8.5 POST/PUT /animals, backend ADR 0049).
///
/// Yalnızca işletme sahibi açar (düğmeler başkasına görünmez, backend de 403
/// döner). Düzenleme TAM kayıttır: form bütün alanları gönderir, boş
/// bırakılan alan silinir. Verim sınıfı formda YOK — gece hesabının alanı.
class AnimalFormScreen extends ConsumerWidget {
  const AnimalFormScreen({
    super.key,
    this.animalId,
    this.damId,
    this.birthDate,
  });

  /// Düzenlenecek hayvan; null ise yeni hayvan.
  final String? animalId;

  /// Yeni yavru kısayolu (backend ADR 0114): anne ve doğum günü.
  final String? damId;
  final DateTime? birthDate;

  bool get _isEdit => animalId != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final species = ref.watch(speciesListProvider);
    // Yavru kısayolunda annenin türü için de liste gerekir.
    final animals = _isEdit || damId != null
        ? ref.watch(animalsProvider)
        : const AsyncData(<Animal>[]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEdit ? l10n.animalFormEditTitle : l10n.animalFormNewTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: AsyncView(
        value: species,
        errorMessage: l10n.animalFormSpeciesFailed,
        builder: (speciesList) => AsyncView(
          value: animals,
          errorMessage: l10n.animalFormAnimalFailed,
          builder: (list) {
            final existing = _isEdit
                ? list.where((a) => a.id == animalId).firstOrNull
                : null;
            if (_isEdit && existing == null) {
              return Center(child: Text(l10n.animalFormNotFound));
            }
            return _Form(
              species: speciesList,
              existing: existing,
              damId: damId,
              damSpeciesId: list
                  .where((a) => a.id == damId)
                  .firstOrNull
                  ?.speciesId,
              birthDate: birthDate,
            );
          },
        ),
      ),
    );
  }
}

/// Durumlar ve Türkçe adları (Animal.statusLabel ile aynı).
const _statuses = ['active', 'dry', 'sold', 'slaughtered', 'dead'];

class _Form extends ConsumerStatefulWidget {
  const _Form({
    required this.species,
    this.existing,
    this.damId,
    this.damSpeciesId,
    this.birthDate,
  });

  final List<Species> species;
  final Animal? existing;
  final String? damId;

  /// Yavru kısayolunda tür annenin türüyle gelir (anne aynı türden olmalı).
  final String? damSpeciesId;
  final DateTime? birthDate;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _earTag;
  late final TextEditingController _name;
  late final TextEditingController _breed;
  late final TextEditingController _rfid;
  late final TextEditingController _lactation;
  late final TextEditingController _sire;

  /// Anne (backend ADR 0114); null = yok. PUT tam kayıt: her zaman gider.
  late String? _damId;

  /// Çıkış nedeni (backend ADR 0122); çıkış durumunda sorulur.
  late String? _exitReason;
  late String? _speciesId;
  late String _status;

  /// Grup (backend ADR 0092); null = grupsuz. PUT tam kayıt: her zaman gider.
  late String? _groupId;
  DateTime? _birth;
  DateTime? _calving;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final a = widget.existing;
    _earTag = TextEditingController(text: a?.earTag ?? '');
    _name = TextEditingController(text: a?.name ?? '');
    _breed = TextEditingController(text: a?.breed ?? '');
    _rfid = TextEditingController(text: a?.rfid ?? '');
    _lactation = TextEditingController(text: '${a?.lactationNo ?? 0}');
    // Yeni hayvanda tür tek ise (keçi çiftliği) seçili gelir.
    _speciesId =
        a?.speciesId ??
        widget.damSpeciesId ??
        (widget.species.length == 1 ? widget.species.first.id : null);
    _status = a?.status ?? 'active';
    _groupId = a?.groupId;
    _damId = a?.damId ?? widget.damId;
    _exitReason = a?.exitReason;
    _sire = TextEditingController(text: a?.sireCode ?? '');
    _birth = a?.birthDate ?? widget.birthDate;
    _calving = a?.lastCalvingDate;
  }

  @override
  void dispose() {
    for (final c in [_earTag, _name, _breed, _rfid, _lactation, _sire]) {
      c.dispose();
    }
    super.dispose();
  }

  String? _nullIfBlank(String s) => s.trim().isEmpty ? null : s.trim();

  /// Anne adayları: seçili türden, kendisi hariç (döngüyü sunucu da denetler).
  List<Animal> _damCandidates(List<Animal> all) => [
    for (final a in all)
      if (a.speciesId == _speciesId && a.id != widget.existing?.id) a,
  ]..sort((a, b) => a.earTag.compareTo(b.earTag));

  Future<void> _save() async {
    if (!(_key.currentState?.validate() ?? false)) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final base = widget.existing;
    final draft = Animal(
      id: base?.id ?? '',
      speciesId: _speciesId!,
      earTag: _earTag.text.trim(),
      name: _nullIfBlank(_name.text),
      breed: _nullIfBlank(_breed.text),
      rfid: _nullIfBlank(_rfid.text),
      birthDate: _birth,
      lastCalvingDate: _calving,
      lactationNo: int.tryParse(_lactation.text.trim()) ?? 0,
      status: _status,
      groupId: _groupId,
      damId: _damId,
      sireCode: _nullIfBlank(_sire.text),
      exitReason: _exitReason,
    );
    try {
      final saved = await ref.read(repositoryProvider).saveAnimal(draft);
      ref
        ..invalidate(animalsProvider)
        ..invalidate(animalGroupsProvider);
      // Durum değiştiyse backend not düştü (ADR 0057): detay onu göstersin.
      ref.invalidate(animalNotesProvider(saved.id));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            base == null ? l10n.animalFormAdded : l10n.animalFormUpdated,
          ),
        ),
      );
      context.go('/history/animal/${saved.id}');
    } catch (e) {
      setState(() => _error = userMessage(e) ?? l10n.commonSaveFailed(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _pickDate({
    required DateTime? current,
    required ValueChanged<DateTime?> onPicked,
  }) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? now,
      firstDate: DateTime(now.year - 25),
      // Gelecek seçilemez: backend de reddediyor.
      lastDate: now,
    );
    if (picked != null) onPicked(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _field(
            _earTag,
            l10n.animalFormEarTag,
            helper: l10n.animalFormEarTagHelper,
            validator: (v) =>
                (v ?? '').trim().isEmpty ? l10n.animalFormEarTagRequired : null,
          ),
          _gap,
          DropdownButtonFormField<String>(
            initialValue: _speciesId,
            decoration: _decoration(l10n.animalFormSpecies),
            items: [
              for (final s in widget.species)
                DropdownMenuItem(value: s.id, child: Text(s.displayName)),
            ],
            validator: (v) => v == null ? l10n.animalFormSpeciesRequired : null,
            onChanged: (v) => setState(() => _speciesId = v),
          ),
          _gap,
          _field(_name, l10n.animalFormName),
          _gap,
          _field(_breed, l10n.animalFormBreed),
          _gap,
          _field(
            _rfid,
            l10n.animalFormRfid,
            helper: l10n.animalFormRfidHelper,
            keyboard: TextInputType.number,
          ),
          _gap,
          _DateRow(
            label: l10n.animalFormBirthDate,
            value: _birth,
            onPick: () => _pickDate(
              current: _birth,
              onPicked: (d) => setState(() => _birth = d),
            ),
            onClear: () => setState(() => _birth = null),
          ),
          _DateRow(
            label: l10n.animalFormLastCalving,
            value: _calving,
            onPick: () => _pickDate(
              current: _calving,
              onPicked: (d) => setState(() => _calving = d),
            ),
            onClear: () => setState(() => _calving = null),
          ),
          _gap,
          _field(
            _lactation,
            l10n.animalFormLactationNo,
            keyboard: TextInputType.number,
            formatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          _gap,
          DropdownButtonFormField<String>(
            initialValue: _status,
            decoration: _decoration(
              l10n.animalFormStatus,
              helper: l10n.animalFormStatusHelper,
            ),
            items: [
              for (final s in _statuses)
                DropdownMenuItem(
                  value: s,
                  child: Text(
                    Animal(
                      id: '',
                      speciesId: '',
                      earTag: '',
                      status: s,
                    ).statusLabel,
                  ),
                ),
            ],
            onChanged: (v) => setState(() => _status = v ?? _status),
          ),
          // Çıkış nedeni (ADR 0122): satıldı/kesildi/öldü seçilince zorunlu.
          if (_status == 'sold' ||
              _status == 'slaughtered' ||
              _status == 'dead') ...[
            _gap,
            DropdownButtonFormField<String>(
              initialValue: _exitReason,
              decoration: _decoration(l10n.exitReasonLabel),
              items: [
                for (final r in exitReasons)
                  DropdownMenuItem(value: r, child: Text(exitReasonLabel(r))),
              ],
              validator: (v) => v == null ? l10n.exitReasonRequired : null,
              onChanged: (v) => setState(() => _exitReason = v),
            ),
          ],
          // Grup (ADR 0092): tanımlı grup yoksa alan çıkmaz; gruplar
          // Geçmiş → Hayvanlar → Gruplar'da açılır.
          if (ref.watch(animalGroupsProvider).value case final groups?
              when groups.isNotEmpty) ...[
            _gap,
            DropdownButtonFormField<String?>(
              initialValue: groups.any((g) => g.id == _groupId)
                  ? _groupId
                  : null,
              decoration: _decoration(l10n.animalFormGroup),
              items: [
                DropdownMenuItem<String?>(child: Text(l10n.animalFormNoGroup)),
                for (final g in groups)
                  DropdownMenuItem<String?>(value: g.id, child: Text(g.name)),
              ],
              onChanged: (v) => setState(() => _groupId = v),
            ),
          ],
          // Soy (backend ADR 0114): anne aynı türden, kendisi değil.
          if (ref.watch(animalsProvider).value case final all?) ...[
            _gap,
            DropdownButtonFormField<String?>(
              initialValue: _damCandidates(all).any((a) => a.id == _damId)
                  ? _damId
                  : null,
              isExpanded: true,
              decoration: _decoration(l10n.lineageDam),
              items: [
                DropdownMenuItem<String?>(child: Text(l10n.lineageNoDam)),
                for (final a in _damCandidates(all))
                  DropdownMenuItem<String?>(
                    value: a.id,
                    child: Text(
                      a.name == null ? a.earTag : '${a.earTag} · ${a.name}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
              onChanged: (v) => setState(() => _damId = v),
            ),
          ],
          _gap,
          TextFormField(
            controller: _sire,
            decoration: _decoration(
              l10n.lineageSire,
            ).copyWith(helperText: l10n.lineageSireHelper),
            validator: (v) =>
                (v ?? '').trim().length > 60 ? l10n.lineageSireTooLong : null,
          ),
          if (_error != null) ...[
            _gap,
            Text(_error!, style: TextStyle(color: AppColors.darkRedColor)),
          ],
          const SizedBox(height: AppSpacing.xl),
          FilledButton(
            onPressed: _busy ? null : _save,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.brandFill,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadius.mdAll,
              ),
            ),
            child: Text(_busy ? l10n.animalFormSaving : l10n.commonSave),
          ),
        ],
      ),
    );
  }

  static const _gap = SizedBox(height: AppSpacing.md);

  InputDecoration _decoration(String label, {String? helper}) =>
      InputDecoration(
        labelText: label,
        helperText: helper,
        helperMaxLines: 3,
        isDense: true,
        border: const OutlineInputBorder(borderRadius: AppRadius.smAll),
      );

  Widget _field(
    TextEditingController controller,
    String label, {
    String? helper,
    TextInputType? keyboard,
    List<TextInputFormatter>? formatters,
    FormFieldValidator<String>? validator,
  }) => TextFormField(
    controller: controller,
    keyboardType: keyboard,
    inputFormatters: formatters,
    autocorrect: false,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,
    decoration: _decoration(label, helper: helper),
  );
}

/// Tarih satırı: seçili tarih, seç ve temizle.
class _DateRow extends StatelessWidget {
  const _DateRow({
    required this.label,
    required this.value,
    required this.onPick,
    required this.onClear,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onPick;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final v = value;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      subtitle: Text(
        v == null ? l10n.animalFormNotEntered : Fmt.dayMonthYear(v),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (v != null)
            IconButton(
              tooltip: l10n.animalFormClearDate(label),
              onPressed: onClear,
              icon: const Icon(Icons.close),
            ),
          IconButton(
            tooltip: l10n.animalFormPickDate(label),
            onPressed: onPick,
            icon: const Icon(Icons.calendar_today_outlined),
          ),
        ],
      ),
    );
  }
}
