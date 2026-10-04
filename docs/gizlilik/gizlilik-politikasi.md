# Milk Trace — Gizlilik Politikası

> **TASLAK (28.09.2026).** Koddaki gerçek veri akışından çıkarıldı; yayımlamadan önce
> hukuki kontrolden geçmeli. Play Console bu
> metnin herkese açık bir adresini ister (`https://milktrace.com.tr/gizlilik`; KVKK metni `/kvkk`). Site
> (`~/WebstormProjects/milktrace-site`) bu dosyayı KOPYALAYARAK yayımlar: burada değiştirince
> sitede `scripts/sync-legal.sh` koşulur. `>` alıntı blokları (bu not) yayımlanmaz.

**Son güncelleme:** 1 Ekim 2026

Milk Trace, süt hayvancılığı işletmelerinin sağım noktalarındaki sayaçlardan gelen
ölçümlerle her hayvanın ne kadar süt verdiğini izlemesini sağlayan bir hizmettir. Bu
politika, Milk Trace mobil uygulaması, web paneli (milktrace.com.tr) ve tanıtım
sitesindeki demo talep formu üzerinden işlenen kişisel verileri anlatır.

## 1. Hizmeti sunan

Algebran Soft (Taner Akdemir, şahıs işletmesi), Atakent Mah. 1472. Cad. Eda Apt. No: 5 D: 3, Elvankent, Etimesgut / Ankara (Etimesgut Vergi Dairesi). İletişim: taner.akdemir@algebransoft.com.

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

**Toplamadıklarımız:** konum, rehber, mikrofon; fotoğraf (geri bildirime kendi
seçtiğiniz ekran görüntüsü dışında); reklam kimliği; kullanım
analitiği ya da reklam amaçlı izleme. Uygulamada reklam yoktur.

## 3. Neden işliyoruz

- Hizmeti sunmak: giriş, canlı sağım ekranı, hayvan geçmişi, raporlar (sözleşmenin ifası).
- Sizi uyarmak: sayaç arızası, sağım özeti gibi bildirimler (sözleşmenin ifası).
- Güvenlik ve kötüye kullanımın önlenmesi, hata ayıklama (meşru menfaat).
- Faturalama ve abonelik: işletmenin sağmal hayvan sayısına göre fiyat, ödeme, fatura ve
  dönem bitimi hatırlatması (sözleşmenin ifası; fatura kayıtları için vergi mevzuatı).

## 4. Kimlerle paylaşıyoruz

Verileri satmıyoruz. Hizmeti sunmak için yalnızca aşağıdaki hizmet sağlayıcılarla,
gerektiği kadar:

| Sağlayıcı | Ne için | Nerede |
|---|---|---|
| netcup GmbH | sunucu barındırma (tüm veriler) | Almanya |
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

Sunucular Almanya'dadır; bildirim ve e-posta sağlayıcılarının bir kısmı ABD'dedir. Bu
aktarımlar KVKK md. 9 kapsamında, Kişisel Verileri Koruma Kurulu'nun ilan ettiği standart
sözleşme alıcılarla imzalanıp Kurul'a bildirilerek yapılır.

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
- Geri bildirim (metin, ekran görüntüsü, cihaz bilgisi): **1 yıl**. Hesabınızı silerseniz
  geri bildirim kalır ama sizinle ilişkisi kaldırılır.

## 7. Telefonunuzda tutulanlar

Oturum jetonu işletim sisteminin güvenli deposunda; çevrimdışı kullanım için son
görüntülenen veriler uygulamanın kendi deposunda. Çıkış yaptığınızda ikisi de silinir.
Web panelinde oturum yenileme jetonu, dil ve tema tercihi tarayıcının yerel deposunda
tutulur; çerez ya da izleme aracı kullanılmaz. Çıkışta jeton silinir.

## 8. Haklarınız

KVKK md. 11 uyarınca verilerinizin işlenip işlenmediğini öğrenme, bilgi isteme,
düzeltilmesini ya da silinmesini isteme, itiraz etme ve zararın giderilmesini isteme
haklarına sahipsiniz. Başvuru: taner.akdemir@algebransoft.com. **Hesabınızı kendiniz silebilirsiniz:**
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
