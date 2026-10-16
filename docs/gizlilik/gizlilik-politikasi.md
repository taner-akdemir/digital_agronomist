# Milk Trace — Gizlilik Politikası

> **TASLAK (28.09.2026).** Koddaki gerçek veri akışından çıkarıldı; yayımlamadan önce
> hukuki kontrolden geçmeli. Play Console bu
> metnin herkese açık bir adresini ister (`https://milktrace.com.tr/gizlilik`; KVKK metni `/kvkk`). Site
> (`~/WebstormProjects/milktrace-site`) bu dosyayı KOPYALAYARAK yayımlar: burada değiştirince
> sitede `scripts/sync-legal.sh` koşulur. `>` alıntı blokları (bu not) yayımlanmaz.
>
> **11.10.2026:** resmî unvan, VKN, KEP ve web adresi eklendi; "çerez ya da izleme aracı
> kullanılmaz" ifadesi sitenin çerez politikasıyla (site repo `src/legal/cerez-politikasi.md`,
> `CONSENT_VERSION`) uyumlu hâle getirildi: izinle çalışan Cloudflare Web Analytics ve
> dönüşüm sayacı (backend ADR 0131), zorunlu çerez/depolama, Cloudflare (ABD) aktarımı.
> Cloudflare ile standart sözleşme ve Kurul'a bildirim durumu hukukçuyla doğrulanmalı.

**Son güncelleme:** 16 Ekim 2026

Milk Trace, süt hayvancılığı işletmelerinin sağım noktalarındaki sayaçlardan gelen
ölçümlerle her hayvanın ne kadar süt verdiğini izlemesini sağlayan bir hizmettir. Bu
politika, Milk Trace mobil uygulaması, web paneli (milktrace.com.tr) ve tanıtım
sitesindeki demo talep formu üzerinden işlenen kişisel verileri anlatır. Sitede ve web
panelinde kullanılan çerezler ve tarayıcı depolaması ayrıca Çerez Politikası'nda
(https://milktrace.com.tr/cerez-politikasi) ayrıntılı anlatılır.

## 1. Hizmeti sunan

Albiferro Yazılım ve Sistem Limited Şirketi, Atakent Mah. 1472. Cad. No: 5 D: 3, Elvankent, Etimesgut / Ankara; Etimesgut Vergi Dairesi, VKN 0210300337. E-posta: info@milktrace.com.tr; KEP: taner.akdemir@hs01.kep.tr; web: https://algebransoft.com.

Milk Trace işletmelere (çiftliklere) sunulur. Uygulamayı kullanan kişilerin hesaplarını
işletme adına platform yöneticisi açar; uygulama içinden hesap oluşturulmaz.

## 2. Hangi verileri işliyoruz

**Hesap bilgileri:** ad soyad, e-posta adresi, işletmedeki rol (sahip, operatör,
izleyici), hesap durumu. Parolanız yalnızca geri çevrilemez bir özet olarak saklanır.
İki adımlı doğrulamayı açarsanız doğrulama anahtarı şifrelenmiş, yedek kodlar geri
çevrilemez özet olarak saklanır.

**Oturum bilgileri:** giriş yaptığınız cihazın oturum jetonları, bu oturumu açan
uygulamanın/tarayıcının kimlik bilgisi (user-agent) ve oturumun son kullanıldığı IP
adresi — "Oturumlar" ekranında cihazlarınızı tanıyıp kapatabilmeniz için; oturum
kapanınca ya da en geç 30 gün sonra geçersizleşir. Yanlış parola denemeleri e-posta ve IP
adresinin geri çevrilemez özetiyle en çok bir gün sayılır (tahmin saldırılarına karşı). Oturum jetonları telefonunuzda
işletim sisteminin güvenli deposunda, web panelinde tarayıcınızın yerel deposunda tutulur.

**Bildirim bilgileri:** bildirim alabilmeniz için telefonunuzun bildirim jetonu
(Firebase Cloud Messaging) ve platformu (Android/iOS). Çıkış yaptığınızda silinir.

**Uygulama hata raporları:** uygulama çöktüğünde ya da beklenmedik bir hata olduğunda
hatanın teknik ayrıntısı (yığın izi), cihaz modeli, işletim sistemi ve uygulama sürümü
Firebase Crashlytics'e gönderilir. Rapora adınız, e-postanız, işletmeniz ya da hayvan
bilgisi eklenmez; amaç hataları bulup düzeltmektir.

**İşletme verileri:** işletmenin girdiği hayvan kayıtları (küpe numarası, adı, ırkı, doğum
ve buzağılama tarihleri, RFID), sağım ölçümleri, uyarılar ve hayvan notları. Notlarda
notu yazan kullanıcının adı görünür. Bu veriler hayvanlara ve işletmeye aittir; notlar ve
yazar bilgisi dışında kişisel veri içermez.

**Bildirim kanalı alıcıları:** işletme sahibinin uyarı almak için tanımladığı e-posta
adresleri ve telefon numaraları.

**İşlem kaydı:** işletmenin ayarlarını ve kayıtlarını değiştiren işlemlerde (eşik,
hayvan kaydı, eşleştirme, kullanıcı, bildirim kanalı) işlemi kimin ve ne zaman yaptığı;
işletme sahibi görür, **90 gün** saklanır.

**Geri bildirim:** uygulamadan gönderdiğiniz geri bildirimin metni, isteğe bağlı olarak
seçtiğiniz ekran görüntüsü ve otomatik eklenen uygulama sürümü, platform, işletim sistemi
sürümü ve cihaz modeli; kullanıcı kimliğiniz ve işletmenizle birlikte. Yalnızca Milk Trace
destek ekibi (platform yöneticisi) görür; hataları gidermek ve uygulamayı geliştirmek için
kullanılır, **1 yıl** saklanır.

**Demo talepleri:** tanıtım sitesindeki formu dolduranların adı, telefonu, isteğe bağlı
e-postası, çiftlik adı ve mesajı ile formu gönderen IP adresi ve tarayıcı bilgisi. Yalnızca
size dönmek için kullanılır, **1 yıl** saklanır.

**Abonelik ödemesi:** işletme sahibi abonelik satın alırken fatura unvanı ya da ad soyad,
T.C. kimlik numarası (şahısta isteğe bağlı) ya da vergi kimlik numarası ve vergi dairesi,
fatura adresi, e-posta ve telefon girer; sipariş (dönem, tutar, ödeme sonucu), onaylanan
sözleşme sürümü, onay anı ve IP adresi kaydedilir. **Kart bilgileriniz bize gelmez**: kartı
ödeme kuruluşu PayTR'nin sayfasına girersiniz. Fatura bilgileri yalnızca işletme sahibi ve
Milk Trace yöneticileri tarafından görülür.

**Sunucu kayıtları:** güvenlik ve hata ayıklama için isteklerin zamanı, yolu, sonucu ve
istek yapan IP adresi.

**Web sitesi ölçümü (yalnızca izninizle):** tanıtım sitesinde ve web panelinde çerez
bandında "Analiz"e izin verirseniz iki ölçüm çalışır; izin vermezseniz hiçbiri yüklenmez ve
hiçbir istek gönderilmez:

- **Cloudflare Web Analytics** (Cloudflare, Inc., ABD): `static.cloudflareinsights.com`
  adresinden bir betik yüklenir; ziyaret edilen sayfa adresi, yönlendiren sayfa, tarayıcı
  türü, ekran boyutu ve sayfa yükleme süreleri Cloudflare'e gönderilir. Bu istekte IP
  adresiniz Cloudflare'e ulaşır; Cloudflare'in açıklamasına göre ziyaretçiyi tanımak için
  kullanılmaz. Çerez ya da yerel depolama kullanmaz.
- **Milk Trace dönüşüm sayacı** (birinci taraf): demo formunun gönderilmesi (başarılı ya da
  hatalı), WhatsApp ve telefon bağlantılarına, Google Play bağlantısına tıklanması gibi
  olaylarda sunucumuza yalnızca olayın adı ve sayfadaki yeri (ör. "whatsapp_click",
  "footer") gönderilir. Ad, e-posta, kimlik, cihaz bilgisi ya da çerez gönderilmez; sunucuda
  yalnızca olay başına toplam sayı tutulur (90 gün), kişiyle ilişkilendirilmez. İstek, diğer
  bütün istekler gibi sunucu kayıtlarına (IP adresi dahil, 30 gün) düşer.

**Zorunlu çerezler ve tarayıcı depolaması (izin gerekmez):** çerez tercihinizi saklayan
`cookie_consent` çerezi (politika sürümü, seçim zamanı ve seçimler; 180 gün); dil seçimi;
web panelinde giriş yaptıysanız oturum yenileme jetonu ve oturum işareti, tema ve ekran
tercihleri (tarayıcının yerel deposunda). Site Cloudflare üzerinden sunulur; Cloudflare'in
bot ve saldırı koruması bir güvenlik doğrulaması başlatırsa Cloudflare güvenlik çerezleri
(`__cf_bm`, `cf_clearance`) yazılabilir. Reklam, sosyal medya ya da yeniden hedefleme çerezi
kullanılmaz. Tam liste ve süreler: Çerez Politikası (https://milktrace.com.tr/cerez-politikasi).

**Toplamadıklarımız:** konum, rehber, mikrofon; fotoğraf (geri bildirime kendi
seçtiğiniz ekran görüntüsü dışında); reklam kimliği; reklam amaçlı izleme ya da profil
çıkarma. Mobil uygulamada reklam ve kullanım analitiği yoktur.

## 3. Neden işliyoruz

- Hizmeti sunmak: giriş, canlı sağım ekranı, hayvan geçmişi, raporlar (sözleşmenin ifası).
- Sizi uyarmak: sayaç arızası, sağım özeti gibi bildirimler (sözleşmenin ifası).
- Güvenlik ve kötüye kullanımın önlenmesi, hata ayıklama (meşru menfaat).
- Faturalama ve abonelik: işletmenin sağmal hayvan sayısına göre fiyat, ödeme, fatura ve
  dönem bitimi hatırlatması (sözleşmenin ifası; fatura kayıtları için vergi mevzuatı).
- Zorunlu çerezler ve tarayıcı depolaması: panel oturumu ve istediğiniz ayarlar (KVKK
  md. 5/2-c, sözleşmenin kurulması ve ifası), sitenin güvenliği ve çerez tercihinizin
  hatırlanması (md. 5/2-f, meşru menfaat).
- Web sitesi ölçümü (Cloudflare Web Analytics ve dönüşüm sayacı): sitenin nasıl
  kullanıldığını anlayıp geliştirmek — yalnızca **açık rızanızla** (KVKK md. 5/1); rızanızı
  her an sayfaların altındaki "Çerez tercihleri" bağlantısından geri alabilirsiniz.

## 4. Kimlerle paylaşıyoruz

Verileri satmıyoruz. Hizmeti sunmak için yalnızca aşağıdaki hizmet sağlayıcılarla,
gerektiği kadar:

| Sağlayıcı | Ne için | Nerede |
|---|---|---|
| netcup GmbH | sunucu barındırma (tüm veriler) | Almanya |
| Cloudflare, Inc. | sitenin ve web panelinin ağ üzerinden sunulması ve saldırılara karşı korunması (IP adresi, istek bilgisi, gerekirse güvenlik çerezi); yalnızca izninizle Web Analytics (sayfa adresi, yönlendiren, tarayıcı, ekran, yükleme süresi) | ABD / küresel |
| Google (Firebase Cloud Messaging) | bildirim iletimi (bildirim jetonu, bildirim metni) | ABD / AB |
| Google (Firebase Crashlytics) | uygulama hata raporları (yığın izi, cihaz modeli, sürüm) | ABD / AB |
| Twilio SendGrid | işletmenin seçtiği e-posta bildirimleri, parola sıfırlama, ödeme onayı ve abonelik hatırlatması e-postaları (e-posta adresi, ad) | ABD |
| PayTR Ödeme ve Elektronik Para Kuruluşu A.Ş. | abonelik ödemesi (ad/unvan, e-posta, telefon, adres, tutar; kart bilgisini doğrudan siz girersiniz) | Türkiye |
| Mali müşavirimiz ve e-Fatura hizmet sağlayıcısı | faturanın düzenlenmesi (fatura bilgileri) | Türkiye |
| NetGSM / İleti Merkezi / JetSMS | işletmenin seçtiği SMS (NetGSM: sesli arama da) bildirimleri (telefon numarası, bildirim metni) | Türkiye |
| Twilio / Vonage | işletmenin seçtiği SMS ve sesli arama bildirimleri (telefon numarası, bildirim metni) | ABD |
| Open-Meteo | ısı stresi uyarısı için hava tahmini — sunucumuz yalnızca işletme sahibinin girdiği tesis koordinatını gönderir; kişisel veri gönderilmez (backend ADR 0119) | İsviçre (OpenMeteo GmbH) |
| Slack / Microsoft Teams | işletmenin seçtiği sohbet kanalı bildirimleri (bildirim metni) | ABD |
| İşletmenin kendi posta sunucusu (SMTP) ya da webhook adresi | işletmenin tanımladığı bildirimler; alıcı adresi işletmenin seçimidir | işletmenin seçtiği yer |

Aynı işletmenin kullanıcıları o işletmenin verilerini rollerine göre görür. Başka bir
işletme sizin işletmenizin verisini göremez.

**Mandıra paylaşımı (yalnızca açık onayınızla).** İşletme sahibi uygulamada ya da web
panelinde "Entegrasyonlar → Mandıra paylaşımı"ndan sütünü sattığı mandırayı seçip açık
onay verirse, o mandıranın yetkili kullanıcıları onay süresince (3 ay, 1 yıl ya da süresiz)
işletmenin **çiftlik bazlı** verilerini görür: işletme adı, toplam süt miktarı ve günlük
eğilimi, ortalama sağım debisi, sağılan hayvan sayısı, tank teslimleri ve sonraki teslim
tahmini, mandıra analizi (yağ, protein, somatik hücre, bakteri). Hayvan adı, küpe numarası,
hayvan bazlı veri, kullanıcı ve ekip bilgisi **paylaşılmaz**. Onay verilmedikçe hiçbir
mandıraya veri gitmez; onay her an tek dokunuşla geri alınır ve hemen geçerli olur.

## 5. Yurt dışına aktarım

Sunucular Almanya'dadır; bildirim ve e-posta sağlayıcılarının bir kısmı ve Cloudflare
ABD'dedir. Bu aktarımlar KVKK md. 9 kapsamında, Kişisel Verileri Koruma Kurulu'nun ilan
ettiği standart sözleşme alıcılarla imzalanıp Kurul'a bildirilerek yapılır. Cloudflare Web
Analytics ile yapılan ölçüm verisinin yurt dışına aktarılması ise ayrıca çerez bandında
verdiğiniz **açık rızaya** (KVKK md. 5/1 ve md. 9) dayanır; izin vermezseniz bu aktarım
olmaz.

## 6. Ne kadar saklıyoruz

- Hesap ve işletme verileri: işletmenin hizmet sözleşmesi sürdükçe; sözleşme sona
  erdikten **90 gün** sonra kendiliğinden silinir. Bu sürede işletme sahibinin talebiyle
  işletmenin bütün verisi (hayvanlar, sağımlar, notlar, uyarılar) Excel dosyası olarak verilir. Faturalama için yalnızca işletmenin kullandığı sayaç-gün kayıtları,
  işletme adı anonimleştirilerek, vergi mevzuatının öngördüğü süre saklanır. Abonelik
  siparişleri fatura bilgileriyle birlikte aynı nedenle vergi mevzuatının öngördüğü süre
  saklanır.
- Veritabanı yedekleri: 7 gün (sunucu dışı kopya kullanılıyorsa o kopya 14 gün); silinen
  veri en geç bu süre sonunda yedeklerden de çıkar.
- Uygulama hata raporları: Firebase Crashlytics'in saklama süresi (90 gün).
- Bildirim jetonu: çıkışta ya da jeton geçersizleşince silinir.
- Sunucu kayıtları (IP adresi dahil): **30 gün**.
- İşlem kaydı (kim, neyi, ne zaman değiştirdi): **90 gün**.
- Demo talepleri: **1 yıl**.
- Çerez tercihiniz (`cookie_consent`): **180 gün**; süre dolunca ya da Çerez Politikası
  yeni sürümle değişince yeniden sorulur.
- Dönüşüm sayacı (yalnızca olay başına toplam sayı): **90 gün**. Cloudflare Web Analytics
  verisi Cloudflare'in saklama süresine tabidir.
- Geri bildirim (metin, ekran görüntüsü, cihaz bilgisi): **1 yıl**. Hesabınızı silerseniz
  geri bildirim kalır ama sizinle ilişkisi kaldırılır.

## 7. Telefonunuzda ve tarayıcınızda tutulanlar

Mobil uygulamada oturum jetonu işletim sisteminin güvenli deposunda; çevrimdışı kullanım
için son görüntülenen veriler uygulamanın kendi deposunda. Çıkış yaptığınızda ikisi de
silinir. Mobil uygulama çerez ya da izleme aracı kullanmaz.

Web panelinde oturum yenileme jetonu, dil ve tema tercihi tarayıcının yerel deposunda
tutulur; çıkışta jeton silinir. Sitede ve web panelinde yalnızca yukarıda anlatılan zorunlu
çerezler ve depolama ile, izin verirseniz, analiz ölçümü kullanılır. Tercihinizi her
sayfanın altındaki **"Çerez tercihleri"** bağlantısından her zaman değiştirebilirsiniz;
ayrıntılar Çerez Politikası'ndadır (https://milktrace.com.tr/cerez-politikasi).

## 8. Haklarınız

KVKK md. 11 uyarınca verilerinizin işlenip işlenmediğini öğrenme, bilgi isteme,
düzeltilmesini ya da silinmesini isteme, itiraz etme ve zararın giderilmesini isteme
haklarına sahipsiniz. Başvuru: info@milktrace.com.tr ya da KEP ile taner.akdemir@hs01.kep.tr.
**Hesabınızı kendiniz silebilirsiniz:**
uygulamada hesap kartı → "Hesabımı sil" ya da https://milktrace.com.tr/hesap-sil
(parolanızla). Bir işletmenin tek sahibiyseniz işletme sahipsiz kalmasın diye önce bize
başvurun. Hesap silinince adınız, e-postanız,
oturumlarınız ve bildirim jetonunuz kalıcı olarak silinir; yazdığınız hayvan notları
işletmenin sürü kaydı olarak kalır ve yazarı "Silinmiş kullanıcı" görünür.

## 9. Çocuklar

Hizmet işletmelere yöneliktir; 18 yaşından küçüklere yönelik değildir.

## 10. Değişiklikler

Bu politikayı değiştirirsek güncel hâlini bu adreste yayımlar, önemli değişiklikleri
uygulama içinden duyururuz.
