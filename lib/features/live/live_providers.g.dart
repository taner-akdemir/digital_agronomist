// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Seçili sağım bölgesi.
///
/// Eski kodda bu seçim `_SpoutListScreenState` içinde bir alandı, seçili
/// SAYFA ise Riverpod'daydı ve ikisi birbirini göremiyordu (§15.3/19).
/// Artık tek doğruluk kaynağı burası.

@ProviderFor(SelectedHall)
final selectedHallProvider = SelectedHallProvider._();

/// Seçili sağım bölgesi.
///
/// Eski kodda bu seçim `_SpoutListScreenState` içinde bir alandı, seçili
/// SAYFA ise Riverpod'daydı ve ikisi birbirini göremiyordu (§15.3/19).
/// Artık tek doğruluk kaynağı burası.
final class SelectedHallProvider
    extends $NotifierProvider<SelectedHall, String?> {
  /// Seçili sağım bölgesi.
  ///
  /// Eski kodda bu seçim `_SpoutListScreenState` içinde bir alandı, seçili
  /// SAYFA ise Riverpod'daydı ve ikisi birbirini göremiyordu (§15.3/19).
  /// Artık tek doğruluk kaynağı burası.
  SelectedHallProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedHallProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedHallHash();

  @$internal
  @override
  SelectedHall create() => SelectedHall();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedHallHash() => r'4726e5308640a81c9a8f8082dc47e36d2cc75a66';

/// Seçili sağım bölgesi.
///
/// Eski kodda bu seçim `_SpoutListScreenState` içinde bir alandı, seçili
/// SAYFA ise Riverpod'daydı ve ikisi birbirini göremiyordu (§15.3/19).
/// Artık tek doğruluk kaynağı burası.

abstract class _$SelectedHall extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Seçili bölge yoksa ilk bölgeye düşer.

@ProviderFor(effectiveHall)
final effectiveHallProvider = EffectiveHallProvider._();

/// Seçili bölge yoksa ilk bölgeye düşer.

final class EffectiveHallProvider
    extends $FunctionalProvider<AsyncValue<Hall?>, Hall?, FutureOr<Hall?>>
    with $FutureModifier<Hall?>, $FutureProvider<Hall?> {
  /// Seçili bölge yoksa ilk bölgeye düşer.
  EffectiveHallProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'effectiveHallProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$effectiveHallHash();

  @$internal
  @override
  $FutureProviderElement<Hall?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Hall?> create(Ref ref) {
    return effectiveHall(ref);
  }
}

String _$effectiveHallHash() => r'c387f07e764d4fb18a97f8cdff218d6561ffcd5c';

@ProviderFor(vacuumsByHall)
final vacuumsByHallProvider = VacuumsByHallFamily._();

final class VacuumsByHallProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Vacuum>>,
          List<Vacuum>,
          FutureOr<List<Vacuum>>
        >
    with $FutureModifier<List<Vacuum>>, $FutureProvider<List<Vacuum>> {
  VacuumsByHallProvider._({
    required VacuumsByHallFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vacuumsByHallProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vacuumsByHallHash();

  @override
  String toString() {
    return r'vacuumsByHallProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Vacuum>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Vacuum>> create(Ref ref) {
    final argument = this.argument as String;
    return vacuumsByHall(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VacuumsByHallProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vacuumsByHallHash() => r'b4d647a44353ddbcb5c6fe08f3c581df4b8eb7c8';

final class VacuumsByHallFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Vacuum>>, String> {
  VacuumsByHallFamily._()
    : super(
        retry: null,
        name: r'vacuumsByHallProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VacuumsByHallProvider call(String hallId) =>
      VacuumsByHallProvider._(argument: hallId, from: this);

  @override
  String toString() => r'vacuumsByHallProvider';
}

/// Bölgedeki tüm noktalar.
///
/// Eski ekran "pasif nokta sayısı"nı iki ayrı Future'ın bitiş sırasına
/// bakarak hesaplıyordu ve sonuç yarış koşuluna bağlıydı; tesadüfen doğru
/// çalışıyordu çünkü biri 1 sn, diğeri 2 sn bekliyordu (§15.3/9).
/// Burada iki çağrı birlikte beklenir.

@ProviderFor(spoutsByHall)
final spoutsByHallProvider = SpoutsByHallFamily._();

/// Bölgedeki tüm noktalar.
///
/// Eski ekran "pasif nokta sayısı"nı iki ayrı Future'ın bitiş sırasına
/// bakarak hesaplıyordu ve sonuç yarış koşuluna bağlıydı; tesadüfen doğru
/// çalışıyordu çünkü biri 1 sn, diğeri 2 sn bekliyordu (§15.3/9).
/// Burada iki çağrı birlikte beklenir.

final class SpoutsByHallProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Spout>>,
          List<Spout>,
          FutureOr<List<Spout>>
        >
    with $FutureModifier<List<Spout>>, $FutureProvider<List<Spout>> {
  /// Bölgedeki tüm noktalar.
  ///
  /// Eski ekran "pasif nokta sayısı"nı iki ayrı Future'ın bitiş sırasına
  /// bakarak hesaplıyordu ve sonuç yarış koşuluna bağlıydı; tesadüfen doğru
  /// çalışıyordu çünkü biri 1 sn, diğeri 2 sn bekliyordu (§15.3/9).
  /// Burada iki çağrı birlikte beklenir.
  SpoutsByHallProvider._({
    required SpoutsByHallFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'spoutsByHallProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spoutsByHallHash();

  @override
  String toString() {
    return r'spoutsByHallProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Spout>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Spout>> create(Ref ref) {
    final argument = this.argument as String;
    return spoutsByHall(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SpoutsByHallProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spoutsByHallHash() => r'1e1aa982026be126fbb89fb29c772b4dc3114733';

/// Bölgedeki tüm noktalar.
///
/// Eski ekran "pasif nokta sayısı"nı iki ayrı Future'ın bitiş sırasına
/// bakarak hesaplıyordu ve sonuç yarış koşuluna bağlıydı; tesadüfen doğru
/// çalışıyordu çünkü biri 1 sn, diğeri 2 sn bekliyordu (§15.3/9).
/// Burada iki çağrı birlikte beklenir.

final class SpoutsByHallFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Spout>>, String> {
  SpoutsByHallFamily._()
    : super(
        retry: null,
        name: r'spoutsByHallProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Bölgedeki tüm noktalar.
  ///
  /// Eski ekran "pasif nokta sayısı"nı iki ayrı Future'ın bitiş sırasına
  /// bakarak hesaplıyordu ve sonuç yarış koşuluna bağlıydı; tesadüfen doğru
  /// çalışıyordu çünkü biri 1 sn, diğeri 2 sn bekliyordu (§15.3/9).
  /// Burada iki çağrı birlikte beklenir.

  SpoutsByHallProvider call(String hallId) =>
      SpoutsByHallProvider._(argument: hallId, from: this);

  @override
  String toString() => r'spoutsByHallProvider';
}

/// Bölgenin canlı sağım durumu.
///
/// İlk yükleme `GET /sessions/{id}/live`, sonrası WebSocket akışı (§8.5).
/// Gelen her güncelleme nokta kimliğine göre yerine yazılır.

@ProviderFor(LiveBoard)
final liveBoardProvider = LiveBoardFamily._();

/// Bölgenin canlı sağım durumu.
///
/// İlk yükleme `GET /sessions/{id}/live`, sonrası WebSocket akışı (§8.5).
/// Gelen her güncelleme nokta kimliğine göre yerine yazılır.
final class LiveBoardProvider
    extends $AsyncNotifierProvider<LiveBoard, LiveSession> {
  /// Bölgenin canlı sağım durumu.
  ///
  /// İlk yükleme `GET /sessions/{id}/live`, sonrası WebSocket akışı (§8.5).
  /// Gelen her güncelleme nokta kimliğine göre yerine yazılır.
  LiveBoardProvider._({
    required LiveBoardFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'liveBoardProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$liveBoardHash();

  @override
  String toString() {
    return r'liveBoardProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LiveBoard create() => LiveBoard();

  @override
  bool operator ==(Object other) {
    return other is LiveBoardProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$liveBoardHash() => r'c1c8711064dcf7fbb9f562be84eac12b0d01f158';

/// Bölgenin canlı sağım durumu.
///
/// İlk yükleme `GET /sessions/{id}/live`, sonrası WebSocket akışı (§8.5).
/// Gelen her güncelleme nokta kimliğine göre yerine yazılır.

final class LiveBoardFamily extends $Family
    with
        $ClassFamilyOverride<
          LiveBoard,
          AsyncValue<LiveSession>,
          LiveSession,
          FutureOr<LiveSession>,
          String
        > {
  LiveBoardFamily._()
    : super(
        retry: null,
        name: r'liveBoardProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Bölgenin canlı sağım durumu.
  ///
  /// İlk yükleme `GET /sessions/{id}/live`, sonrası WebSocket akışı (§8.5).
  /// Gelen her güncelleme nokta kimliğine göre yerine yazılır.

  LiveBoardProvider call(String hallId) =>
      LiveBoardProvider._(argument: hallId, from: this);

  @override
  String toString() => r'liveBoardProvider';
}

/// Bölgenin canlı sağım durumu.
///
/// İlk yükleme `GET /sessions/{id}/live`, sonrası WebSocket akışı (§8.5).
/// Gelen her güncelleme nokta kimliğine göre yerine yazılır.

abstract class _$LiveBoard extends $AsyncNotifier<LiveSession> {
  late final _$args = ref.$arg as String;
  String get hallId => _$args;

  FutureOr<LiveSession> build(String hallId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LiveSession>, LiveSession>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LiveSession>, LiveSession>,
              AsyncValue<LiveSession>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// Sağım kontrolü: başlat, eşleştir, bitir (§15.1).
///
/// Komutlar CANLI TAHTAYI DEĞİL provider'ı tazeler: tahta WebSocket'ten
/// besleniyor ve komuttan sonra gelen ilk kare zaten doğru durumu taşıyor.
/// Yine de oturumun KENDİSİ değiştiği için (yeni kimlik, kapanma) akışın
/// baştan kurulması gerekiyor.

@ProviderFor(MilkingControl)
final milkingControlProvider = MilkingControlProvider._();

/// Sağım kontrolü: başlat, eşleştir, bitir (§15.1).
///
/// Komutlar CANLI TAHTAYI DEĞİL provider'ı tazeler: tahta WebSocket'ten
/// besleniyor ve komuttan sonra gelen ilk kare zaten doğru durumu taşıyor.
/// Yine de oturumun KENDİSİ değiştiği için (yeni kimlik, kapanma) akışın
/// baştan kurulması gerekiyor.
final class MilkingControlProvider
    extends $NotifierProvider<MilkingControl, bool> {
  /// Sağım kontrolü: başlat, eşleştir, bitir (§15.1).
  ///
  /// Komutlar CANLI TAHTAYI DEĞİL provider'ı tazeler: tahta WebSocket'ten
  /// besleniyor ve komuttan sonra gelen ilk kare zaten doğru durumu taşıyor.
  /// Yine de oturumun KENDİSİ değiştiği için (yeni kimlik, kapanma) akışın
  /// baştan kurulması gerekiyor.
  MilkingControlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'milkingControlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$milkingControlHash();

  @$internal
  @override
  MilkingControl create() => MilkingControl();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$milkingControlHash() => r'b81a3ed7852617f0733bacf52b28c695fb118d6b';

/// Sağım kontrolü: başlat, eşleştir, bitir (§15.1).
///
/// Komutlar CANLI TAHTAYI DEĞİL provider'ı tazeler: tahta WebSocket'ten
/// besleniyor ve komuttan sonra gelen ilk kare zaten doğru durumu taşıyor.
/// Yine de oturumun KENDİSİ değiştiği için (yeni kimlik, kapanma) akışın
/// baştan kurulması gerekiyor.

abstract class _$MilkingControl extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
