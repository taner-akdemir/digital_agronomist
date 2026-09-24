import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/widgets/async_view.dart';

/// Noktaya hayvan seçtirir (§15.1 nokta–hayvan eşleştirme).
///
/// Seçilen hayvanın kimliğini döner; vazgeçilirse null.
///
/// [unmatched] noktada okunup eşleştirilemeyen küpedir: sağımcı çoğu zaman
/// seçiciyi tam da bu yüzden açıyor ve hangi küpenin neden tanınmadığını
/// başta görmeli.
Future<String?> showAnimalPicker(
  BuildContext context, {
  required String spoutLabel,
  required Set<String> alreadyAssigned,
  UnmatchedTag? unmatched,
}) => showModalBottomSheet<String>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  backgroundColor: AppColors.surface,
  builder: (_) => _AnimalPicker(
    spoutLabel: spoutLabel,
    alreadyAssigned: alreadyAssigned,
    unmatched: unmatched,
  ),
);

class _AnimalPicker extends ConsumerStatefulWidget {
  const _AnimalPicker({
    required this.spoutLabel,
    required this.alreadyAssigned,
    this.unmatched,
  });

  final String spoutLabel;
  final UnmatchedTag? unmatched;

  /// Bu oturumda BAŞKA noktalara eşleştirilmiş hayvanlar.
  final Set<String> alreadyAssigned;

  @override
  ConsumerState<_AnimalPicker> createState() => _AnimalPickerState();
}

class _AnimalPickerState extends ConsumerState<_AnimalPicker> {
  String _query = '';

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
                  final matches = _filter(list);
                  if (matches.isEmpty) {
                    return const Center(
                      child: Text(
                        'Eşleşen hayvan yok',
                        style: TextStyle(color: AppColors.onSurfaceMuted),
                      ),
                    );
                  }
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
                        // Zaten eşleştirilmiş hayvan SEÇİLEMEZ: aynı hayvanı
                        // iki noktaya bağlamak, iki ayrı sağım kaydı üretip
                        // günlük verimi ikiye bölerdi.
                        enabled: !taken,
                        onTap: taken
                            ? null
                            : () => Navigator.of(context).pop(a.id),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Animal> _filter(List<Animal> all) {
    final q = _query.toLowerCase();
    final matches = [
      for (final a in all)
        // Yalnızca SAĞMAL hayvan: kurudaki ya da satılmış hayvanı listede
        // görmek operatörü yavaşlatır, seçerse backend zaten reddeder.
        if (a.isMilking &&
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
