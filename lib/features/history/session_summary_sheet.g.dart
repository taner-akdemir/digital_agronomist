// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_summary_sheet.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Oturum özeti (backend ADR 0094).

@ProviderFor(sessionSummary)
final sessionSummaryProvider = SessionSummaryFamily._();

/// Oturum özeti (backend ADR 0094).

final class SessionSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<SessionSummary>,
          SessionSummary,
          FutureOr<SessionSummary>
        >
    with $FutureModifier<SessionSummary>, $FutureProvider<SessionSummary> {
  /// Oturum özeti (backend ADR 0094).
  SessionSummaryProvider._({
    required SessionSummaryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'sessionSummaryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sessionSummaryHash();

  @override
  String toString() {
    return r'sessionSummaryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SessionSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SessionSummary> create(Ref ref) {
    final argument = this.argument as String;
    return sessionSummary(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionSummaryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sessionSummaryHash() => r'1645010f315d2f27ee2b5b2437a7c137c503bf17';

/// Oturum özeti (backend ADR 0094).

final class SessionSummaryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SessionSummary>, String> {
  SessionSummaryFamily._()
    : super(
        retry: null,
        name: r'sessionSummaryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Oturum özeti (backend ADR 0094).

  SessionSummaryProvider call(String sessionId) =>
      SessionSummaryProvider._(argument: sessionId, from: this);

  @override
  String toString() => r'sessionSummaryProvider';
}
