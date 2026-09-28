/// Rolün Türkçe adı (§5 kullanıcı rolleri).
///
/// Tanınmayan rol KODU olduğu gibi gösterilir: backend yeni bir rol
/// eklediğinde kullanıcıya boş bir satır göstermektense ham kod yeğdir.
String roleLabel(String role) => switch (role) {
  'tenant_owner' => 'İşletme sahibi',
  'tenant_operator' => 'Operatör',
  'tenant_viewer' => 'Görüntüleyici',
  'platform_admin' => 'Platform yöneticisi',
  _ => role,
};

/// Rolün ne yaptığı; kullanıcı eklerken seçimin yanında.
String roleHint(String role) => switch (role) {
  'tenant_operator' => 'Sağımı yürütür: oturum açar, hayvan eşleştirir.',
  'tenant_viewer' => 'Veteriner, danışman: görür ve not yazar, değiştiremez.',
  _ => '',
};
