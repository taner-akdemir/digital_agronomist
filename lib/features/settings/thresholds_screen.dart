import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/l10n/l10n.dart';
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
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.thresholdsTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: AsyncView(
        value: species,
        errorMessage: l10n.thresholdsSpeciesLoadFailed,
        builder: (speciesList) => AsyncView(
          value: thresholds,
          errorMessage: l10n.thresholdsLoadFailed,
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
      return Center(child: Text(l10n.thresholdsNoSpecies));
    }

    return DefaultTabController(
      length: withThresholds.length,
      child: Column(
        children: [
          TabBar(
            labelColor: AppColors.darkGreenColor,
            unselectedLabelColor: AppColors.onSurfaceMuted,
            indicatorColor: AppColors.darkGreenColor,
            tabs: [
              for (final e in withThresholds) Tab(text: e.species.displayName),
            ],
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
      'expected': TextEditingController(
        text: _num(t.expectedPerMilkingMl / 1000),
      ),
      'decline': TextEditingController(text: '${t.declinePct}'),
      'noMilk': TextEditingController(text: '${t.noMilkMl}'),
      'noMilkCount': TextEditingController(text: '${t.noMilkMilkings}'),
      'fresh': TextEditingController(text: '${t.freshLactationDays}'),
      'density': TextEditingController(text: _num(t.milkDensity)),
      'conductivity': TextEditingController(text: '${t.conductivityRisePct}'),
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
            title: l10n.thresholdsFlowGroupTitle,
            hint: l10n.thresholdsFlowGroupHint,
            children: [
              _field(
                'flowLow',
                l10n.thresholdsLowerLimit,
                l10n.thresholdsUnitFlow,
              ),
              _field(
                'flowHigh',
                l10n.thresholdsUpperLimit,
                l10n.thresholdsUnitFlow,
              ),
            ],
          ),
          _Group(
            title: l10n.thresholdsYieldGroupTitle,
            hint: l10n.thresholdsYieldGroupHint,
            children: [
              _field('yieldGreen', l10n.thresholdsGreenLimit, '%'),
              _field('yieldRed', l10n.thresholdsRedLimit, '%'),
              _field('expected', l10n.thresholdsExpectedPerMilking, 'L'),
            ],
          ),
          _Group(
            title: l10n.thresholdsFalseAlarmGroupTitle,
            hint: l10n.thresholdsFalseAlarmGroupHint,
            children: [
              _field('rampUp', l10n.thresholdsRampUp, l10n.thresholdsUnitSec),
              _field(
                'alertHold',
                l10n.thresholdsAlertHold,
                l10n.thresholdsUnitSec,
              ),
            ],
          ),
          _Group(
            title: l10n.thresholdsEndGroupTitle,
            hint: l10n.thresholdsEndGroupHint,
            children: [
              _field(
                'endFlow',
                l10n.thresholdsEndFlow,
                l10n.thresholdsUnitFlow,
              ),
              _field(
                'endGrace',
                l10n.thresholdsEndGrace,
                l10n.thresholdsUnitSec,
              ),
            ],
          ),
          _Group(
            title: l10n.thresholdsClassGroupTitle,
            hint: l10n.thresholdsClassGroupHint,
            children: [
              _field(
                'dryOff',
                l10n.thresholdsDryOff,
                l10n.thresholdsUnitPerDay,
              ),
              _field(
                'highYield',
                l10n.thresholdsHighYield,
                l10n.thresholdsUnitPerDay,
              ),
            ],
          ),
          _Group(
            title: l10n.thresholdsRulesGroupTitle,
            hint: l10n.thresholdsRulesGroupHint,
            children: [
              _field('decline', l10n.thresholdsDecline, '%'),
              _field('noMilk', l10n.thresholdsNoMilk, 'mL'),
              _field(
                'noMilkCount',
                l10n.thresholdsNoMilkCount,
                l10n.thresholdsUnitMilkings,
              ),
              _field('fresh', l10n.thresholdsFresh, l10n.thresholdsUnitDays),
            ],
          ),
          _Group(
            title: l10n.thresholdsMastitisGroupTitle,
            hint: l10n.thresholdsMastitisGroupHint,
            children: [
              _field('conductivity', l10n.thresholdsConductivity, '%'),
            ],
          ),
          _Group(
            title: l10n.thresholdsDensityGroupTitle,
            hint: l10n.thresholdsDensityGroupHint,
            children: [_field('density', l10n.thresholdsDensity, 'kg/L')],
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: _canEdit && !_saving ? _save : null,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.darkGreenColor,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadius.mdAll,
              ),
            ),
            child: Text(_saving ? l10n.thresholdsSaving : l10n.commonSave),
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
    if (v == null) return l10n.thresholdsErrorNumber;
    if (v < 0) return l10n.thresholdsErrorNegative;
    if (v == 0 && key != 'endFlow') return l10n.thresholdsErrorZero;

    return switch (key) {
      'flowLow' when v >= (_value('flowHigh') ?? double.infinity) =>
        l10n.thresholdsErrorBelowUpper,
      'flowHigh' when v <= (_value('flowLow') ?? 0) =>
        l10n.thresholdsErrorAboveLower,
      'yieldRed' when v >= (_value('yieldGreen') ?? double.infinity) =>
        l10n.thresholdsErrorBelowGreen,
      'yieldGreen' when v <= (_value('yieldRed') ?? 0) =>
        l10n.thresholdsErrorAboveRed,
      'yieldGreen' || 'yieldRed' when v > 100 => l10n.thresholdsErrorMax(100),
      'dryOff' when v >= (_value('highYield') ?? double.infinity) =>
        l10n.thresholdsErrorBelowHighYield,
      'highYield' when v <= (_value('dryOff') ?? 0) =>
        l10n.thresholdsErrorAboveDryOff,
      'decline' when v > 90 => l10n.thresholdsErrorMax(90),
      'noMilkCount' when v > 20 => l10n.thresholdsErrorMax(20),
      'fresh' when v > 150 => l10n.thresholdsErrorMax(150),
      'density' when v < 0.9 || v > 1.2 => l10n.thresholdsErrorDensityRange,
      'conductivity' when v < 5 || v > 100 =>
        l10n.thresholdsErrorConductivityRange,
      'decline' ||
      'conductivity' ||
      'noMilk' ||
      'noMilkCount' when v != v.roundToDouble() => l10n.thresholdsErrorInteger,
      // Beklenen sağım hacmine eşit bir "boş sağım" sınırı normal sağılan
      // her hayvanı "süt vermiyor" yapardı.
      'noMilk' when v >= (_value('expected') ?? double.infinity) * 1000 =>
        l10n.thresholdsErrorBelowExpected,
      'expected' when v * 1000 <= (_value('noMilk') ?? 0) =>
        l10n.thresholdsErrorAboveNoMilk,
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
      expectedPerMilkingMl: (_value('expected')! * 1000).round(),
      declinePct: _value('decline')!.round(),
      noMilkMl: _value('noMilk')!.round(),
      noMilkMilkings: _value('noMilkCount')!.round(),
      freshLactationDays: _value('fresh')!.round(),
      milkDensity: _value('density')!,
      conductivityRisePct: _value('conductivity')!.round(),
    );

    try {
      await ref.read(repositoryProvider).updateThresholds(next);
      // Eşikler canlı ekranın renk aynasını da besliyor; liste
      // tazelenmezse ekran eski bantlarla çizmeye devam ederdi.
      ref.invalidate(thresholdsListProvider);
      if (mounted) _toast(l10n.thresholdsSaved(widget.species.displayName));
    } catch (e) {
      if (mounted) {
        _toast(userMessage(e) ?? l10n.commonSaveFailed('$e'), error: true);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _toast(String message, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? AppColors.flowRed : AppColors.darkGreenColor,
      ),
    );
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
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
        ],
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
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: AppSpacing.xs),
          // Her grubun NE İŞE YARADIĞI yazıyor: "rampUpSec" gibi bir alan
          // adı, onu ilk kez gören çiftçiye hiçbir şey anlatmıyor.
          Text(
            hint,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.onSurfaceMuted,
              height: 1.35,
            ),
          ),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            size: 16,
            color: AppColors.darkAmberColor,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              l10n.thresholdsCalibrationNote,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.darkAmberColor,
                height: 1.35,
              ),
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
    return Row(
      children: [
        const Icon(
          Icons.lock_outline,
          size: 14,
          color: AppColors.lightGreyColor,
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            l10n.thresholdsReadOnly,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.onSurfaceMuted,
            ),
          ),
        ),
      ],
    );
  }
}
