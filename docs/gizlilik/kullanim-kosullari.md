# Milk Trace — Kullanım Koşulları

> **HUKUKİ İNCELEMEDEN GEÇMELİ — TASLAK (09.10.2026).** Hukuki tavsiye değildir. Ürünün
> bugünkü işleyişinden (backend ADR 0066 deneme, 0072 elle askı, 0076/0132 hesap daveti,
> 0098 hesap silme, 0126 API anahtarı, 0130 abonelik, 0137 mandıra paylaşımı) ve sitedeki
> mesafeli satış, iade ve gizlilik metinleriyle tutarlı yazıldı. Site
> `https://milktrace.com.tr/kullanim-kosullari` adresinde yayımlar
> (`scripts/sync-legal.sh`); İngilizcesi `terms-of-use-en.md`. `>` blokları yayımlanmaz.
>
> **Yayından önce kapanacaklar:**
> 1. §9'daki `[SORUMLULUK ÜST SINIRI]` — sorumluluğun tutar/süre sınırı hukukçuyla
>    belirlenmeli (ör. "son 12 ayda ödenen abonelik bedeli"); karar verilmedi, uydurulmadı.
> 2. Abonelik sözleşmesi (mesafeli satış) ile bu metin çelişirse hangisinin öncelikli
>    olduğu §1'de mesafeli satış lehine yazıldı — doğrulanmalı.
> 3. Uygulama içinde ya da girişte bu koşulların onayı alınmıyor; onay mekanizması
>    gerekip gerekmediği hukukçuya sorulmalı.

**Son güncelleme:** 9 Ekim 2026

## 1. Kapsam

Bu koşullar, Algebran Soft (Taner Akdemir, şahıs işletmesi; Atakent Mah. 1472. Cad. Eda
Apt. No: 5 D: 3, Elvankent, Etimesgut / Ankara; Etimesgut Vergi Dairesi; info@milktrace.com.tr)
tarafından sunulan Milk Trace hizmetinin ("Hizmet") — mobil uygulama, web paneli
(milktrace.com.tr) ve API — kullanımını düzenler. Hizmeti kullanarak bu koşulları kabul
etmiş olursunuz.

Abonelik satın alımında ayrıca Mesafeli Satış Sözleşmesi, Ön Bilgilendirme Formu ve İade ve
Cayma Koşulları geçerlidir; abonelik konusunda bunlarla bu koşullar arasında fark varsa
onlar uygulanır. Kişisel verilerin işlenmesi Gizlilik Politikası ve KVKK Aydınlatma
Metni'nde anlatılır.

## 2. Hizmet

- Milk Trace, sağım noktalarına takılan sayaçlardan gelen ölçümlerle her hayvanın sütünü
  izleyen, internet üzerinden sunulan bir yazılım hizmetidir: canlı sağım ekranı, hayvan
  ve sağım geçmişi, uyarılar ve bildirimler, raporlar, sürü kayıtları.
- Hizmet işletmelere (çiftliklere) sunulur. "İşletme", Milk Trace'te adına hesap açılan
  çiftlik ya da kuruluştur.
- **Sayaçlar, kurulum ve donanım** bu koşulların konusu değildir; ayrıca anlaşılır.
- Ölçümler ve uyarılar sürü yönetimine yardımcı bilgilerdir. **Veteriner muayenesi, tanı ya
  da tedavi önerisi değildir**; hayvan sağlığına ilişkin kararlar işletmenin ve
  veterinerinin sorumluluğundadır.

## 3. Hesaplar ve roller

- Uygulamadan hesap oluşturulmaz. İşletmenin ilk hesabını Milk Trace açar; işletme sahibi
  kendi kullanıcılarını davet eder ve rollerini (sahip, operatör, izleyici) belirler.
  Sağımhane tableti için ayrı, yalnızca canlı ekranı açan hesap tanımlanabilir.
- İşletme sahibi, işletmeyi temsile yetkili olduğunu ve verdiği bilgilerin doğru olduğunu
  kabul eder; işletmedeki kullanıcıların kim olduğunu ve neyi görebileceğini kendisi
  yönetir.
- Parolanızı ve iki adımlı doğrulama kodlarınızı gizli tutmalısınız. Hesabınızdan yapılan
  işlemlerden siz, işletmenin kullanıcılarının işlemlerinden işletme sorumludur. Tanımadığınız
  bir oturum görürseniz "Oturumlar" ekranından kapatın ve parolanızı değiştirin.
- API anahtarları yalnızca işletme sahibince oluşturulur; anahtarı paylaşmak işletmenin
  verisini paylaşmaktır ve anahtarın korunmasından işletme sorumludur.

## 4. İşletmenin sorumlulukları

- Hizmete girilen kayıtların (hayvan, eşik, bildirim alıcısı, not) doğruluğundan işletme
  sorumludur.
- Bildirim kanallarına eklenen e-posta adreslerinin ve telefon numaralarının sahiplerini
  bilgilendirmek ve gerekli hâllerde onaylarını almak işletmenin sorumluluğundadır.
- Mandıra paylaşımını işletme sahibi kendi isteğiyle açar; paylaşılan çiftlik bazlı
  verinin kapsamı ve süresi onay ekranında gösterilir, paylaşım her an geri alınabilir.
- Hizmet hukuka aykırı amaçla, başkalarının haklarını ihlal edecek ya da Hizmetin
  işleyişini bozacak biçimde kullanılamaz (izinsiz erişim denemesi, aşırı yük oluşturma,
  güvenlik önlemlerini aşma gibi). Erişim üçüncü kişilere satılamaz ya da kiralanamaz.

## 5. Deneme, abonelik ve ücretler

- Her işletmeye ücretsiz deneme süresi tanınır; süre işletmenin açıldığı gün başlar ve
  Hizmette gösterilir. Denemede bütün özellikler açıktır.
- Deneme sonrasında kullanım, milktrace.com.tr üzerinden satın alınan abonelikle sürer.
  Fiyat, satın alma anında işletmede kayıtlı sağmal hayvan sayısına göre belirlenir; dönem,
  ödeme, iade ve cayma koşulları Mesafeli Satış Sözleşmesi ile İade ve Cayma Koşulları'ndadır.
  Abonelik kendiliğinden yenilenmez.
- İşletmenin seçtiği bazı bildirim kanalları (SMS, sesli arama, kendi e-posta sunucusu gibi)
  işletmenin kendi sağlayıcı hesabıyla çalışabilir; bu durumda sağlayıcının ücretleri
  işletmeye aittir.

## 6. Hizmetin sürekliliği

Hizmet makul özenle ve kesintisiz sunulmaya çalışılır; bakım ve güncellemeler mümkün
olduğunca sağım saatleri dışında yapılır. Planlı bakım ve öngörülemeyen kesintiler
olabilir. Sayaçların, internet bağlantısının ve çiftlikteki elektrik ya da donanımın arızası
Milk Trace'ten kaynaklanan sebep sayılmaz. Uygulama, bağlantı koptuğunda son görülen veriyi
gösterir; bu veri güncel olmayabilir. Uygulamanın eski sürümleri desteklenmeyebilir;
güncelleme gerektiğinde uygulama bunu söyler.

## 7. Veriler

- İşletmenin girdiği ve sayaçlardan gelen veriler işletmeye aittir. Milk Trace bu verileri
  yalnızca Hizmeti sunmak, güvenliği sağlamak ve hataları gidermek için, Gizlilik
  Politikası'na uygun olarak işler; satmaz.
- İşletme verisi düzenli yedeklenir. Sözleşme sona erdiğinde işletmenin verisi Gizlilik
  Politikası'ndaki süre (90 gün) sonunda silinir; bu sürede işletme sahibi bütün verisini
  Excel dosyası olarak isteyebilir.
- Hesabınızı uygulamadan (hesap kartı → "Hesabımı sil") ya da
  https://milktrace.com.tr/hesap-sil adresinden kendiniz silebilirsiniz. Bir işletmenin tek
  sahibiyseniz işletme sahipsiz kalmasın diye önce info@milktrace.com.tr adresine yazın.

## 8. Fikrî haklar

Milk Trace yazılımı, uygulaması, web sitesi, markası ve içerikleri Algebran Soft'a aittir.
Hizmet, bu koşullar süresince işletmenin kendi işi için kullanma hakkı verir; yazılımın
kopyalanması, kaynak kodunun çıkarılmaya çalışılması ya da Hizmetin taklit edilmesi
yasaktır.

## 9. Sorumluluğun sınırı

Milk Trace; sayaç, bağlantı ya da çiftlikteki donanım kaynaklı ölçüm hatalarından,
işletmenin girdiği verilerin doğruluğundan ve uyarılara dayanılarak ya da dayanılmadan
verilen hayvan sağlığı ve sürü yönetimi kararlarından sorumlu değildir. Mevzuatın izin
verdiği ölçüde Milk Trace'in sorumluluğu [SORUMLULUK ÜST SINIRI] ile sınırlıdır. Tüketici
olan kullanıcıların 6502 sayılı Kanun'dan doğan hakları saklıdır.

## 10. Askıya alma ve sona erme

- Bu koşulların ihlali, kötüye kullanım ya da ödeme yükümlülüğünün yerine getirilmemesi
  hâlinde işletme hesabı askıya alınabilir ya da kapatılabilir. Askıdaki işletmenin
  kullanıcıları giriş yapamaz; bu sürede sayaç verisi toplanmaya devam eder ve askı
  kalkınca işletmenin geçmişinde boşluk kalmaz.
- Abonelik dönemi bittiğinde yeni dönem alınmazsa Hizmet kısıtlanabilir; işletmenin verisi
  bu nedenle silinmez.
- İşletme dilediği zaman Hizmeti sonlandırmayı info@milktrace.com.tr adresinden talep
  edebilir.

## 11. Değişiklikler

Bu koşulları değiştirirsek güncel hâlini bu adreste yayımlar, önemli değişiklikleri uygulama
içinden ya da e-postayla duyururuz. Değişiklikten sonra Hizmeti kullanmaya devam etmek güncel
koşulları kabul etmek anlamına gelir.

## 12. Uygulanacak hukuk ve uyuşmazlıklar

Bu koşullara Türkiye Cumhuriyeti hukuku uygulanır. Kullanıcının tüketici olduğu işlemlerde
tüketici hakem heyetleri ve tüketici mahkemeleri, tüketici olmadığı işlemlerde Ankara
mahkemeleri ve icra daireleri yetkilidir.

## 13. İletişim

Sorularınız için: info@milktrace.com.tr.
