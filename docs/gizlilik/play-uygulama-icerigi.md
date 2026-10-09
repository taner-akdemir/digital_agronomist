# Google Play — Uygulama içeriği ve mağaza beyanları (öneri)

> Kodun 09.10.2026 hâlinden çıkarıldı (AndroidManifest, `build/app/.../merged_manifests/release`,
> pubspec, `lib/`, backend `tools/demoseed`, site `src/site/company.ts`). Play Console ›
> Milk Trace › Politika › **Uygulama içeriği** ve **Mağaza ayarları** için önerilen
> cevaplardır; geliştirici hesabı sahibi onaylayıp girer. Veri güvenliği formunun
> ayrıntısı `play-veri-guvenligi.md`'de. Yeni izin, SDK, reklam ya da satın alma
> eklenirse bu dosya, veri güvenliği formu ve gizlilik politikası birlikte güncellenir.

Paket: `com.algebran.milktrace.milktrace` · Uygulama adı: **Milk Trace** · Sürüm `pubspec.yaml`.

## 1. Gizlilik politikası

- Adres (Play'e girilecek): `https://milktrace.com.tr/gizlilik`
- İngilizcesi: `https://milktrace.com.tr/en/privacy` (sayfalar birbirine bağlantılı;
  İngilizce metin "Türkçesi esastır" der). KVKK aydınlatma metni `https://milktrace.com.tr/kvkk`.
- Kullanım koşulları (Play istemez; mağaza açıklamasına ya da web'e konabilir):
  `https://milktrace.com.tr/kullanim-kosullari`, `https://milktrace.com.tr/en/terms`
  — **hukuki inceleme bekliyor**, sorumluluk üst sınırı yer tutucu.

## 2. Uygulama erişimi

- Seçim: **"Uygulamanın tüm işlevleri veya bir kısmı kısıtlıdır"** → giriş bilgileri
  verilir. Uygulamada kayıt yok; hesapları işletme sahibi ya da platform açar
  (giriş ekranı e-posta + parola).
- Hangi hesap: **Yeşilvadi Demo Çiftliği** (backend `tools/demoseed`, slug
  `yesilvadi-demo`; simülatör canlı sağım verisi üretir, sayaç ve hayvanlar örnek).
  - **İşletme sahibi** rolü: `demo-sahip@milktrace.com.tr` — bütün ekranlar (ayarlar,
    ekip, bildirim kanalları, eşikler dahil). İncelemeye bu verilir.
  - **Ziyaretçi** (salt okunur): `demo@milktrace.com.tr` — yedek; ayar ekranlarını göstermez.
- Parolalar yalnızca `~/.config/milktrace/demo-owner-password` ve
  `demo-viewer-password` dosyalarında ve kümede `demo-accounts` Secret'ında
  (`deploy/netcup/README.md` "Tanıtım çiftliği verisi"). **Bu dosyaya yazılmaz**; forma
  geliştirici hesabı sahibi kopyalar.
- İki adımlı doğrulama demo hesaplarında **kapalı** kalmalı (inceleyici kod alamaz).
  Hesap askıda olmamalı; inceleme süresince demo çiftliği ve simülatör (`DEMO_SIM`)
  açık tutulur.
- Talimat (forma, İngilizce):
  *Milk Trace is used by dairy farms to track milk yield per animal from milking-point
  meters. There is no sign-up in the app: accounts are created by the farm owner or the
  platform. Sign in with the demo farm owner account below (email + password). The demo
  farm "Yeşilvadi Demo Çiftliği" has simulated meters, so the Live tab shows milking in
  progress during the day. All data is sample data. The app UI is available in Turkish and
  English (account card → Language).*

## 3. Reklamlar

- Uygulamada reklam **yok** (pubspec'te reklam SDK'sı yok; birleşik manifestte
  `com.google.android.gms.permission.AD_ID` yok; Firebase Analytics yok).
- Reklam kimliği beyanı: **Hayır, uygulama reklam kimliği kullanmıyor.**

## 4. İçerik derecelendirmesi (IARC anketi)

- E-posta: `info@milktrace.com.tr`. Kategori: **"Diğer tüm uygulama türleri"** (oyun,
  sosyal/iletişim ya da referans/haber/eğitim değil).
- Şiddet, korku, cinsellik, küfür/kaba dil, uyuşturucu/alkol/tütün, kumar ya da
  benzetilmiş kumar: **Hayır**.
- Kullanıcılar birbiriyle etkileşebiliyor ya da içerik paylaşabiliyor mu: **Evet, sınırlı**
  — yalnızca aynı işletmenin ekip üyeleri hayvan notlarını görür; herkese açık sohbet,
  profil ya da yabancılarla iletişim yok. (Geri bildirim yalnızca destek ekibine gider.)
  Öneri: "Evet" işaretlenip moderasyon sorusunda "içerik yalnızca davetli işletme
  kullanıcılarına görünür" denir. Muhafazakâr cevap budur; "Hayır" seçilirse
  derecelendirme değişmez ama ileride sorgulanabilir.
- Kullanıcının konumu başkalarıyla paylaşılıyor mu: **Hayır** (konum izni yok; tesis
  koordinatı işletme sahibinin elle girdiği işletme verisidir).
- Dijital ürün satın alma: **Hayır** (uygulama içi satın alma yok; abonelik web sitesinde
  PayTR ile satılır, uygulama ödeme sayfasına yönlendirmez).
- Beklenen sonuç: **Herkes / 3+ (PEGI 3, USK 0)**; etkileşim notuyla "Kullanıcılar
  Etkileşime Girer" etiketi gelebilir.

## 5. Hedef kitle ve içerik

- Hedef yaş grubu: yalnızca **18 ve üzeri**. Çocuklara yönelik değil; "Çocukların
  ilgisini çekebilir mi" → **Hayır** (işletme yazılımı, giriş gerekli).
- Families politikası kapsamında değil; Öğretmen Onaylı programına başvurulmaz.

## 6. Veri güvenliği

Bkz. `play-veri-guvenligi.md`. Özet: ad, e-posta, kullanıcı kimliği, cihaz kimliği
(FCM jetonu), kullanıcı içeriği (not, geri bildirim), isteğe bağlı ekran görüntüsü,
kilitlenme günlükleri ve tanılama; aktarımda şifreli; satılmaz/paylaşılmaz; silme
uygulama içinden ve web'den.

## 7. Hesap silme ("Veri silme" bölümü)

- Uygulama içi: hesap kartı → **"Hesabımı sil"** (parola onayı).
- Web bağlantısı (Play'e girilecek): `https://milktrace.com.tr/hesap-sil`
  (İngilizcesi `https://milktrace.com.tr/en/delete-account`; sayfa e-posta + parola ile
  siler, iki adımlı doğrulama açık hesapta uygulamaya yönlendirir).
- Silinen: ad, e-posta, oturumlar, bildirim jetonu. Kalan: yazılan hayvan notları
  işletmenin sürü kaydı olarak ("Silinmiş kullanıcı"); geri bildirim kişiyle ilişkisi
  kaldırılarak 1 yıl. Tek sahip önce destekle görüşür.
- Kısmi veri silme (hesabı silmeden): **Hayır** — talep `info@milktrace.com.tr`.

## 8. İzinler ve hassas beyanlar

- Uygulamanın kendi manifesti: `INTERNET`, `POST_NOTIFICATIONS`.
- Kütüphanelerin eklediği (birleşik sürüm manifesti, 05.10.2026 derlemesi):
  `ACCESS_NETWORK_STATE`, `WAKE_LOCK` (firebase_messaging), `VIBRATE`
  (flutter_local_notifications), `com.google.android.c2dm.permission.RECEIVE` (FCM).
  Hiçbiri Play'de ayrı beyan istemez. (`play-veri-guvenligi.md`'deki "`VIBRATE` izni
  yok" notu uygulamanın KENDİ manifesti içindir; birleşik manifestte bildirim kütüphanesi
  ekliyor.)
- Konum, kamera, mikrofon, rehber, SMS/arama kaydı, depolama/medya izni, ön plan
  hizmeti, tam zamanlı alarm, erişilebilirlik hizmeti: **yok** → ilgili beyan formları
  boş kalır. Dosya seçici sistem seçicisidir (izin istemez).
- Sağımhane tabletinde ekranı açık tutma `wakelock_plus` (pencere bayrağı, izin değil).

## 9. Diğer beyanlar

- Haber uygulaması: **Hayır**. Devlet uygulaması: **Hayır**. Finansal özellikler: **Yok**
  (bankacılık, kredi, kripto yok; abonelik ödemesi web'de).
- Sağlık uygulaması: **Hayır** — insan sağlığı verisi yok; hayvan sürü kayıtları ve sağım
  ölçümü (hayvancılık işletme yazılımı). Sağlık kategorisinde "Hiçbiri" işaretlenir.
- COVID-19 izleme: Hayır. VPN: Hayır.

## 10. Mağaza ayarları ve giriş

- Uygulama mı oyun mu: **Uygulama**. Kategori: **İş** (Business). Etiketler (öneri):
  Tarım, Verimlilik.
- İletişim: e-posta **`info@milktrace.com.tr`** (zorunlu; site altbilgisi, gizlilik
  politikası), web sitesi **`https://milktrace.com.tr`**; telefon isteğe bağlı —
  mesafeli satış sözleşmesindeki `+90 530 320 06 47` kullanılabilir (karar sahibin).
- Varsayılan dil **Türkçe (tr-TR)**, çeviri **İngilizce (en-US)**: ad, kısa ve tam
  açıklama, ekran görüntüleri her dilde.
- Ekran görüntüleri: `MILKTRACE_STORE_SCREENS=<klasör> flutter test test/store_screens_test.dart`
  → `<klasör>/{tr,en}/01-…07-*.png` (1080×1920, sahte veri). Play telefonda en az 2,
  önerilen 4–8 görüntü ister.
- **Eksik (bu repoda yok):** 512×512 uygulama simgesi PNG'si ve 1024×500 öne çıkan
  görsel (feature graphic) — `tool/brand/` kaynaklarından üretilmeli.
- Yapay zekâyla üretilmiş içerik: uygulama üretken yapay zekâ özelliği içermiyor.
