import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';

/// Hayvan ekleme ve düzenleme (§8.5 POST/PUT /animals, backend ADR 0049).
///
/// Yalnızca işletme sahibi açar (düğmeler başkasına görünmez, backend de 403
/// döner). Düzenleme TAM kayıttır: form bütün alanları gönderir, boş
/// bırakılan alan silinir. Verim sınıfı formda YOK — gece hesabının alanı.
class AnimalFormScreen extends ConsumerWidget {
  const AnimalFormScreen({super.key, this.animalId});

  /// Düzenlenecek hayvan; null ise yeni hayvan.
  final String? animalId;

  bool get _isEdit => animalId != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final species = ref.watch(speciesListProvider);
    final animals = _isEdit
        ? ref.watch(animalsProvider)
        : const AsyncData(<Animal>[]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEdit ? 'Hayvanı düzenle' : 'Yeni hayvan',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: AsyncView(
        value: species,
        errorMessage: 'Türler yüklenemedi',
        builder: (speciesList) => AsyncView(
          value: animals,
          errorMessage: 'Hayvan yüklenemedi',
          builder: (list) {
            final existing = _isEdit
                ? list.where((a) => a.id == animalId).firstOrNull
                : null;
            if (_isEdit && existing == null) {
              return const Center(child: Text('Hayvan bulunamadı'));
            }
            return _Form(species: speciesList, existing: existing);
          },
        ),
      ),
    );
  }
}

/// Durumlar ve Türkçe adları (Animal.statusLabel ile aynı).
const _statuses = ['active', 'dry', 'sold', 'slaughtered', 'dead'];

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.species, this.existing});

  final List<Species> species;
  final Animal? existing;

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
  late String? _speciesId;
  late String _status;
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
        (widget.species.length == 1 ? widget.species.first.id : null);
    _status = a?.status ?? 'active';
    _birth = a?.birthDate;
    _calving = a?.lastCalvingDate;
  }

  @override
  void dispose() {
    for (final c in [_earTag, _name, _breed, _rfid, _lactation]) {
      c.dispose();
    }
    super.dispose();
  }

  String? _nullIfBlank(String s) => s.trim().isEmpty ? null : s.trim();

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
    );
    try {
      final saved = await ref.read(repositoryProvider).saveAnimal(draft);
      ref.invalidate(animalsProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(base == null ? 'Hayvan eklendi' : 'Hayvan güncellendi'),
        ),
      );
      context.go('/history/animal/${saved.id}');
    } catch (e) {
      setState(() => _error = userMessage(e) ?? 'Kaydedilemedi: $e');
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
            'Küpe numarası',
            helper: 'Hayvanı tanımlayan alan; işletmede tekil.',
            validator: (v) =>
                (v ?? '').trim().isEmpty ? 'Küpe numarası zorunlu' : null,
          ),
          _gap,
          DropdownButtonFormField<String>(
            initialValue: _speciesId,
            decoration: _decoration('Tür'),
            items: [
              for (final s in widget.species)
                DropdownMenuItem(value: s.id, child: Text(s.nameTr)),
            ],
            validator: (v) => v == null ? 'Tür seçin' : null,
            onChanged: (v) => setState(() => _speciesId = v),
          ),
          _gap,
          _field(_name, 'Ad (isteğe bağlı)'),
          _gap,
          _field(_breed, 'Irk (isteğe bağlı)'),
          _gap,
          _field(
            _rfid,
            'RFID (isteğe bağlı)',
            helper:
                'Küpedeki çipin numarası; sayaç okursa hayvan noktaya kendiliğinden eşleşir.',
            keyboard: TextInputType.number,
          ),
          _gap,
          _DateRow(
            label: 'Doğum tarihi',
            value: _birth,
            onPick: () => _pickDate(
              current: _birth,
              onPicked: (d) => setState(() => _birth = d),
            ),
            onClear: () => setState(() => _birth = null),
          ),
          _DateRow(
            label: 'Son buzağılama',
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
            'Laktasyon sırası',
            keyboard: TextInputType.number,
            formatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          _gap,
          DropdownButtonFormField<String>(
            initialValue: _status,
            decoration: _decoration(
              'Durum',
              helper:
                  'Yalnızca sağmal hayvan sağıma eşleştirilir ve sınıflandırılır.',
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
          if (_error != null) ...[
            _gap,
            Text(
              _error!,
              style: const TextStyle(color: AppColors.darkRedColor),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          FilledButton(
            onPressed: _busy ? null : _save,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.darkGreenColor,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadius.mdAll,
              ),
            ),
            child: Text(_busy ? 'Kaydediliyor…' : 'Kaydet'),
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
      subtitle: Text(v == null ? 'Girilmedi' : Fmt.dayMonthYear(v)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (v != null)
            IconButton(
              tooltip: '$label temizle',
              onPressed: onClear,
              icon: const Icon(Icons.close),
            ),
          IconButton(
            tooltip: '$label seç',
            onPressed: onPick,
            icon: const Icon(Icons.calendar_today_outlined),
          ),
        ],
      ),
    );
  }
}
