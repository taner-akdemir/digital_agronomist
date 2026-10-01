# Milk Trace — KVKK Aydınlatma Metni

> **TASLAK (28.09.2026; ödeme ve fatura 01.10.2026, backend ADR 0130)** — 6698 sayılı KVKK md. 10 ve Aydınlatma Yükümlülüğü Tebliği
> yapısında. Hukuki kontrolden geçmeli.
>
> **Hukukçu için açık soru — roller:** İşletmenin (çiftliğin) kendi çalışanlarının ve
> bildirim alıcılarının verileri bakımından **veri sorumlusu işletme**, Milk Trace ise
> **veri işleyen** olabilir; platform hesapları ve güvenlik kayıtları bakımından Milk Trace
> veri sorumlusudur. Bu ayrım işletmelerle yapılacak sözleşmeye (veri işleme eki) yazılmalı.

## Veri sorumlusu

Algebran Soft (Taner Akdemir, şahıs işletmesi), Atakent Mah. 1472. Cad. Eda Apt. No: 5 D: 3, Elvankent, Etimesgut / Ankara (Etimesgut Vergi Dairesi); iletişim: taner.akdemir@algebransoft.com.

## İşlenen kişisel veriler ve amaçları

| Veri kategorisi | Veriler | Amaç | Hukuki sebep (md. 5/2) |
|---|---|---|---|
| Kimlik / iletişim | ad soyad, e-posta | hesap, giriş, bildirim | (c) sözleşmenin kurulması/ifası |
| Müşteri işlem | işletmedeki rol, hayvan notları ve yazarı | hizmetin sunulması | (c) sözleşmenin ifası |
| İşlem güvenliği | parola özeti, oturum jetonları, user-agent, IP adresi (sunucu kayıtları) | güvenlik, kötüye kullanımın önlenmesi | (ç) hukuki yükümlülük, (f) meşru menfaat |
| İşlem kaydı | işlemi yapan kullanıcı, işlem ve zamanı (90 gün) | işletme içi hesap verebilirlik | (f) meşru menfaat |
| Cihaz | bildirim jetonu, platform | bildirim iletimi | (c) sözleşmenin ifası |
| Uygulama hata raporu | yığın izi, cihaz modeli, işletim sistemi, uygulama sürümü (kişiyle ilişkilendirilmez) | hataların bulunup giderilmesi | (f) meşru menfaat |
| Geri bildirim | kullanıcının yazdığı metin, isteğe bağlı seçtiği ekran görüntüsü, uygulama sürümü, platform, işletim sistemi sürümü, cihaz modeli, kullanıcı kimliği ve işletme (1 yıl) | destek, hataların giderilmesi, hizmetin geliştirilmesi | (f) meşru menfaat |
| Demo talebi | ad, telefon, e-posta (isteğe bağlı), çiftlik adı, mesaj, IP adresi, tarayıcı (1 yıl) | talep sahibine dönülmesi | (c) sözleşmenin kurulmasıyla doğrudan ilgili (talep sahibinin isteği) |
| İletişim (alıcı) | bildirim kanalı e-posta/telefon | uyarıların iletilmesi | (c) sözleşmenin ifası; alıcı işletme dışındaysa (f) meşru menfaat |
| Ödeme ve fatura | fatura unvanı ya da ad soyad, T.C. kimlik no (şahısta isteğe bağlı) ya da vergi kimlik no ve vergi dairesi, fatura adresi, e-posta, telefon; sipariş (dönem, tutar, ödeme sonucu, iade); onaylanan sözleşme sürümü, onay anı ve IP adresi. **Kart bilgisi Milk Trace'e gelmez.** | abonelik satışı, faturanın düzenlenmesi, ödeme hatırlatması, sözleşme onayının ispatı | (c) sözleşmenin kurulması/ifası, (ç) hukuki yükümlülük (vergi mevzuatı), (e) bir hakkın tesisi/korunması |

## Toplama yöntemi

Hesaplar platform yöneticisi tarafından işletme adına açılır; diğer veriler mobil
uygulama, web paneli ve tanıtım sitesindeki demo formu üzerinden elektronik olarak, sağım verileri sayaçlardan
otomatik olarak toplanır.

## Aktarım

- **Yurt içi:** SMS ve sesli arama sağlayıcıları (NetGSM / İleti Merkezi / JetSMS) —
  işletmenin seçtiği bildirimler. **PayTR Ödeme ve Elektronik Para Kuruluşu A.Ş.** (lisanslı
  ödeme kuruluşu) — abonelik ödemesi: ad/unvan, e-posta, telefon, adres ve tutar; kart
  bilgilerini PayTR'nin ödeme sayfasına doğrudan siz girersiniz. Faturayı düzenleyen mali
  müşavirimiz ve e-Fatura hizmet sağlayıcısı (Türkiye) — fatura bilgileri.
- **Yurt dışı (md. 9):** netcup GmbH (Almanya, barındırma); Google LLC (Firebase Cloud
  Messaging, bildirim; Firebase Crashlytics, uygulama hata raporları); Twilio SendGrid (ABD, e-posta);
  işletme seçerse Twilio / Vonage (ABD, SMS ve sesli arama), Slack / Microsoft Teams (ABD,
  sohbet bildirimi). Dayanak: md. 9 uyarınca Kurul'un ilan ettiği standart sözleşme; sözleşme
  imzalandıktan sonra 5 iş günü içinde Kurul'a bildirilir.
- Ödeme altyapısı: ödeme isteği, Algebran Soft'un işlettiği ödeme sunucusu üzerinden PayTR'ye
  iletilir; bu sunucu netcup GmbH'de, Almanya'dadır (yukarıdaki yurt dışı aktarımla aynı
  dayanak).
- Hava tahmini (Open-Meteo, İsviçre): ısı stresi uyarısı için yalnızca tesisin koordinatı
  gönderilir; kişisel veri aktarılmaz (backend ADR 0119).
- Yetkili kamu kurumlarına, hukuki yükümlülük hâlinde.

## Saklama süresi

Hizmet sözleşmesi süresince ve sona ermesinden sonra 90 gün; ardından kendiliğinden
silinir (faturalama kayıtları işletme adı anonimleştirilerek vergi mevzuatı süresince
saklanır). Abonelik siparişleri ve fatura bilgileri vergi mevzuatının öngördüğü süre
(Vergi Usul Kanunu'na göre 5 yıl, Türk Ticaret Kanunu'na göre 10 yıl; uzun olan süre uygulanır) saklanır; işletme
verisi silindiğinde de silinmez. Yedekler 7 gün (sunucu dışı kopya 14 gün), sunucu kayıtları (IP adresi dahil) 30 gün, uygulama içi geri bildirim ve demo talepleri 1 yıl. Süre sonunda
silinir, yok edilir ya da anonimleştirilir. Sözleşme sürerken hesap uygulamadan ("Hesabımı
sil") ya da https://milktrace.com.tr/hesap-sil adresinden kalıcı silinir; yazılan hayvan notları sürü kaydı olarak kalır, yazar adı kaldırılır.

## Haklarınız (md. 11)

Kişisel verinizin işlenip işlenmediğini öğrenme, işlenmişse bilgi talep etme, amacını ve
amaca uygun kullanılıp kullanılmadığını öğrenme, aktarıldığı üçüncü kişileri bilme, eksik ya
da yanlış işlenmişse düzeltilmesini, md. 7 şartlarıyla silinmesini/yok edilmesini, bu
işlemlerin aktarılan kişilere bildirilmesini isteme, münhasıran otomatik sistemlerle analiz
sonucu aleyhe bir sonuca itiraz etme ve kanuna aykırı işleme sebebiyle zararın giderilmesini
talep etme.

Başvuru: taner.akdemir@algebransoft.com ya da yazılı olarak Atakent Mah. 1472. Cad. Eda Apt. No: 5 D: 3, Elvankent, Etimesgut / Ankara adresine, Veri Sorumlusuna Başvuru Usul ve Esasları Hakkında
Tebliğ'e uygun olarak. Başvurular en geç 30 gün içinde ücretsiz sonuçlandırılır.
