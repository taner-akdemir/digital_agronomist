# App Store Connect — "Uygulama Gizliliği" cevapları (taslak)

> `play-veri-guvenligi.md` ile aynı kaynaktan (05.10.2026). Uygulamadaki karşılığı
> `ios/Runner/PrivacyInfo.xcprivacy`; yeni izin, SDK ya da veri toplayan form
> eklenirse üçü birlikte güncellenir.

| Soru | Cevap |
|---|---|
| Veri topluyor musunuz? | **Evet** |
| İzleme (tracking, ATT) | **Hayır** — reklam yok, Analytics yok, IDFA okunmaz |
| Gizlilik politikası | `https://milktrace.com.tr/gizlilik` |
| Hesap silme | Uygulama içi: hesap kartı → "Hesabımı sil" (Apple 5.1.1(v) şartı) |
| Şifreleme beyanı | `ITSAppUsesNonExemptEncryption = false` (Info.plist): yalnızca HTTPS/TLS |

## Toplanan veri

| Apple kategorisi | Kimliğe bağlı | Amaç |
|---|---|---|
| İletişim bilgileri → Ad | Evet | Uygulama işlevi |
| İletişim bilgileri → E-posta adresi | Evet | Uygulama işlevi |
| Tanımlayıcılar → Kullanıcı kimliği | Evet | Uygulama işlevi |
| Tanımlayıcılar → Cihaz kimliği (FCM/APNs jetonu) | Evet | Uygulama işlevi (bildirim) |
| Kullanıcı içeriği → Diğer (hayvan notları, geri bildirim metni) | Evet | Uygulama işlevi |
| Kullanıcı içeriği → Fotoğraflar (isteğe bağlı, geri bildirime SEÇİLEN görüntü) | Evet | Uygulama işlevi |
| Tanılama → Kilitlenme verisi (Crashlytics) | **Hayır** (`setUserIdentifier` çağrılmaz) | Analiz |
| Tanılama → Diğer tanılama verisi | **Hayır** | Analiz |
| Konum, rehber, sağlık, finans, tarama, arama geçmişi | Toplanmaz | — |

Galeri izni istenmez: seçici sistemin (PHPicker) penceresi, yalnızca seçilen görüntü
uygulamaya gelir. `NSPhotoLibraryUsageDescription` yine de Info.plist'te — dosya
seçici eklentisi galeri API'lerine bağlandığı için App Store yüklemede amaç metni
olmayan paketi reddeder (ITMS-90683).

İnceleme notu (App Review): hesaplar uygulamada açılmaz, işletme sahibi ya da
platform açar — incelemeye demo işletmenin bir kullanıcı adı ve parolası verilmeli.
