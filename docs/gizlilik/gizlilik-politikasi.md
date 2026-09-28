# Milk Trace — Gizlilik Politikası

> **TASLAK (28.09.2026).** Koddaki gerçek veri akışından çıkarıldı; yayımlamadan önce
> hukuki kontrolden geçmeli. `[DOLDUR]` işaretli yerler bilinmiyor. Play Console bu
> metnin herkese açık bir adresini ister (alan adı alınınca `https://<alan-adı>/gizlilik`).

**Son güncelleme:** [DOLDUR]

Milk Trace, süt hayvancılığı işletmelerinin sağım noktalarındaki sayaçlardan gelen
ölçümlerle her hayvanın ne kadar süt verdiğini izlemesini sağlayan bir hizmettir. Bu
politika, Milk Trace mobil uygulaması ve yönetim paneli üzerinden işlenen kişisel
verileri anlatır.

## 1. Hizmeti sunan

[DOLDUR: şirket unvanı], [DOLDUR: adres]. İletişim: [DOLDUR: e-posta].

Milk Trace işletmelere (çiftliklere) sunulur. Uygulamayı kullanan kişilerin hesaplarını
işletme adına platform yöneticisi açar; uygulama içinden hesap oluşturulmaz.

## 2. Hangi verileri işliyoruz

**Hesap bilgileri:** ad soyad, e-posta adresi, işletmedeki rol (sahip, operatör,
izleyici), hesap durumu. Parolanız yalnızca geri çevrilemez bir özet olarak saklanır.

**Oturum bilgileri:** giriş yaptığınız cihazın oturum jetonları ve bu oturumu açan
uygulamanın/tarayıcının kimlik bilgisi (user-agent). Oturum jetonları telefonunuzda
işletim sisteminin güvenli deposunda tutulur.

**Bildirim bilgileri:** bildirim alabilmeniz için telefonunuzun bildirim jetonu
(Firebase Cloud Messaging) ve platformu (Android/iOS). Çıkış yaptığınızda silinir.

**İşletme verileri:** işletmenin girdiği hayvan kayıtları (küpe numarası, adı, ırkı, doğum
ve buzağılama tarihleri, RFID), sağım ölçümleri, uyarılar ve hayvan notları. Notlarda
notu yazan kullanıcının adı görünür. Bu veriler hayvanlara ve işletmeye aittir; notlar ve
yazar bilgisi dışında kişisel veri içermez.

**Bildirim kanalı alıcıları:** işletme sahibinin uyarı almak için tanımladığı e-posta
adresleri ve telefon numaraları.

**Sunucu kayıtları:** güvenlik ve hata ayıklama için isteklerin zamanı, yolu, sonucu ve
istek yapan IP adresi.

**Toplamadıklarımız:** konum, rehber, fotoğraf, mikrofon; reklam kimliği; kullanım
analitiği ya da reklam amaçlı izleme. Uygulamada reklam yoktur.

## 3. Neden işliyoruz

- Hizmeti sunmak: giriş, canlı sağım ekranı, hayvan geçmişi, raporlar (sözleşmenin ifası).
- Sizi uyarmak: sayaç arızası, sağım özeti gibi bildirimler (sözleşmenin ifası).
- Güvenlik ve kötüye kullanımın önlenmesi, hata ayıklama (meşru menfaat).
- Faturalama: işletmenin kullandığı sayaç sayısı (sözleşmenin ifası). Kişisel veri içermez.

## 4. Kimlerle paylaşıyoruz

Verileri satmıyoruz. Hizmeti sunmak için yalnızca aşağıdaki hizmet sağlayıcılarla,
gerektiği kadar:

| Sağlayıcı | Ne için | Nerede |
|---|---|---|
| netcup GmbH | sunucu barındırma (tüm veriler) | Almanya |
| Google (Firebase Cloud Messaging) | bildirim iletimi (bildirim jetonu, bildirim metni) | ABD / AB |
| Twilio SendGrid | işletmenin seçtiği e-posta bildirimleri ve parola sıfırlama e-postası (e-posta adresi, ad) | ABD |
| NetGSM / İleti Merkezi | işletmenin seçtiği SMS bildirimleri | Türkiye |
| [DOLDUR: işletmenin seçtiği diğer kanallar — Slack, Teams, webhook, sesli arama] | bildirim | [DOLDUR] |

Aynı işletmenin kullanıcıları o işletmenin verilerini rollerine göre görür. Başka bir
işletme sizin işletmenizin verisini göremez.

## 5. Yurt dışına aktarım

Sunucular Almanya'dadır; bildirim ve e-posta sağlayıcılarının bir kısmı ABD'dedir. Bu
aktarımlar KVKK md. 9 kapsamında [DOLDUR: dayanak — açık rıza / standart sözleşme / taahhüt]
ile yapılır.

## 6. Ne kadar saklıyoruz

- Hesap ve işletme verileri: işletmenin hizmet sözleşmesi sürdükçe; sözleşme sona
  erdikten **90 gün** sonra kendiliğinden silinir (bu sürede işletme verilerini dışa
  aktarabilir). Faturalama için yalnızca işletmenin kullandığı sayaç-gün kayıtları,
  işletme adı anonimleştirilerek, vergi mevzuatının öngördüğü süre saklanır.
- Veritabanı yedekleri: 14 gün; silinen veri en geç 14 gün sonra yedeklerden de çıkar.
- Bildirim jetonu: çıkışta ya da jeton geçersizleşince silinir.
- Sunucu kayıtları (IP adresi dahil): **30 gün**.

## 7. Telefonunuzda tutulanlar

Oturum jetonu işletim sisteminin güvenli deposunda; çevrimdışı kullanım için son
görüntülenen veriler uygulamanın kendi deposunda. Çıkış yaptığınızda ikisi de silinir.

## 8. Haklarınız

KVKK md. 11 uyarınca verilerinizin işlenip işlenmediğini öğrenme, bilgi isteme,
düzeltilmesini ya da silinmesini isteme, itiraz etme ve zararın giderilmesini isteme
haklarına sahipsiniz. Başvuru: [DOLDUR: e-posta]. Hesabınızın silinmesini işletmenizin
yöneticisinden ya da bu adresten isteyebilirsiniz. Hesap silinince adınız, e-postanız,
oturumlarınız ve bildirim jetonunuz kalıcı olarak silinir; yazdığınız hayvan notları
işletmenin sürü kaydı olarak kalır ve yazarı "Silinmiş kullanıcı" görünür.

## 9. Çocuklar

Hizmet işletmelere yöneliktir; 18 yaşından küçüklere yönelik değildir.

## 10. Değişiklikler

Bu politikayı değiştirirsek güncel hâlini bu adreste yayımlar, önemli değişiklikleri
uygulama içinden duyururuz.
