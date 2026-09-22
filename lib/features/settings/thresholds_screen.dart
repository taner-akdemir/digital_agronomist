import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';

/// Tür bazında eşik ayarları (§15.1 "eşik ayarları (owner)", §6.5).
///
/// Buradaki değerler renk motorunun TÜM girdileridir: debi bantları (§6.2),
/// verim bantları (§6.3), yanlış alarm koruması ve sınıflandırma eşikleri
/// (§6.4). Şimdiye kadar sabit gelip hiçbir yerden değiştirilemiyorlardı.
class ThresholdsScreen extends ConsumerWidget {
  const ThresholdsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final species = ref.watch(speciesListProvider);
    final thresholds = ref.watch(thresholdsListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Geri',
          onPressed: () => context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Eşik ayarları',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkGreenColor),
        ),
      ),
      body: AsyncView(
        value: species,
        errorMessage: 'Türler yüklenemedi',
        builder: (speciesList) => AsyncView(
          value: thresholds,
          errorMessage: 'Eşikler yüklenemedi',
          builder: (list) => _Tabs(species: speciesList, thresholds: list),
        ),
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs({required this.species, required this.thresholds});

  final List<Species> species;
  final List<Thresholds> thresholds;

  @override
  Widget build(BuildContext context) {
    // Eşikler TÜR BAZINDADIR (§4) ve keçi ile ineğinki on kat farklı; tek
    // bir form gösterip "tür seç" demek, yanlış türü düzenlemeyi kolay
    // yapardı.
    final withThresholds = [
      for (final s in species)
        if (thresholds.where((t) => t.speciesId == s.id).firstOrNull
            case final t?)
          (species: s, thresholds: t),
    ];

    if (withThresholds.isEmpty) {
      return const Center(child: Text('Tanımlı tür eşiği yok'));
    }

    return DefaultTabController(
      length: withThresholds.length,
      child: Column(
        children: [
          TabBar(
            labelColor: AppColors.darkGreenColor,
            unselectedLabelColor: AppColors.onSurfaceMuted,
            indicatorColor: AppColors.darkGreenColor,
            tabs: [for (final e in withThresholds) Tab(text: e.species.nameTr)],
          ),
          Expanded(
            child: TabBarView(
              children: [
                for (final e in withThresholds)
                  _Form(species: e.species, initial: e.thresholds),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.species, required this.initial});

  final Species species;
  final Thresholds initial;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, TextEditingController> _fields;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    // dryOff/highYield LİTRE olarak düzenlenir: kullanıcı günlük verimi
    // "8000 mL" diye düşünmüyor. Taşıma birimi yine mL (§3).
    final t = widget.initial;
    _fields = {
      'flowLow': TextEditingController(text: _num(t.flowLow)),
      'flowHigh': TextEditingController(text: _num(t.flowHigh)),
      'yieldGreen': TextEditingController(text: _num(t.yieldGreenPct)),
      'yieldRed': TextEditingController(text: _num(t.yieldRedPct)),
      'rampUp': TextEditingController(text: '${t.rampUpSec}'),
      'alertHold': TextEditingController(text: '${t.alertHoldSec}'),
      'endFlow': TextEditingController(text: _num(t.endFlowThreshold)),
      'endGrace': TextEditingController(text: '${t.endGraceSec}'),
      'dryOff': TextEditingController(text: _num(t.dryOffDailyMl / 1000)),
      'highYield': TextEditingController(text: _num(t.highYieldDailyMl / 1000)),
    };
  }

  @override
  void dispose() {
    for (final c in _fields.values) {
      c.dispose();
    }
    super.dispose();
  }

  static String _num(num v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : '$v';

  double? _value(String key) =>
      double.tryParse(_fields[key]!.text.trim().replaceAll(',', '.'));

  /// Yalnızca owner kaydedebilir (§15.1).
  ///
  /// Diğer roller ekranı GÖREBİLİR: sağım sırasında "bu kırmızı neden
  /// kırmızı?" sorusunun cevabı burada ve onu gizlemek kimseye yaramaz.
  bool get _canEdit => ref.watch(authProvider).user?.role == 'tenant_owner';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          const _CalibrationNote(),
          const SizedBox(height: AppSpacing.md),
          if (!_canEdit) ...[
            const _ReadOnlyNote(),
            const SizedBox(height: AppSpacing.md),
          ],
          _Group(
            title: 'Anlık debi bantları',
            hint: 'Altında kırmızı, üstünde yeşil; arası sarı (§6.2).',
            children: [
              _field('flowLow', 'Alt eşik', 'L/dk'),
              _field('flowHigh', 'Üst eşik', 'L/dk'),
            ],
          ),
          _Group(
            title: 'Oturum verimi bantları',
            hint: 'Alınan sütün beklenene oranı (§6.3).',
            children: [
              _field('yieldGreen', 'Yeşil eşiği', '%'),
              _field('yieldRed', 'Kırmızı eşiği', '%'),
            ],
          ),
          _Group(
            title: 'Yanlış alarm koruması',
            hint: 'Sağımın ilk saniyelerinde kırmızı üretilmez; kırmızı '
                'durum bu süre boyunca sürmeden uyarı gönderilmez (§6.2).',
            children: [
              _field('rampUp', 'Isınma süresi', 'sn'),
              _field('alertHold', 'Uyarı bekleme', 'sn'),
            ],
          ),
          _Group(
            title: 'Sağım kapanışı',
            hint: 'Debi bu değerin altında bu süre kalırsa hayvanın sağımı '
                'kapanır (§6.1).',
            children: [
              _field('endFlow', 'Bitiş debisi', 'L/dk'),
              _field('endGrace', 'Bekleme', 'sn'),
            ],
          ),
          _Group(
            title: 'Sınıflandırma eşikleri',
            hint: '7 günlük ortalama alt eşiğin altındaysa kuruya aday, üst '
                'eşiğin üstündeyse yüksek verimli (§6.4).',
            children: [
              _field('dryOff', 'Kuruya çıkma alt eşiği', 'L/gün'),
              _field('highYield', 'Yüksek verim üst eşiği', 'L/gün'),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: _canEdit && !_saving ? _save : null,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.darkGreenColor,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
            ),
            child: Text(_saving ? 'Kaydediliyor…' : 'Kaydet'),
          ),
        ],
      ),
    );
  }

  Widget _field(String key, String label, String unit) => _NumberField(
        controller: _fields[key]!,
        label: label,
        unit: unit,
        enabled: _canEdit,
        validator: (raw) => _validate(key, raw),
      );

  /// Alan doğrulaması.
  ///
  /// ÇİFTLERİN SIRASI da kontrol edilir: alt eşik üst eşiği geçerse renk
  /// motoru hiçbir zaman sarı üretmez ve bant sessizce kaybolurdu.
  String? _validate(String key, String? raw) {
    final v = double.tryParse((raw ?? '').trim().replaceAll(',', '.'));
    if (v == null) return 'Sayı girin';
    if (v < 0) return 'Negatif olamaz';
    if (v == 0 && key != 'endFlow') return 'Sıfır olamaz';

    return switch (key) {
      'flowLow' when v >= (_value('flowHigh') ?? double.infinity) =>
        'Üst eşikten küçük olmalı',
      'flowHigh' when v <= (_value('flowLow') ?? 0) =>
        'Alt eşikten büyük olmalı',
      'yieldRed' when v >= (_value('yieldGreen') ?? double.infinity) =>
        'Yeşil eşiğinden küçük olmalı',
      'yieldGreen' when v <= (_value('yieldRed') ?? 0) =>
        'Kırmızı eşiğinden büyük olmalı',
      'yieldGreen' || 'yieldRed' when v > 100 => 'En çok 100 olabilir',
      'dryOff' when v >= (_value('highYield') ?? double.infinity) =>
        'Yüksek verim eşiğinden küçük olmalı',
      'highYield' when v <= (_value('dryOff') ?? 0) =>
        'Kuruya çıkma eşiğinden büyük olmalı',
      _ => null,
    };
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _saving = true);
    final next = widget.initial.copyWith(
      flowLow: _value('flowLow')!,
      flowHigh: _value('flowHigh')!,
      yieldGreenPct: _value('yieldGreen')!,
      yieldRedPct: _value('yieldRed')!,
      rampUpSec: _value('rampUp')!.round(),
      alertHoldSec: _value('alertHold')!.round(),
      endFlowThreshold: _value('endFlow')!,
      endGraceSec: _value('endGrace')!.round(),
      // Litre girilir, mL taşınır (§3).
      dryOffDailyMl: (_value('dryOff')! * 1000).round(),
      highYieldDailyMl: (_value('highYield')! * 1000).round(),
    );

    try {
      await ref.read(repositoryProvider).updateThresholds(next);
      // Eşikler canlı ekranın renk aynasını da besliyor; liste
      // tazelenmezse ekran eski bantlarla çizmeye devam ederdi.
      ref.invalidate(thresholdsListProvider);
      if (mounted) _toast('${widget.species.nameTr} eşikleri kaydedildi');
    } catch (e) {
      if (mounted) _toast('Kaydedilemedi: $e', error: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _toast(String message, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor:
          error ? AppColors.flowRed : AppColors.darkGreenColor,
    ));
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.controller,
    required this.label,
    required this.unit,
    required this.enabled,
    required this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String unit;
  final bool enabled;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        // Ondalık klavye: saha telefonunda tam sayı klavyesiyle "1.5"
        // yazılamıyordu.
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          suffixText: unit,
          isDense: true,
          border: const OutlineInputBorder(borderRadius: AppRadius.smAll),
        ),
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({
    required this.title,
    required this.hint,
    required this.children,
  });

  final String title;
  final String hint;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: AppSpacing.xs),
          // Her grubun NE İŞE YARADIĞI yazıyor: "rampUpSec" gibi bir alan
          // adı, onu ilk kez gören çiftçiye hiçbir şey anlatmıyor.
          Text(hint,
              style: const TextStyle(
                  fontSize: 11, color: AppColors.onSurfaceMuted, height: 1.35)),
          const SizedBox(height: AppSpacing.sm),
          ...children,
        ],
      ),
    );
  }
}

/// §6.5'in kalibrasyon uyarısı.
///
/// Dokümanda AÇIKÇA isteniyor: "Bunlar tahmini başlangıç değerleridir…
/// Arayüzde kullanıcıya bu not gösterilmelidir."
class _CalibrationNote extends StatelessWidget {
  const _CalibrationNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.flowYellowSurface,
        borderRadius: AppRadius.smAll,
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 16, color: AppColors.darkAmberColor),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Varsayılanlar tahmini başlangıç değerleridir. Irk, laktasyon '
              'dönemi ve işletmeye göre çok değişir; saha verisi ve ziraat '
              'mühendisi/veteriner görüşüyle kalibre edilmelidir.',
              style: TextStyle(
                  fontSize: 12, color: AppColors.darkAmberColor, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadOnlyNote extends StatelessWidget {
  const _ReadOnlyNote();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.lock_outline, size: 14, color: AppColors.lightGreyColor),
        SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            'Eşikleri yalnızca işletme sahibi değiştirebilir.',
            style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
          ),
        ),
      ],
    );
  }
}
