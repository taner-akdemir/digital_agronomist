# Milk Trace — Mobil Uygulama Kılavuzu

Milk Trace, sağım noktalarına takılan IoT debimetrelerle **her hayvanın ayrı ayrı ne kadar süt
verdiğini** ölçen çok kiracılı bir SaaS'tır. Bu repo **üretici/işletme kullanıcısının** Flutter
uygulamasıdır.

> **Ürün ve mimari kararların tamamı `~/GolandProjects/milktrace/MILKTRACE.md` dosyasındadır.**
> O dosya kanoniktir; bu repoda kopyası TUTULMAZ (ayrışır). Bölüm numaraları sabittir; koda
> `§6.2` biçiminde atıf yapılır.
>
> Aşağıdaki özet, günlük iş için yeterli olan kısmıdır. Çelişirse MILKTRACE.md kazanır.

---

## 1. Sözlük (§4)

Kodda İngilizce, arayüzde Türkçe.

| Kod | UI | Nedir |
|---|---|---|
| `Tenant` | İşletme | SaaS müşterisi. Tüm veri buna bağlı. |
| `Farm` | Tesis | İşletmenin fiziksel tesisi. |
| `Hall` | Sağım Bölgesi | Tesis içindeki sağım alanı (A, B, C…). |
| `Vacuum` | Sağım Ünitesi | Bir vakum hattı; üzerinde N sağım noktası. |
| `Spout` | Sağım Noktası | Tek hayvana bağlanan başlık grubu. **Cihaz buraya takılır.** |
| `Device` | Sayaç | Spout'a takılı IoT debimetre; seri no ile tanımlı. |
| `Animal` | Hayvan | Küpe numarası (`earTag`) ile tanımlı birey. |
| `Species` | Tür | İnek, keçi, koyun. **Eşikler tür bazındadır.** |
| `MilkingSession` | Sağım Oturumu | Bir bölgede başlatılan toplu sağım. |
| `AnimalMilking` | Hayvan Sağımı | Bir hayvanın bir oturumdaki tekil sağımı. |
| flow rate | Debi | L/dk, anlık. |
| yield | Verim | L, oturum/gün toplamı. |

**Dikkat:** `Animal.name` hayvanın ADIdır ("Sarıkız"), türü değil. Tür `speciesId` ile gelir.

---

## 2. Renk kuralları (§6.2, §6.3)

Dört renk vardır: `green`, `yellow`, `red`, `grey`. **Sarı bandı unutma** — ilk prototipte yoktu.

**Anlık debi** önceliği (sırası önemli):
1. Başlık takılı değil / hayvan eşleştirilmemiş / akış yok → **gri**
2. Debi ≥ `flowHigh` → yeşil; ≥ `flowLow` → sarı; altı → kırmızı
3. **Isınma:** sağımın ilk `rampUpSec` saniyesinde kırmızı **sarıya bastırılır**
4. **Bitiş fazı:** hacim beklenenin %85'ini geçtiyse kırmızı **sarıya bastırılır**

3 ve 4 olmadan her sağım kırmızı başlar, kırmızı biter.

**Oturum verimi:** `volumeMl / expectedMl` → ≥%90 yeşil, ≥%60 sarı, altı kırmızı.
`expectedMl == 0` ise **gri** (%0 kırmızısı yanlış alarm olurdu).

**Renk kimin?** Backend'indir. `spout.update` payload'ı `flowColor` ve `yieldColor` taşır ve
uygulama onu **kullanır**. `lib/domain/thresholds.dart` yalnızca mock modda ve kareler arası
ara değer için çalışan bir AYNAdır. İki taraf `test/fixtures/color_cases.json` ile kilitlidir —
bu dosya `~/GolandProjects/milktrace/common/milkrules/testdata/color_cases.json`'ın
**bayt-birebir kopyasıdır**, elle düzenlenmez.

---

## 3. API sözleşmesi (§8.5)

Taban `/api/v1`. Hata formatı: `{"error": {"code": "SESSION_NOT_FOUND", "message": "..."}}` —
mesajlar Türkçe, kullanıcıya doğrudan gösterilebilir.

```
POST /auth/login · /auth/refresh · /auth/logout
GET  /me
GET  /farms · /halls · /vacuums · /spouts
GET  /animals · /animals/{id} · /animals/{id}/history · /animals/{id}/trend
GET  /species/thresholds
POST /sessions                                 sağım başlat {hallId, type}
GET  /sessions/{id}/live                       ilk yükleme (sonrası WS)
PUT  /sessions/{id}/spouts/{spoutId}/animal    nokta-hayvan eşleştirme
POST /sessions/{id}/end
GET  /dashboard · /alerts · POST /alerts/{id}/ack
WS   /ws?sessionId=
```

WebSocket `spout.update` payload'ı — **mock JSON'lar da bu şekle birebir uyar**:

```json
{
  "type": "spout.update",
  "sessionId": "...", "spoutId": "...",
  "animal": {"id": "...", "earTag": "TR340001234", "species": "cow", "name": "Sarıkız"},
  "flowRate": 1.62, "volumeMl": 8400, "expectedMl": 11000, "yieldPct": 76.4,
  "flowColor": "yellow", "yieldColor": "yellow",
  "state": "milking", "ts": "2026-09-21T06:12:04Z"
}
```

**Birimler:** hacim her zaman **tamsayı mL**, debi **double L/dk**. Zaman UTC gelir,
`Europe/Istanbul` gösterilir. Id'ler string (UUID).

---

## 4. Mimari kararlar (§15.2)

| Konu | Karar |
|---|---|
| State | Riverpod 3, `@riverpod` codegen Notifier'lar |
| Ağ | `dio` (interceptor ile token yenileme) |
| Canlı veri | Hedef: `web_socket_channel` + yeniden bağlanma. Bugün: 5 sn yoklama (§6). İlk yükleme `GET /sessions/{id}/live` |
| Depolama | Token → `flutter_secure_storage`; basit ayarlar ve çevrimdışı önbellek → `shared_preferences` |
| Model | `freezed` + `json_serializable`. Elle `fromJson` YAZILMAZ. |
| Navigasyon | `go_router` + `StatefulShellRoute` (4 sekme) |
| Veri katmanı | `MilkTraceRepository` arayüzü + `MockRepository` / `ApiRepository` |

**Mock ↔ gerçek geçişi:** `--dart-define=MT_API=http` (varsayılan) veya `mock`. Mock
asset'leri gerçek API'nin şekliyle birebir aynıdır; geçiş bir bayrak değişimidir, yeniden
yazım değil. Mock, backend ayakta değilken ve testlerde kullanılır.

---

## 5. Çalışma kuralları

```
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # model/provider değiştiyse
flutter analyze        # SIFIR uyarı hedefi — her commit'te
flutter test
flutter run
```

- **Üretilen dosyalar (`*.g.dart`, `*.freezed.dart`) commit edilir** — repo codegen adımı
  olmadan derlenebilmeli.
- Model veya provider'a dokundun mu `build_runner` koş.
- Commit: Conventional Commits (`feat(live): ...`, `fix(models): ...`).
- Tasarım dili korunur: açık arka plan, yeşil/koyu yeşil palet, Poppins, kart tabanlı görünüm.
  Renk/boşluk/köşe değerleri `lib/app/theme/` içindeki token'lardan gelir, çağrı yerinde
  sabit yazılmaz.

- **Marka/ikon:** kaynaklar `tool/brand/*.svg` (koyu yeşil zemin, beyaz süt damlası, içinde
  debi çizgisi). İkonları elle düzenleme; `tool/brand/generate.sh` Android (uyarlanabilir +
  monokrom), iOS AppIcon ve bildirim simgesini (`drawable-*/ic_stat_milktrace`, tek renk
  siluet) üretir; ayrıca üst çubuk ve giriş ekranındaki işareti (`assets/brand/mark.png`,
  açık zeminde koyu yeşil damla). Çıktı deterministik: kaynak değişmedikçe PNG'ler
  değişmez. Uygulama adı "Milk Trace".

## 6. Kapsam çiti

Şu anki faz: **Faz 6 — cihaz** (§17). Faz 4 ve Faz 5'in mobil payı tamam; Faz 6'nın
kalemleri (üretici görüşmesi, edge gateway donanımı, `collector-http`, saha pilotu)
backend reposunda ve sahada — bu repoya düşen yeni bir ekran yok.

Uygulama **varsayılan olarak gerçek API'ye** bağlanır (`MT_API=http`). Giriş, oturum
yenileme, oturumu geri yükleme ve çıkış çalışır; bölge/ünite/nokta/cihaz/hayvan verisi
gateway'den gelir. Canlı sağım da artık gerçek uçlardan okunur: açık oturum
`GET /sessions` listesinden seçilir, ilk yükleme `GET /sessions/{id}/live`'dan gelir.
`ApiWithMockLiveRepository` köprüsü **silindi**; mock yalnızca `MT_API=mock` modunda çalışır.

**Canlı akış artık WebSocket'tir** (§8.5 `WS /ws?sessionId=`). Backend'in `realtime`
servisi yazıldı; yoklama (polling) kaldırıldı. Yoklama en iyi ihtimalle 5 saniyelik
gecikme demekti ve sağımın ilk saniyeleri (§6.2 ısınma fazı) o pencerede kaçıyordu.

`ApiRepository.watchSession` kendi kendini onarır:

- Her bağlanışta **önce anlık görüntü** (`GET /sessions/{id}/live`) yayınlanır. Yalnızca
  soketi dinleseydik, sağımın ortasında açılan ekran ilk güncelleme gelene kadar boş
  kalırdı; yeniden bağlanmada da kopukluk boyunca değişenler kapanır. Kaçırılan kareleri
  kurtarmaya çalışmıyoruz — canlı veride en son değer geçerli olandır ve backend de
  düşürdüğü istemciden tam olarak bunu bekliyor.
- Bağlantı koparsa 3 sn sonra yeniden bağlanır; ağ hatası akışı bitirmez.
- `session.ended` mesajı akışı bitirir. Bu duyuru olmadan telefon sessiz ama açık bir
  bağlantıda kalır ve son kareyi sonsuza dek gösterirdi — yoklama döneminde bu her turda
  `status` alanına bakılarak anlaşılıyordu.
- Tanınmayan mesaj tipi **yok sayılır**, akışı düşürmez: backend ileride başka tipler
  yayınlayabilir ve eski bir uygulama sürümü onlar yüzünden canlı ekranı kaybetmemeli.
- Token `Authorization` **başlığında** gider, sorgu dizesinde değil: sorgu dizesi sunucu
  loglarına ve proxy geçmişine düşer. El sıkışma sıradan bir HTTP GET olduğu için gateway
  JWT'yi diğer uçlarla birebir aynı doğrular.

**Tanınmayan küpe** (`SpoutUpdate.unmatchedTag`, backend ADR 0052): cihazın okuduğu küpe
kayıtlı değilse ya da hayvan sağmal değilse karede `{rfid, reason, message, at}` gelir.
Kart amber "Tanınmayan küpe" ve mesajı gösterir; hayvan varken mesaj küpe satırının YERİNE
geçer (kart yüksekliği sabit, testle kilitli). Seçici başta okunan küpeyi ve ne yapılacağını
yazar. Yeni sağım açılınca backend siler; `reason` string'dir, mesaj olduğu gibi gösterilir.

**Tanınmayan küpe listesi** (`/animals/unmatched-tags`, backend ADR 0056): Geçmiş → Hayvanlar'da
işletme sahibine "N tanınmayan küpe" bandı (boşken yok). Küpe "Hayvana ata" ile mevcut
`saveAnimal` (tam kayıt PUT) üzerinden hayvana yazılır — ayrı uç yok; atanınca backend
listeden düşürür. "Yok say" → `DELETE /unmatched-tags/{rfid}`. Otomatik öğrenme YOK.

**Eşleştirme seçicisi** (`showAnimalPicker` → `PickAnimal` / `ClearAnimal`, backend ADR 0053):
noktada hayvan varken "Eşleştirmeyi kaldır" (`DELETE …/spouts/{spoutId}/animal`) — açık sağım
SİLİNİR, ölçülen süt kimseye yazılmaz; onay penceresi miktarı söyler. Karışık sürüde tür
süzgeci çıkar; varsayılan, oturumdaki eşleşmelerin hepsi aynı türdense o tür. Arama küpe,
ad ve RFID'de. Noktada hayvan varken başka hayvan seçilir ve ölçüm varsa `askReplace` sorar:
"Sağıldı" → yalnızca bağla (backend öncekini kapatır, süt ona); "Yanlış eşleştirme" →
`MilkingControl.replace(discardPrevious: true)`: önce kaldır, sonra bağla. Ölçüm yoksa sormadan
temizler.

**Çevrimdışı** (§18/7, backend ADR 0061): `CachingRepository` ApiRepository'yi sarar. Okuma
cevapları cihaza yazılır (`mtcache:v1:<işletme>:<kullanıcı>:`), sunucuya ULAŞILAMAZSA son
cevap döner ve `OfflineBanner` "Çevrimdışı · son veri HH:mm" der; sunucu hatası (4xx/5xx)
önbellekle ÖRTÜLMEZ. Yazmalar çevrimdışıyken hata verir, kuyruk YOK (ürün kararı). Çıkışta
önbellek silinir. Yeni bir okuma ucu eklersen `CachingRepository`'de `_read` ile sarmayı unutma.

`Env.wsBaseUrl`, `apiBaseUrl`'den **türetilir** (`http` → `ws`): ayrı tanımlansaydı biri
değişip diğeri unutulduğunda canlı ekran sessizce bağlanamazdı.

**Geçmiş sekmesi tamamdır** (§15.1): oturum listesi, tür/sınıf filtreli hayvan listesi ve
hayvan detayı — sınıf rozeti (§6.4), 7/30 gün ortalaması, 30 günlük eğilim, 90 günlük verim
grafiği (fl_chart) ve son sağımlar. Uçlar `GET /sessions`, `/animals/{id}/history`,
`/animals/{id}/trend`.

**Hayvan durumu** (`Animal.isMilking`, backend ADR 0049): yalnızca sağmal (`active`) hayvan
eşleştirme listesine çıkar ve panodan açılan sınıf süzgecine girer; sağmal olmayanın
sınıf rozeti yerine durumu ("Kuruda", "Satıldı") görünür ve listenin en altında durur.
Backend de kurudaki/satılmış hayvanın eşleştirmesini reddeder.
Sağmal olmayanın sınıfı **donar** (`Animal.yieldClassAt`, backend ADR 0055): detayda rozet
yerine durum, altta "Son sınıf: … (tarih)"; güncel açıklama ve veteriner uyarısı gizli.
Sağmal hayvanın sınıfı iki günden eskiyse tarih ve sebebi yazılır.

**RFID isteğe bağlı** (backend ADR 0062): okuyucusuz çiftlikte elle eşleştirme ana yoldur.
Seçici bölgenin son BİTMİŞ oturumunun yerleşimini (`GET /sessions/{id}/milkings`,
`previousSpoutsProvider`) okur: önce önceki sağımda bu noktadaki hayvan ("önceki sağımda bu
noktadaydı"), sonra önceki sağımda sağılanlar, sonra kalanlar; başka noktaya bağlı olan en
altta. Okunamazsa öneri sessizce düşer, liste küpe sırasıyla gelir — öneri engel olmamalı.

**Hayvan ekleme/düzenleme** (`/animals/new`, `/animals/:id/edit`; kabuğun dışında tam
ekran form): küpe (zorunlu, işletmede tekil), tür, ad, ırk, RFID, doğum ve son buzağılama
tarihi (gelecek seçilemez), laktasyon sırası, durum. Giriş Geçmiş → Hayvanlar'daki "Hayvan
ekle" ve hayvan detayındaki düzenle simgesi; ikisi de YALNIZCA işletme sahibine (backend de
403). `PUT /animals/{id}` TAM kayıttır — form her zaman bütün alanları gönderir, boş alan
silinir. Verim sınıfı GÖNDERİLMEZ (gece hesabının alanı). Tarihler gün olarak, UTC gece
yarısı.

**Toplu içe aktarma** (`/animals/import`, backend ADR 0063): Geçmiş → Hayvanlar'da işletme
sahibine "Listeden". Dosya (CSV/.xlsx) `file_picker` ile seçilir ve OLDUĞU GİBİ gönderilir —
okuyan backend (Türkçe sütunlar, gün önde tarih, Windows-1254); uygulamada ikinci okuyucu
yazma. Önce `dryRun` önizleme (eklenecek/kayıtlı/hatalı, alınmayan sütunlar), sonra onay.
Kayıtlı küpe güncellenmez. Mock modda yok (501). Seçici `importFilePickerProvider`; testte
sahtesi konur.

**Verim raporu** (`yieldReport`, `GET /reports/yield`, backend ADR 0064): Geçmiş → Hayvanlar'da
BÜTÜN rollere "Rapor" (okuru veteriner). Son 7/30/90 gün; .xlsx backend'de üretilir, uygulama
bayt olarak indirip `share_plus` ile paylaşır (`reportSharerProvider`, testte sahtesi).
Önbelleklenmez. Mock modda yok (501).

**Laktasyon günü** (`Animal.daysInMilk`, backend ADR 0051): son buzağılamadan bu yana takvim
günü; detayda sağmal hayvanda görünür. İlk N gün (türün `Thresholds.freshLactationDays`,
varsayılan 30; ADR 0059) backend "düşüşte" ve "kuruya çıkarma adayı" vermez; kart bunu
türün süresiyle açıklar. Süre eşik ekranında ayarlanır. `test/fixtures/color_cases.json`'daki yeni `classifyCases`
(daysInMilk) backend'den kopyalandı; mobil onları okumuyor.

**Hayvan notları** (`GET/POST /animals/{id}/notes`, backend ADR 0050): detayda kimlik
kartının hemen altında "Notlar" kartı; en yeni 5 not yazarı ve anıyla. BÜTÜN roller yazar
(görüntüleyici = veteriner/danışman); notlar düzenlenmez, silinmez. Durum değişince backend
aynı işlemde "Durum: Sağmal → Kuruda" notunu kendisi düşer (`AnimalNote.kind == 'status'`,
ADR 0057); detay onu simgeyle ayırır, form kaydedince notlar tazelenir.

**Buzağılama** (`recordCalving`, `POST /animals/{id}/calving`, backend ADR 0060): detayda işletme
sahibine "Buzağıladı" düğmesi; tarih seçilir, onaylanır ve TEK istekte tarih, laktasyon +1,
durum sağmal ve `calving` notu yazılır. Aynı tarih 409. Tarih yalnızca GÜN olarak gider.

Mock modda geçmiş **asset değil, üretilmiştir**: `MockLactation` §10'daki Wood laktasyon
eğrisiyle deterministik seri üretir. 30 hayvan × 90 gün × 2 sağım elle tutulabilecek bir
JSON değil. Bugünkü seviye hayvanın SINIFINA sabitlenir ki rozet ile grafik çelişmesin.

Grafik, §6.2 durum renklerini (yeşil/sarı/kırmızı) seri rengi olarak KULLANMAZ; o renkler
"düşük debi", "izlenmeli" gibi sabit anlamlar taşır. Ana seri koyu yeşil, bağlam serisi
nötr gridir (`AppColors.chartPrimary` / `chartContext`).

**Bildirim merkezi tamamdır:** üst çubuktaki zil açık uyarı sayısını rozetler ve sekme
kabuğunun dışında `/alerts` ekranını açar; `GET /alerts` ve `POST /alerts/{id}/ack`. Açık
uyarılar üstte, okunmuşlar soluk ama SİLİNMEZ. Uyarı metni backend'den geldiği gibi
gösterilir (§16) — uygulama kendi metnini uydurmaz. `type` ve `severity` **string'dir**,
enum değil: §8.4 bu sütunların alacağı değerleri saymıyor ve kapalı bir enum, backend yeni
bir tür eklediğinde listeyi komple düşürürdü.

**Dashboard tamamdır:** günün toplamı (kaç sağım, kaç hayvan), tür bazında dağılım, §6.4
sınıf dağılımı ve açık uyarı özeti; `GET /dashboard`. Sınıf satırına basmak Geçmiş sekmesini
o sınıfa filtreler — bu yüzden `animalFilterStateProvider` **keepAlive**'dır: autoDispose
ile, filtre Geçmiş ekranı kurulmadan önce siliniyordu.

Sayaç uyarısı (`device_offline`) **çözülebilir**: `resolvedAt` doluysa sayaç geri
gelmiştir (backend ADR 0041). Çözüldü ile okundu AYRI alanlardır — çözülen uyarı listede
açık kalır, zaman satırında "geri geldi HH:mm" yazar; okununca kapanır. Sayaç hatası
(`device_error`) da çözülür: 5 dk hatasız veriden sonra "düzeldi HH:mm" (ADR 0058;
`alertTimeLabel`).

Özet ile uyarı LİSTESİ ayrı uçlardan okunur. Uyarıları dashboard payload'ına da koymak,
kullanıcı bir uyarıyı okundu işaretledikten sonra dashboard'un eski kopyayı göstermesi
demekti.

**Cihazlar sekmesi tamamdır:** bölge → ünite → nokta ağacı, sayaçların çevrimiçi/çevrimdışı
durumu ve sayaç ayrıntısı (yazılım sürümü, kalibrasyon katsayısı, son görülme, simülatör
işareti). Sorunu olan ünite açık, sorunsuz olan kapalı gelir — 30 noktayı birden açmak,
ilgilenilmesi gereken iki satırı kaydırma içinde kaybederdi.

Dört durum ayrı ayrı çizilir: çevrimiçi, çevrimdışı, **sayaç takılı olmayan nokta** ve
**noktaya takılı olmayan sayaç** (dolapta bekleyen yedek — arıza değil). Durum yalnızca
renge bırakılmaz, sorunlu satırda etiket yazıyla da durur.

**Son hata** (`Device.lastError`, backend ADR 0044): sayacın bildirdiği son hata kodu,
profilin tablosundan açıklaması ve anı; sağım sırasında olsun olmasın. Detay sayfasında
"Son hata" satırı. Son 24 saatte hata bildiren çevrimiçi sayaç SARI "Hata bildirdi"
olur, satırda "Hata E17 · 3 dk" yazar ve ünitesi açık gelir; daha eski hata yalnızca
detayda durur — sayaç hatanın geçtiğini bildirmiyor.

Burada çevrimdışı **kırmızıdır**, §6.2'deki gri DEĞİL: §6.2 canlı tabloda AKIŞIN olmamasını
anlatıyor, bu ekran cihazın kendisini. Çevrimdışı sayaç müdahale gerektirir.

**Push bildirimleri ANDROID'DE AÇIK** (Firebase projesi `milktrace-69975`, 25.09.2026):
emülatörde test bildirimi, gerçek sayaç uyarısı ve "geri geldi"nin aynı bildirimin yerine
geçmesi denendi. iOS'ta Xcode tarafı hazır; APNs anahtarı ve imza bekliyor (§7). Firebase açılamazsa uygulama
bunu hata saymaz — `FirebasePushGateway` log atıp `null` döner, `PushRegistration`
`unavailable` kalır ve sağım push'suz sürer.

Böylece dört sekmenin dördü de gerçek: **iskelet ekran kalmadı**, `StubScreen` silindi.

### Faz 5'in mobil payı (§17)

Faz 5'in kalemleri neredeyse tamamen başka repolarda: `collector-modbus`, edge gateway,
RLS, Helm, Grafana → `~/GolandProjects/milktrace`; React admin (karantina + profil
editörü) → `~/WebstormProjects/milktrace-web` (ADR 0014). Bu repoya düşen tek şey
**demo çıktısı**: "aynı canlı ekranda native MQTT + üretici MQTT + Modbus sayaçları".

Bunun için `Device.profile` eklendi (§8.4 `devices.profile_id`): üretici, model, protokol,
sürüm. Cihazlar ekranı karışık kaynaklı tesiste "Kaynaklar" satırını gösteriyor ve her
satıra protokolü yazıyor; profil ayrıntısı sayaç sayfasında.

**Profil `GET /devices` cevabına GÖMÜLÜ gelir** (backend `1a96c8b`). Önceden yalnızca
`profileId` geliyordu ve "Kaynaklar" satırı gerçek API'de hiç görünmüyordu — mock modda
göründüğü için fark edilmedi. Kiracının profilleri ayrıca okuyabileceği bir uç YOK
(`/admin/profiles` platform yöneticisinin); profili ayrı çekmeye çalışma.

**Protokol kodları backend'in yazdıklarıdır:** `mqtt`, `modbus` (referans Modbus profili;
register haritası RTU/TCP'de aynı, taşıma türü `devices.conn`'da), `http` (webhook,
backend ADR 0023). `modbus-rtu`/`modbus-tcp` profil editöründen gelebilir. Mock asset'leri
de AYNI kodları kullanmalı: mock'ta `modbus-tcp` kaldığı için ham "modbus" etiketi gerçek
API'de görünüp mock'ta gizli kalmıştı.

**§16/1 korunur:** marka/model adı koda GÖMÜLMEZ. `vendor` ve `model` birer veridir;
uygulamada `if (vendor == '...')` yazan tek satır yok. Eşleme yalnızca PROTOKOL kodu
üzerinedir (`protocolLabel`) ve tanınmayan kod olduğu gibi gösterilir.

Kaynaklar **profile göre** gruplanır, protokole göre değil: native MQTT ile üretici MQTT
aynı protokolü konuşuyor ve protokole göre sayılsaydı demonun asıl noktası olan üretici
ayrımı kaybolurdu.

Canlı ekran protokolden habersizdir ve öyle kalmalı: veri `collector-*` katmanında
kanonik hâle geliyor (§9.0), ekran L/dk ve mL görüyor.

### Eşik ayarları ve profil

§15.1'in "Diğer" satırındaki son iki ekran da yazıldı.

**Eşik ayarları** (`/settings/thresholds`, hesap kartından açılır): tür bazında debi
bantları, verim bantları, yanlış alarm koruması, sağım kapanışı ve sınıflandırma eşikleri.
Bunlar renk motorunun TÜM girdileri; şimdiye kadar sabit gelip hiçbir yerden
değiştirilemiyorlardı. `GET /species/thresholds` · `PUT` (§8.5).

- **§6.5'in kalibrasyon notu ekranda durur** — doküman bunu açıkça istiyor.
- Yazma yalnızca `tenant_owner`'da; diğer roller ekranı GÖRÜR. Gizlemek, sağımdaki
  "bu kırmızı neden kırmızı?" sorusunu cevapsız bırakırdı.
- Çiftlerin sırası doğrulanır (alt eşik < üst eşik, kırmızı < yeşil, kuruya < yüksek):
  ters girilirse renk motoru o bandı hiç üretmez ve bant sessizce kaybolurdu.
- Günlük verim LİTRE girilir, mL kaydedilir (§3).
- **Sınıflandırma kuralları** da eşiktir (backend ADR 0054): düşüş eşiği (%), boş sağım
  sınırı (mL) ve bakılan son sağım sayısı; tür bazında. `expectedPerMilkingMl` modelde ve
  formda — önceden yoktu ve gerçek API gövdesiz kaydı 422'yle reddediyordu. PUT kaydedilen
  satırı döner; gövdesiz cevapta gönderilen değer kullanılır.
- PUT gövdesi VARSAYIMDIR: §8.5 yolu veriyor, gövde şeklini vermiyor. Tam nesne
  gönderiliyor — kısmi güncelleme, iki kullanıcı aynı anda kaydettiğinde hangi alanın
  kazandığını belirsiz bırakırdı.

**Profil ekranı = hesap kartıdır** (`showAccountSheet`). Ayrı bir sayfa açılmadı: dört
sekmenin hiçbirine ait olmadığı için kabuğun üstünde tam ekran bir sayfa gezinme yığınını
karıştırırdı. Kartta ad, e-posta, **rol** ve eşik ayarları bağlantısı var; rol görünür
olmalı çünkü eşiklerin neden salt okunur açıldığının cevabı orada.

### Bildirim kanalları

**Hesap kartı → Bildirim kanalları** (`/settings/notifications`): işletme sahibi push'un
yanında e-posta (SMTP, SendGrid), Slack, Teams, webhook, SMS (Twilio, NetGSM, İleti
Merkezi, Vonage, JetSMS) ve sesli arama (Twilio, NetGSM, Vonage) kanalı ekler. Backend
tarafı `~/GolandProjects/milktrace` ADR 0028; uçlar `/notification-channels`,
`/notification-providers`, `…/{id}/test`.

- **Yalnızca `tenant_owner`:** kanallar alıcı telefonlarını ve API anahtarlarını taşır,
  backend diğer rollere 403 döner. Hesap kartındaki düğme de yalnızca owner'a görünür.
- **Form sağlayıcıdan çizilir:** alan listesi `GET /notification-providers`'tan gelir;
  yeni bir sağlayıcı uygulama güncellenmeden yapılandırılabilir. Kod → Türkçe etiket
  eşlemesi `channel_labels.dart`'ta; tanınmayan kod ham gösterilir.
- **Sırlar gelmez ve boş gönderilmez:** API sırrı döndürmez, yalnızca `secrets`'ta
  ayarlı olup olmadığını söyler. Güncelleme kısmidir; boş bırakılan sır alanı gövdeye
  HİÇ konmaz (boş dize backend'de "sil" demek).
- **Kaynak seçimi (`sources`):** `ops` sistem alarmları (kutu sustu), `summary` sağım
  özeti (oturum bitince tek mesaj; önem sınırı uygulanmaz), `herd` her sürü uyarısı
  ayrı (düşük debi). Yeni kanal varsayılanı `ops` + `summary` (backend ile aynı);
  `herd` gürültülü, isteyen açıkça seçer. SMS/arama varsayılan önemi "kritik".
- **Alıcı numaraları E.164** (`+905…`); yerel biçim reddedilir.
- **Günlük sınır** (`dailyLimit`): boş = türün varsayılanı (SMS 50, arama 20,
  öbürleri sınırsız; `NotificationProvider.defaultDailyLimit`), `0` göndermek
  varsayılana döndürür. Listedeki aç/kapa TAM gövde gönderir; sınırı
  eklemeyi unutursan kanalı kapatıp açmak ayarlanmış sınırı sıfırlar
  (testle kilitli).
- Mock'ta sağlayıcı listesi `assets/data/notification_providers.json`: backend'in
  sağlayıcı tanımlarından ÜRETİLDİ, elle düzenlenmez. Backend'e sağlayıcı eklenince
  yeniden üretilmeli.

**Hata mesajları:** `ApiRepository` DioException fırlatır; `ApiException`'a çeviri
yalnızca giriş ucundaydı. Bu yüzden ekranlar gerçek API'de backend'in Türkçe mesajı
yerine "DioException…" gösteriyordu. `userMessage(error)` (core/api_exception.dart)
ikisini de çözer; hata gösteren yerde onu kullan.

Mock moda dönmek: `flutter run --dart-define=MT_API=mock`. O modda kimlik sunucusu
olmadığı için giriş ekranı atlanır ve demo kullanıcısıyla çalışılır.

---

## 7. Firebase / push bağlama

Proje: **`milktrace-69975`** (Firebase Console, `algebransoft@gmail.com`). Uygulamalar:
Android ve iOS, ikisi de `com.algebran.milktrace.milktrace`.

**Yapıldı (25.09.2026):**

1. Android ve iOS uygulamaları projeye kaydedildi (`firebase apps:create`).
2. `android/app/google-services.json` ve `ios/Runner/GoogleService-Info.plist` repoda. Sır
   DEĞİL (içindeki API anahtarı APK'da zaten açık), ama projeye özgü: başka bir Firebase
   projesine geçilirse ikisi birlikte `firebase apps:sdkconfig` ile yenilenir.
3. Gradle eklentisi `com.google.gms.google-services` 4.4.2 eklendi. DİKKAT: artık
   `google-services.json` olmadan `assembleDebug` KIRILIR; dosyayı silme.
4. Dart tarafında değişiklik olmadı; bildirim simgesi `@drawable/ic_stat_milktrace`.
5. Doğrulandı (Android emülatörü, gerçek API): test bildirimi uygulama açıkken ve arka
   plandayken; gerçek "Sayaç çevrimdışı" uyarısı; "Sayaç geri geldi" aynı bildirimin
   yerine geçti.

**Kalan:**

- **iOS (Xcode tarafı YAPILDI, 25.09.2026):** `GoogleService-Info.plist` Runner hedefinin
  kaynaklarında; `Runner/Runner.entitlements` (`aps-environment`) üç yapılandırmada
  `CODE_SIGN_ENTITLEMENTS`; `Info.plist`'te `UIBackgroundModes: remote-notification`;
  `AppDelegate` bildirim merkezinin temsilcisi (yoksa ön plandaki yerel bildirim yutulur).
  iOS'ta FCM jetonu APNs jetonundan türer: `FirebasePushGateway` önce APNs jetonunu ~5 sn
  bekler, gelmezse `null` döner (`getToken` aksi hâlde `apns-token-not-set` atıyordu).
  **Kalan (elle):** APNs anahtarını (.p8) Firebase → Proje ayarları → Cloud Messaging'e
  yükle; Xcode'da Signing & Capabilities → ekip seç (`DEVELOPMENT_TEAM` boş; Apple
  Developer Program üyeliği gerekli — ücretsiz hesap push yeteneğini imzalayamaz); gerçek
  iPhone'da test bildirimi. Push simülatörde de denenebilir ama asıl doğrulama cihazda.
- **Araç zinciri:** Flutter ≥ 3.47 gerekir (25.09.2026'da 3.47.5'e yükseltildi). 3.41.3,
  Xcode 27'nin `lipo -verify_arch`'ı birden çok mimari kabul etmediği için
  `flutter build ios --simulator`'da düşüyordu. 3.47 iOS eklentilerini CocoaPods'tan **Swift Package
  Manager**'a taşıdı (Firebase dahil; `Podfile.lock`'ta yalnızca Flutter kaldı). Varsayılan API tabanı platforma göre:
  Android emülatöründe `10.0.2.2`, iOS simülatöründe `localhost` (`Env.apiBaseUrl`).
  Simülatörde çalışıp giriş ekranına kadar açıldığı doğrulandı; izin penceresi ve giriş
  elle geçilmeli (Xcode 27'de Simulator.app yok, `simctl` bildirim izni veremiyor).
- **Staging/üretim backend'i:** servis hesabı anahtarı kümeye Secret olarak
  (`~/GolandProjects/milktrace/docs/saha/push-kurulum.md` §2). Yerelde anahtar
  `services/notification/.env`'de (repoya girmez).

Doğrulama: hesap kartında **"Bu telefona test bildirimi"** → `POST /me/push-tokens/test`.

**Backend sözleşmesi (`notification` servisi yazılırken doğrulanacak):**

- FCM mesajı **`notification` bloğu taşımalı**. Uygulama kapalıyken bildirimi sistem
  tepsisine Android koyuyor; yalnızca `data` gönderilirse hiçbir şey görünmez. Uygulama
  AÇIKKEN bildirim tepsiye düşmez, o yüzden `flutter_local_notifications` ile elle
  gösteriliyor — kanal kimliği `milktrace_alerts`, AndroidManifest'teki
  `default_notification_channel_id` ile aynı olmak zorunda.
- `data.animalId` varsa bildirime dokunuş `/history/animal/{id}`'ye, yoksa `/alerts`'e
  gider. Bilinmeyen/eksik alan `/alerts`'e düşer (`PushMessage.fromRemote`).
- Metinler Türkçe ve olduğu gibi gösterilir (§16).
- **Jeton uçları** (§8.5 listelemiyor, backend'de yazılı ve bu yollarla):
  `POST /me/push-tokens {token, platform}`, `DELETE /me/push-tokens/{token}` ve test için
  `POST /me/push-tokens/test`. Jeton oturum açılınca yazılır, kapanınca silinir,
  yenilenince yeniden yazılır.
- **Etiket:** FCM mesajı uyarı kimliğini `tag` / `apns-collapse-id` olarak taşır; aynı
  uyarının "geri geldi" duyurusu tepside "çevrimdışı"nın YERİNE geçer. Uygulama açıkken
  gösterilen yerel bildirimin kimliği de `alertId`'den türer (aynı davranış). Uyarı
  yüksek öncelikli ve sesli, çözülme duyurusu sessiz.
