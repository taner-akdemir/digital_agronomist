// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Son 90 günün işlem kaydı (backend ADR 0082).

@ProviderFor(auditLog)
final auditLogProvider = AuditLogProvider._();

/// Son 90 günün işlem kaydı (backend ADR 0082).

final class AuditLogProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AuditEntry>>,
          List<AuditEntry>,
          FutureOr<List<AuditEntry>>
        >
    with $FutureModifier<List<AuditEntry>>, $FutureProvider<List<AuditEntry>> {
  /// Son 90 günün işlem kaydı (backend ADR 0082).
  AuditLogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auditLogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$auditLogHash();

  @$internal
  @override
  $FutureProviderElement<List<AuditEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AuditEntry>> create(Ref ref) {
    return auditLog(ref);
  }
}

String _$auditLogHash() => r'fc2a29bb45281469fc19b2c60c8454c1ed11b389';
