# Milk Trace — Mesafeli Satış Sözleşmesi

> **TASLAK (01.10.2026)** — hukuki kontrolden geçmeli; hukuki tavsiye değildir. Abonelik
> ödemesi backend ADR 0130. Sürüm, backend'deki `billing.TermsVersion` ile AYNI tutulur:
> metin değişince ikisi birlikte değişir ve eski sürümü onaylamış ödeme isteği reddedilir.
> Site bu dosyayı `/mesafeli-satis-sozlesmesi` adresinde yayımlar (sync-legal'e eklenmeli).
> `[DOLDUR]` yerleri ve aşağıdaki açık sorular yayımdan önce kapanmalı. `>` blokları
> yayımlanmaz.
>
> **Hukukçu için açık sorular:**
> 1. Alıcıların çoğu çiftliğini ticari/mesleki amaçla işleten üreticidir; 6502 sayılı
>    Kanun'un "tüketici" tanımına girmeyebilirler. Metin her iki durumu da karşılayacak
>    biçimde yazıldı (§10, §11). Yeterli mi?
> 2. Cayma hakkı istisnası Mesafeli Sözleşmeler Yönetmeliği m.15/1-(ğ)'ye (elektronik
>    ortamda anında ifa edilen hizmet) dayandırıldı; Alıcı'nın onayı ödeme sırasında ayrıca
>    alınır ve kaydedilir. Spitfire'daki yaklaşımla aynı. Yeterli mi?
> 3. Satıcı şahıs işletmesi; vergi kimlik numarası bilinçli olarak yazılmadı (zorunlu
>    değil, T.C. kimlik numarasıyla aynı); MERSİS yok.

**Sürüm:** 2026-10-01.1

## 1. Taraflar

**SATICI**
- Unvan: Algebran Soft — Taner Akdemir (şahıs işletmesi)
- Adres: Atakent Mah. 1472. Cad. Eda Apt. No: 5 D: 3, Elvankent, Etimesgut / Ankara
- Vergi dairesi: Etimesgut Vergi Dairesi
- E-posta: taner.akdemir@algebransoft.com
- Telefon: +90 530 320 06 47

**ALICI:** ödeme sayfasında fatura bilgisi olarak girilen kişi ya da kuruluş (ad soyad veya
unvan, T.C. kimlik / vergi kimlik numarası, vergi dairesi, adres, e-posta, telefon) ve
Milk Trace'te adına satın alma yapılan işletme. Satın almayı işletme sahibi yetkisine sahip
kullanıcı yapar.

## 2. Konu

Bu sözleşme, Alıcı'nın milktrace.com.tr üzerinden elektronik ortamda satın aldığı Milk Trace
aboneliğinin (hizmet dönemi) satışı ve ifasına ilişkin tarafların hak ve yükümlülüklerini,
6502 sayılı Tüketicinin Korunması Hakkında Kanun ve Mesafeli Sözleşmeler Yönetmeliği'ne
uygun olarak düzenler.

## 3. Hizmet

- **Milk Trace**, sağım noktalarındaki sayaçlardan gelen ölçümlerle her hayvanın sütünü
  izleyen, internet üzerinden sunulan bir yazılım hizmetidir (mobil uygulama ve web paneli).
- Abonelik, Alıcı'nın işletmesinin Milk Trace'i seçilen dönem boyunca kullanma hakkıdır:
  **1 ay** ya da **1 yıl**.
- Fiyat kademesi, satın alma anında işletmede kayıtlı **sağmal** hayvan sayısına göre
  belirlenir (ör. 1–20, 21–100, 100'den fazla). Dönem içinde sağmal sayısı değişirse ödenmiş
  dönemin fiyatı değişmez; yeni kademe bir sonraki satın almada uygulanır.
- Sayaçlar, kurulum ve donanım bu sözleşmenin konusu değildir; ayrıca anlaşılır.
- Ödeme tek seferliktir. Abonelik **kendiliğinden yenilenmez**, karttan tekrar ücret
  çekilmez; dönem bitmeden e-posta ve bildirimle hatırlatılır.

## 4. Fiyat ve ödeme

Fiyat, KDV hariç tutar, KDV (%20) ve KDV dahil toplam olarak ödeme sayfasında ayrı ayrı
gösterilir ve Alıcı'nın onayladığı tutar çekilir. Ödeme sayfası açıldıktan sonra fiyat
listesi ya da sağmal hayvan sayısı değişirse ödeme başlatılmaz; Alıcı güncel tutarı görüp
yeniden onaylar.

Ödeme, lisanslı ödeme kuruluşu **PayTR Ödeme ve Elektronik Para Kuruluşu A.Ş.**'nin güvenli
ödeme sayfasında kredi ya da banka kartıyla yapılır. Kart bilgileri Satıcı'ya ulaşmaz ve
Satıcı tarafından saklanmaz. Taksitli ödemede bankanın uyguladığı vade farkı Alıcı ile
bankası arasındadır.

Fatura (e-Fatura ya da e-Arşiv), ödemeden sonra Alıcı'nın bildirdiği bilgilerle elektronik
ortamda düzenlenip e-posta adresine gönderilir. Ödeme onay e-postası fatura yerine geçmez.

## 5. İfa (hizmetin başlaması)

- Dönem, ödemenin onaylandığı gün başlar. Ödeme anında süren bir dönem ya da deneme süresi
  varsa yeni dönem onun bitiminden itibaren başlar; kalan günler kaybolmaz.
- Dönemin başlangıç ve son günü ödeme onayı e-postasında ve Milk Trace'te gösterilir.
- Hizmet internet üzerinden sunulur; fiziksel teslimat yoktur.
- Dönem bittiğinde yeni dönem alınmazsa Satıcı hizmeti kısıtlayabilir; işletmenin verileri
  bu nedenle silinmez (silme yalnızca sözleşme sona erip Gizlilik Politikası'ndaki süre
  dolunca).

## 6. Cayma hakkı

Hizmet elektronik ortamda anında ifa edilen bir hizmettir. Alıcı, ödeme sırasında
hizmetin dönemin başladığı gün ifasına başlanmasını ve bu nedenle cayma hakkının o gün sona
ereceğini **ayrıca onaylamıştır** (Mesafeli Sözleşmeler Yönetmeliği m.15/1-(ğ)). Satın
almadan önce hizmet ücretsiz deneme süresi boyunca bütün özellikleriyle denenebilir.

Buna karşın:
- **Henüz başlamamış dönem** (süren dönemin ya da denemenin ardına eklenmiş dönem):
  başlangıç gününden önce taner.akdemir@algebransoft.com adresine bildirilirse ödenen
  tutarın tamamı iade edilir.
- Hizmet Satıcı'dan kaynaklanan bir sebeple dönemin önemli bir kısmında kullanılamazsa,
  sorun giderilemediğinde kullanılamayan günlere düşen tutar iade edilir ya da dönem o kadar
  uzatılır.

İade, ödemenin alındığı karta PayTR aracılığıyla, bildirimden itibaren en geç 14 gün içinde
yapılır. İade edilen dönem hizmet süresinden düşülür.

## 7. Hizmetin kesintisi ve ayıplı ifa

Satıcı hizmeti makul özenle kesintisiz sunmaya çalışır; bakım ve güncellemeler mümkün
olduğunca sağım saatleri dışında yapılır. Hizmet Satıcı'dan kaynaklanan bir sebeple dönemin
önemli bir kısmında kullanılamazsa Alıcı durumu bildirir; Satıcı sorunu giderir, gideremezse
kullanılamayan güne düşen tutarı iade eder ya da dönemi o kadar uzatır. Sayaçların, internet
bağlantısının ve çiftlikteki elektrik/donanımın arızası Satıcı'dan kaynaklanan sebep
sayılmaz. Alıcı'nın 6502 sayılı Kanun'dan doğan diğer hakları saklıdır.

## 8. Alıcı'nın yükümlülükleri

Alıcı, hesap bilgilerini korur, işletmesindeki kullanıcıları ve rollerini kendisi yönetir,
hizmeti hukuka aykırı amaçla kullanmaz. Hizmet, Alıcı'nın işletmesi için kullanılır; erişim
üçüncü kişilere satılamaz ya da kiralanamaz.

## 9. Kişisel veriler

Alıcı'nın ve işletme kullanıcılarının kişisel verileri, milktrace.com.tr/kvkk adresindeki
Aydınlatma Metni ve milktrace.com.tr/gizlilik adresindeki Gizlilik Politikası'na uygun
olarak işlenir. Ödeme sırasında girilen fatura bilgileri fatura düzenlemek ve vergi
mevzuatının saklama yükümlülüğü için işlenir.

## 10. Uyuşmazlıklar

Alıcı'nın tüketici olduğu işlemlerde, Ticaret Bakanlığı'nca her yıl ilan edilen parasal
sınırlar içinde Alıcı'nın yerleşim yerindeki ya da işlemin yapıldığı yerdeki tüketici hakem
heyetleri, bu sınırların üzerinde tüketici mahkemeleri yetkilidir; tüketici mahkemesinde
dava açmadan önce 6502 sayılı Kanun'un 73/A maddesi uyarınca arabulucuya başvurulması
zorunludur. Alıcı'nın tüketici olmadığı işlemlerde Ankara mahkemeleri ve icra daireleri
yetkilidir.

## 11. Yürürlük

Bu sözleşme, Alıcı'nın ödeme sırasında elektronik ortamda onay vermesiyle kurulur. Onaylanan
sürüm, onay anı ve sipariş bilgileri kaydedilir; ödeme onayı e-postası sipariş özetini ve bu
sözleşmenin, ön bilgilendirme formunun ve iade koşullarının bağlantılarını içerir.
