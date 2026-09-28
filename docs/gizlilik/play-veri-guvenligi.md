# Play Console — "Veri güvenliği" formu cevapları (taslak)

> Kodun 28.09.2026 hâlinden çıkarıldı (AndroidManifest, pubspec, backend şemaları). Uygulama
> değişirse (yeni izin, yeni SDK) bu dosya ve form güncellenmeli.

## Genel

| Soru | Cevap | Dayanak |
|---|---|---|
| Uygulama kullanıcı verisi topluyor ya da paylaşıyor mu? | **Evet** | hesap, bildirim jetonu |
| Aktarımda şifreleniyor mu? | **Evet** (HTTPS/TLS) | sürüm paketi yalnızca https'e derleniyor (`tool/release.sh`), düz http'ye izin yok |
| Kullanıcılar verilerinin silinmesini isteyebilir mi? | **Evet** | başvuru: [DOLDUR: e-posta]; hesabı işletme yöneticisi de kapatır |
| Hesap uygulama içinden oluşturuluyor mu? | **Hayır** | hesapları platform yöneticisi açar — Play'in "uygulama içi hesap silme" şartı uygulama içinde hesap oluşturmaya bağlı; yine de silme talebi bağlantısı verilmeli: [DOLDUR: URL] |

## Toplanan veri türleri

| Play kategorisi | Toplanıyor mu | Paylaşılıyor mu* | Amaç | Zorunlu mu |
|---|---|---|---|---|
| Kişisel bilgiler → Ad | Evet | Hayır | Uygulama işlevi, hesap yönetimi | Zorunlu |
| Kişisel bilgiler → E-posta adresi | Evet | Hayır | Hesap yönetimi, uygulama işlevi | Zorunlu |
| Kişisel bilgiler → Kullanıcı kimlikleri | Evet (hesap kimliği) | Hayır | Hesap yönetimi | Zorunlu |
| Cihaz veya diğer kimlikler | Evet (FCM jetonu) | Hayır | Uygulama işlevi (bildirim) | İsteğe bağlı (bildirim izni) |
| Uygulama etkinliği → Diğer kullanıcı tarafından oluşturulan içerik | Evet (hayvan notları) | Hayır | Uygulama işlevi | İsteğe bağlı |
| Konum, rehber, fotoğraf/video, ses, dosyalar, finans, sağlık, mesajlar, tarama geçmişi | **Hayır** | — | — | — |
| Uygulama bilgileri ve performansı (çökme, teşhis) | **Hayır** | — | Crashlytics/Analytics YOK | — |

\* Play'in tanımında hizmet sağlayıcıya (barındırma, bildirim, e-posta/SMS iletimi)
aktarım "paylaşım" sayılmaz.

## Notlar

- İzinler yalnızca `INTERNET` ve `POST_NOTIFICATIONS`.
- Dosya seçici (hayvan listesi içe aktarma) ve paylaşım (verim raporu) kullanıcının
  seçtiği dosyayla, istek anında; arka planda erişim yok.
- Reklam kimliği kullanılmıyor → "Reklam kimliği" beyanında **Hayır**.
- Hedef kitle: 18+, işletmeler.
