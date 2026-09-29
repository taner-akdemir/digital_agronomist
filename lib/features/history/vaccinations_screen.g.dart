// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccinations_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Aşı ve ilaç takvimi (backend ADR 0112).

@ProviderFor(vaccinePlans)
final vaccinePlansProvider = VaccinePlansProvider._();

/// Aşı ve ilaç takvimi (backend ADR 0112).

final class VaccinePlansProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<VaccinePlan>>,
          List<VaccinePlan>,
          FutureOr<List<VaccinePlan>>
        >
    with
        $FutureModifier<List<VaccinePlan>>,
        $FutureProvider<List<VaccinePlan>> {
  /// Aşı ve ilaç takvimi (backend ADR 0112).
  VaccinePlansProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vaccinePlansProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vaccinePlansHash();

  @$internal
  @override
  $FutureProviderElement<List<VaccinePlan>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<VaccinePlan>> create(Ref ref) {
    return vaccinePlans(ref);
  }
}

String _$vaccinePlansHash() => r'8545805d49af58e95ae45e27899f2ffd421b71f0';

/// Zamanı geçmiş, 30 gün içinde gelecek ya da hiç uygulanmamış olanlar.

@ProviderFor(dueVaccinations)
final dueVaccinationsProvider = DueVaccinationsProvider._();

/// Zamanı geçmiş, 30 gün içinde gelecek ya da hiç uygulanmamış olanlar.

final class DueVaccinationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<VaccinationDue>>,
          List<VaccinationDue>,
          FutureOr<List<VaccinationDue>>
        >
    with
        $FutureModifier<List<VaccinationDue>>,
        $FutureProvider<List<VaccinationDue>> {
  /// Zamanı geçmiş, 30 gün içinde gelecek ya da hiç uygulanmamış olanlar.
  DueVaccinationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dueVaccinationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dueVaccinationsHash();

  @$internal
  @override
  $FutureProviderElement<List<VaccinationDue>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<VaccinationDue>> create(Ref ref) {
    return dueVaccinations(ref);
  }
}

String _$dueVaccinationsHash() => r'bc4e748e86238d16700b10a54039502c7baeb171';

/// Hayvan detayındaki "Aşılar" kartının verisi.

@ProviderFor(animalVaccinations)
final animalVaccinationsProvider = AnimalVaccinationsFamily._();

/// Hayvan detayındaki "Aşılar" kartının verisi.

final class AnimalVaccinationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<AnimalVaccinations>,
          AnimalVaccinations,
          FutureOr<AnimalVaccinations>
        >
    with
        $FutureModifier<AnimalVaccinations>,
        $FutureProvider<AnimalVaccinations> {
  /// Hayvan detayındaki "Aşılar" kartının verisi.
  AnimalVaccinationsProvider._({
    required AnimalVaccinationsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'animalVaccinationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$animalVaccinationsHash();

  @override
  String toString() {
    return r'animalVaccinationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AnimalVaccinations> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AnimalVaccinations> create(Ref ref) {
    final argument = this.argument as String;
    return animalVaccinations(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AnimalVaccinationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$animalVaccinationsHash() =>
    r'4868be1e170807604925574eaaa84a5106445099';

/// Hayvan detayındaki "Aşılar" kartının verisi.

final class AnimalVaccinationsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AnimalVaccinations>, String> {
  AnimalVaccinationsFamily._()
    : super(
        retry: null,
        name: r'animalVaccinationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Hayvan detayındaki "Aşılar" kartının verisi.

  AnimalVaccinationsProvider call(String animalId) =>
      AnimalVaccinationsProvider._(argument: animalId, from: this);

  @override
  String toString() => r'animalVaccinationsProvider';
}
