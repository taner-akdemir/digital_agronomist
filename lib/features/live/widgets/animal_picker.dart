import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/widgets/async_view.dart';

/// Seçicinin sonucu: bir hayvan ya da eşleştirmeyi kaldırma.
sealed class AnimalPick {
  const AnimalPick();
}

/// Noktaya bu hayvan bağlansın.
class PickAnimal extends AnimalPick {
  const PickAnimal(this.animalId);
  final String animalId;
}

/// Noktadaki eşleştirme kaldırılsın (backend ADR 0053).
class ClearAnimal extends AnimalPick {
  const ClearAnimal();
}

/// Noktaya hayvan seçtirir (§15.1 nokta–hayvan eşleştirme).
///
/// Vazgeçilirse null döner.
///
/// [unmatched] noktada okunup eşleştirilemeyen küpedir: sağımcı çoğu zaman
/// seçiciyi tam da bu yüzden açıyor ve hangi küpenin neden tanınmadığını
/// başta görmeli.
///
/// [current] noktada şu an bağlı hayvandır; varsa "Eşleştirmeyi kaldır"
/// seçeneği çıkar.
Future<AnimalPick?> showAnimalPicker(
  BuildContext context, {
  required String spoutLabel,
  required Set<String> alreadyAssigned,
  UnmatchedTag? unmatched,
  SpoutAnimal? current,
}) => showModalBottomSheet<AnimalPick>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  backgroundColor: AppColors.surface,
  builder: (_) => _AnimalPicker(
    spoutLabel: spoutLabel,
    alreadyAssigned: alreadyAssigned,
    unmatched: unmatched,
    current: current,
  ),
);

class _AnimalPicker extends ConsumerStatefulWidget {
  const _AnimalPicker({
    required this.spoutLabel,
    required this.alreadyAssigned,
    this.unmatched,
    this.current,
  });

  final String spoutLabel;
  final UnmatchedTag? unmatched;
  final SpoutAnimal? current;

  /// Bu oturumda BAŞKA noktalara eşleştirilmiş hayvanlar.
  final Set<String> alreadyAssigned;

  @override
  ConsumerState<_AnimalPicker> createState() => _AnimalPickerState();
}

class _AnimalPickerState extends ConsumerState<_AnimalPicker> {
  String _query = '';

  /// Kullanıcının seçtiği tür; null = tümü. [_speciesTouched] false iken
  /// varsayılan kullanılır (bkz. [_defaultSpecies]).
  String? _species;
  bool _speciesTouched = false;

  @override
  Widget build(BuildContext context) {
    final animals = ref.watch(animalsProvider);
    final species = ref.watch(speciesListProvider).value ?? const <Species>[];
    final speciesName = {for (final s in species) s.id: s.nameTr};

    return Padding(
      // Klavye açılınca liste ezilmesin.
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.spoutLabel} · hayvan seç',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.current case final a?) ...[
                    const SizedBox(height: AppSpacing.xs),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      leading: const Icon(
                        Icons.link_off,
                        color: AppColors.redColor,
                      ),
                      title: const Text(
                        'Eşleştirmeyi kaldır',
                        style: TextStyle(
                          color: AppColors.redColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        '${a.name ?? a.earTag} yanlış bağlandıysa',
                      ),
                      onTap: () =>
                          Navigator.of(context).pop(const ClearAnimal()),
                    ),
                  ],
                  if (widget.unmatched case final u?) ...[
                    const SizedBox(height: AppSpacing.sm),
                    _UnmatchedNotice(tag: u),
                  ],
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    autofocus: true,
                    // Küpe numarası ARAMANIN ASIL YOLU: sağım sırasında
                    // operatörün elindeki tek kesin bilgi o. Ad isteğe
                    // bağlı bir alan (§4) ve çoğu hayvanda yok.
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Küpe numarası veya ad',
                      prefixIcon: Icon(Icons.search),
                      isDense: true,
                      border: OutlineInputBorder(borderRadius: AppRadius.smAll),
                    ),
                    onChanged: (v) => setState(() => _query = v.trim()),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AsyncView(
                value: animals,
                errorMessage: 'Hayvanlar yüklenemedi',
                builder: (list) {
                  final chosen = _speciesTouched
                      ? _species
                      : _defaultSpecies(list);
                  final milkingSpecies =
                      {
                        for (final a in list)
                          if (a.isMilking) a.speciesId,
                      }.toList()..sort(
                        (x, y) => (speciesName[x] ?? x).compareTo(
                          speciesName[y] ?? y,
                        ),
                      );
                  final matches = _filter(list, chosen);
                  final chips = milkingSpecies.length < 2
                      ? null
                      : _SpeciesChips(
                          ids: milkingSpecies,
                          names: speciesName,
                          selected: chosen,
                          onSelected: (id) => setState(() {
                            _speciesTouched = true;
                            _species = id;
                          }),
                        );
                  if (matches.isEmpty) {
                    return Column(
                      children: [
                        ?chips,
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Eşleşen hayvan yok',
                              style: TextStyle(color: AppColors.onSurfaceMuted),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      ?chips,
                      Expanded(child: _list(context, matches, speciesName)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _list(
    BuildContext context,
    List<Animal> matches,
    Map<String, String> speciesName,
  ) {
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (_, i) {
        final a = matches[i];
        final taken = widget.alreadyAssigned.contains(a.id);
        return ListTile(
          title: Text(a.name ?? a.earTag),
          subtitle: Text(
            [
              a.earTag,
              speciesName[a.speciesId] ?? '',
              if (taken) 'başka noktada',
            ].where((s) => s.isNotEmpty).join(' · '),
          ),
          // Zaten eşleştirilmiş hayvan SEÇİLEMEZ: aynı hayvanı iki noktaya
          // bağlamak, iki ayrı sağım kaydı üretip günlük verimi ikiye
          // bölerdi.
          enabled: !taken,
          onTap: taken
              ? null
              : () => Navigator.of(context).pop(PickAnimal(a.id)),
        );
      },
    );
  }

  /// Varsayılan tür: bu oturumda eşleştirilmiş hayvanların HEPSİ aynı
  /// türdense o tür, değilse tümü.
  ///
  /// Bir bölgede aynı anda tek tür sağılır; ilk hayvan bağlandıktan sonra
  /// seçicinin öteki türleri göstermesi yalnızca listeyi uzatır. Kural
  /// hiçbir şey saklamaz, oturumun kendisinden çıkar.
  String? _defaultSpecies(List<Animal> all) {
    final ids = {
      for (final a in all)
        if (widget.alreadyAssigned.contains(a.id)) a.speciesId,
    };
    return ids.length == 1 ? ids.single : null;
  }

  List<Animal> _filter(List<Animal> all, String? species) {
    final q = _query.toLowerCase();
    final matches = [
      for (final a in all)
        // Yalnızca SAĞMAL hayvan: kurudaki ya da satılmış hayvanı listede
        // görmek operatörü yavaşlatır, seçerse backend zaten reddeder.
        if (a.isMilking &&
            (species == null || a.speciesId == species) &&
            (q.isEmpty ||
                a.earTag.toLowerCase().contains(q) ||
                (a.name?.toLowerCase().contains(q) ?? false)))
          a,
    ];

    // Eşleştirilmişler ALTTA: listenin başı seçilebilir olanlara ayrılıyor.
    matches.sort((a, b) {
      final ta = widget.alreadyAssigned.contains(a.id) ? 1 : 0;
      final tb = widget.alreadyAssigned.contains(b.id) ? 1 : 0;
      return ta != tb ? ta - tb : a.earTag.compareTo(b.earTag);
    });
    return matches;
  }
}

/// Seçicinin başındaki "okunan küpe tanınmadı" kutusu.
class _UnmatchedNotice extends StatelessWidget {
  const _UnmatchedNotice({required this.tag});

  final UnmatchedTag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: const BoxDecoration(
        color: AppColors.lightAmberColor,
        borderRadius: AppRadius.smAll,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.nfc, size: 18, color: AppColors.darkAmberColor),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              // Sebebe göre yönlendirme: kayıtlı olmayan küpenin hayvanı
              // listede küpe numarasıyla aranır; sağmal olmayan hayvan
              // listede YOK, önce durumu değiştirilmeli.
              tag.reason == 'not_milking'
                  ? '${tag.message}: listede yok. Yanlışlıkla girdiyse '
                        'başlığı çıkarın; sağılacaksa önce hayvanın '
                        'durumunu değiştirin.'
                  : '${tag.message}. Hayvanı aşağıdan seçin.',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.darkAmberColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Tür süzgeci. Sürüde tek sağmal tür varsa hiç çizilmez.
class _SpeciesChips extends StatelessWidget {
  const _SpeciesChips({
    required this.ids,
    required this.names,
    required this.selected,
    required this.onSelected,
  });

  final List<String> ids;
  final Map<String, String> names;
  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        children: [
          for (final id in <String?>[null, ...ids])
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: ChoiceChip(
                label: Text(id == null ? 'Tümü' : names[id] ?? id),
                selected: selected == id,
                onSelected: (_) => onSelected(id),
              ),
            ),
        ],
      ),
    );
  }
}
