# App Review — Guideline 2.1 "Information Needed" yanıtı

1.3.0 (8), 30.10.2026'da bu gerekçeyle reddedildi: hesap yeni, Apple ek bilgi ve
**fiziksel cihazda çekilmiş ekran kaydı** istiyor. Kod hatası yok. Aşağıdaki metin hem
"Reply to App Review" mesajına hem sürümün App Review Information → Notes alanına
girer (Apple ikisini de istiyor; Notes sonraki sürümlerde de kalsın).

## Ekran kaydı (iPhone, son iOS)

Kayıt uygulamanın açılışıyla başlar, sırayla:

1. Uygulamayı aç → giriş ekranı (uygulamada kayıt olma yok, bunu göster)
2. Demo hesapla giriş
3. Canlı, Özet, Geçmiş, Cihazlar sekmeleri; bir hayvan kartı; Uyarılar
4. Yardım asistanına bir soru
5. Hesap (sağ üst kişi simgesi) → "Hesabımı sil" penceresini aç, **onaylama**
   (demo hesap ortak; iptal et)
6. Çıkış

## Metin (İngilizce)

```
1. Screen recording: attached (iPhone, latest iOS). It starts at app launch and shows sign-in with the demo account, the main screens, the in-app account deletion flow (Account > "Hesabımı sil"; cancelled at the last step because the demo account is shared) and sign-out. There is no in-app registration, no user-generated content shared between users, and no paid content in the app.

2. Purpose and audience: Milk Trace is a business app for dairy farms in Türkiye. IoT milk meters installed at each milking point measure milk flow and volume per animal. The app shows milking live, keeps herd records (animals, lineage, vaccinations, deliveries to the dairy) and sends alerts such as low flow or an offline meter. It lets farmers spot a sick or under-producing animal early instead of discovering it days later in the bulk tank.

3. Access: accounts are created for each farm by Albiferro when the meters are installed, so there is no sign-up inside the app. Use the demo account in App Review Information (read-only viewer of a demo farm with simulated meters; Live, Dashboard, History and Devices show data). Account deletion: Account (top-right person icon) > "Hesabımı sil", or https://milktrace.com.tr/hesap-sil.

4. External services: our own backend (api.milktrace.com.tr, hosted by us); Firebase Cloud Messaging / APNs for alert notifications; Firebase Crashlytics for crash reports (not linked to the user). The in-app help assistant searches our own help center text on our server; no third-party AI service is used. No payment processor is used in the app: the farm's subscription is a business contract with Albiferro, invoiced outside the app, and the app has no purchase links.

5. Regional differences: none. The app is offered in Türkiye, in Turkish and English, with the same features everywhere.

6. Regulation: not a regulated industry and no protected third-party content. The app shows only the farm's own measurement and herd data.
```
