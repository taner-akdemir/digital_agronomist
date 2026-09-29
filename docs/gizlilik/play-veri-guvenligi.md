# Play Console — "Veri güvenliği" formu cevapları (taslak)

> Kodun 28.09.2026 hâlinden çıkarıldı; 29.09.2026'da Crashlytics ve uygulama içi hesap
> silme (backend ADR 0098, 0100) eklendi (AndroidManifest, pubspec, backend şemaları). Uygulama
> değişirse (yeni izin, yeni SDK) bu dosya ve form güncellenmeli.

## Genel

| Soru | Cevap | Dayanak |
|---|---|---|
| Uygulama kullanıcı verisi topluyor ya da paylaşıyor mu? | **Evet** | hesap, bildirim jetonu |
| Aktarımda şifreleniyor mu? | **Evet** (HTTPS/TLS) | sürüm paketi yalnızca https'e derleniyor (`tool/release.sh`), düz http'ye izin yok |
| Kullanıcılar verilerinin silinmesini isteyebilir mi? | **Evet** | uygulama içi: hesap kartı → "Hesabımı sil" (parola onayı, backend ADR 0098); web: `https://[DOLDUR: alan-adı]/admin/hesap-sil` |
| Hesap uygulama içinden oluşturuluyor mu? | **Hayır** | hesapları işletme sahibi ya da platform açar; yine de uygulama içi silme ve web bağlantısı var |
| Hesap silme bağlantısı (Play "Veri silme" bölümü) | `https://[DOLDUR: alan-adı]/admin/hesap-sil` | panelin herkese açık sayfası |

## Toplanan veri türleri

| Play kategorisi | Toplanıyor mu | Paylaşılıyor mu* | Amaç | Zorunlu mu |
|---|---|---|---|---|
| Kişisel bilgiler → Ad | Evet | Hayır | Uygulama işlevi, hesap yönetimi | Zorunlu |
| Kişisel bilgiler → E-posta adresi | Evet | Hayır | Hesap yönetimi, uygulama işlevi | Zorunlu |
| Kişisel bilgiler → Kullanıcı kimlikleri | Evet (hesap kimliği) | Hayır | Hesap yönetimi | Zorunlu |
| Cihaz veya diğer kimlikler | Evet (FCM jetonu) | Hayır | Uygulama işlevi (bildirim) | İsteğe bağlı (bildirim izni) |
| Uygulama etkinliği → Diğer kullanıcı tarafından oluşturulan içerik | Evet (hayvan notları) | Hayır | Uygulama işlevi | İsteğe bağlı |
| Konum, rehber, fotoğraf/video, ses, dosyalar, finans, sağlık, mesajlar, tarama geçmişi | **Hayır** | — | — | — |
| Uygulama bilgileri ve performansı → Kilitlenme günlükleri | **Evet** | Hayır | Analiz (hataların giderilmesi) | Zorunlu (sürüm derlemesinde otomatik) |
| Uygulama bilgileri ve performansı → Diğer uygulama performansı verileri (tanılama) | **Evet** | Hayır | Analiz | Zorunlu |
| Analytics / reklam | **Hayır** | — | Firebase Analytics YOK | — |

\* Play'in tanımında hizmet sağlayıcıya (barındırma, bildirim, e-posta/SMS iletimi)
aktarım "paylaşım" sayılmaz.

## Notlar

- İzinler yalnızca `INTERNET` ve `POST_NOTIFICATIONS`. Sağımhane tabletinde ekranı
  açık tutan `wakelock_plus` izin eklemiyor ve veri toplamıyor; canlı ekrandaki
  titreşim sistemin dokunsal geri bildirimi (`VIBRATE` izni yok).
- Dosya seçici (hayvan listesi içe aktarma) ve paylaşım (verim raporu) kullanıcının
  seçtiği dosyayla, istek anında; arka planda erişim yok.
- Reklam kimliği kullanılmıyor → "Reklam kimliği" beyanında **Hayır**.
- Hedef kitle: 18+, işletmeler.
