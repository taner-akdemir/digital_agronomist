import 'package:milktrace/l10n/l10n.dart';

/// Rolün Türkçe adı (§5 kullanıcı rolleri).
///
/// Tanınmayan rol KODU olduğu gibi gösterilir: backend yeni bir rol
/// eklediğinde kullanıcıya boş bir satır göstermektense ham kod yeğdir.
String roleLabel(String role) => switch (role) {
  'tenant_owner' => l10n.roleOwner,
  'tenant_operator' => l10n.roleOperator,
  'tenant_viewer' => l10n.roleViewer,
  'platform_admin' => l10n.rolePlatformAdmin,
  _ => role,
};

/// Rolün ne yaptığı; kullanıcı eklerken seçimin yanında.
String roleHint(String role) => switch (role) {
  'tenant_operator' => l10n.roleOperatorHint,
  'tenant_viewer' => l10n.roleViewerHint,
  _ => '',
};
