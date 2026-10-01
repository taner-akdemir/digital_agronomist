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

Kodda İngilizce, arayüzde Türkçe ve İngilizce (backend ADR 0093; bkz. §5 "Metinler").

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
- **Metinler (backend ADR 0093):** arayüzde sabit metin YAZILMAZ. Her metin
  `lib/l10n/parts/<bölüm>_tr.arb` VE `_en.arb`'da; kodda `l10n.anahtar` (global,
  `package:milktrace/l10n/l10n.dart` — bağlamsız yerde de çalışır, testlerde
  varsayılan Türkçe). Ekledikten sonra `dart run tool/l10n/merge.dart` (iki dilde
  anahtar ve yer tutucu eşliğini denetler, `gen-l10n` koşar); `app_*.arb` ve
  `lib/l10n/gen/` ÜRETİLİR, elle düzenlenmez ama commit edilir. Sunucudan gelen metin
  (`userMessage`, uyarı, not, küpe mesajı) çevrilmez: sunucu `Accept-Language`'a göre
  zaten çevirip gönderir. Veri (hayvan/bölge/grup adı) çevrilmez; tür adı
  `Species.displayName`. Dil: hesap kartı ya da giriş ekranı → `appLanguageProvider`;
  yoksa cihaz dili (İngilizce cihaz → İngilizce, diğerleri Türkçe).
- Tasarım dili: açık, nötr sıcak beyaz zemin; yeşil yalnızca VURGU (dolgu #237A4B, marka metni
  #1E6E43) — 01.10.2026'da web'le birlikte açıldı, koyu yeşil zeminler yok; Poppins, kart tabanlı görünüm.
  Renk/boşluk/köşe değerleri `lib/app/theme.dart` içindeki token'lardan gelir, çağrı yerinde
  sabit yazılmaz.

- **Marka/ikon:** kaynaklar `tool/brand/*.svg` (koyu yeşil zemin, beyaz süt damlası, içinde
  debi çizgisi). İkonları elle düzenleme; `tool/brand/generate.sh` Android (uyarlanabilir +
  monokrom), iOS AppIcon ve bildirim simgesini (`drawable-*/ic_stat_milktrace`, tek renk
  siluet) üretir; ayrıca üst çubuk ve giriş ekranındaki işareti (`assets/brand/mark.png`,
  açık zeminde koyu yeşil damla; koyu tema için `mark_dark.png`, açık yeşil damla — widget'ta
  `BrandMark` kullan, `Image.asset` ile işareti doğrudan yazma). Çıktı deterministik: kaynak değişmedikçe PNG'ler
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
Kayıtlı küpe varsayılan olarak güncellenmez; "Kayıtlı hayvanları güncelle" anahtarı
(backend ADR 0101) önizlemeyi ve onayı `update=true` ile yeniler: yalnızca dolu hücreler
yazılır (boş hücre silmez, tür değişmez), satırda "Ad: Sarıkız → Sarı" gibi alan farkları
(`AnimalImportChange`, değerler ham — tarih/durum ekranda biçimlenir), sayılar eklenecek /
güncellenecek / değişmeyecek / hatalı, `newGroups` ("Grup" sütunu olmayan grubu açar).
Mock modda yok (501). Seçici `importFilePickerProvider`; testte sahtesi konur.

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

**Üreme** (`BreedingCard`, `/animals/{id}/breeding`, backend ADR 0088): tohumlama (boğa/sperma
kodu) ve gebelik kontrolü (gebe/boş); BÜTÜN roller ekler, yanlış kaydı yalnızca sahip siler.
Durum, beklenen doğum ve kuruya çıkarma `Animal.pregnancy`'de SUNUCUDAN gelir (türün
`gestation_days` / `dry_period_days`); uygulama hesaplamaz — mock'taki `_pregnancyOf`
yalnızca ayna. Panoda "Yaklaşanlar" (`GET /breeding/upcoming`, 30 gün) boşken çizilmez.

**Tank teslimi** (`/deliveries`, backend ADR 0089): panoda "Tank teslimi" kartı (son teslim +
"Teslim gir"; görüntüleyiciye yalnızca kayıt varsa). Tanker fişini sahip ve operatör girer,
yanlışı yalnızca sahip siler, fark eşiğini (%) yalnızca sahip değiştirir. Karşılaştırmayı
SUNUCU yapar (önceki teslimden bu yana, ayrılan süt hariç; ilk teslim karşılaştırılmaz);
eşik aşılırsa `delivery_mismatch` uyarısı. kg girilirse varsayılan yoğunlukla (1,03) mL'ye
çevrilir — tankın sütü karışık. Mock'ta karşılaştırma yok (fark uydurulmaz).

**Süt kalitesi** (backend ADR 0110): teslim penceresinde açılır "Mandıra analizi" — yağ,
protein (%), somatik hücre ve bakteri (**bin/mL**, fişteki gibi), hepsi isteğe bağlı.
Satırda analiz ve sınır aşımında kırmızı satır + amber kenar (`Delivery.highScc` SUNUCUDAN;
mock yalnızca ayna). Listenin üstünde son 90 günün hücre eğilimi (`QualityTrendCard`, ayrı
uç yok, liste okunur; sınır kesik gri çizgi). Sınır (`Deliveries.sccLimitK`, varsayılan
400) sahibin; `setDeliveryTolerance(pct, sccLimitK:)` fark eşiğini de gönderir.
Aşımda `high_scc` uyarısı. **Haftalık özet** (ADR 0079/0111) ayrı kanal kaynağı
`weekly`: SMS/arama dışı yeni kanalda varsayılan açık (`defaultChannelSources(kind)`).

**Soy bilgisi** (backend ADR 0114): `Animal.damId` (sürüdeki anne) ve `sireCode` (boğa/sperma
kodu); `animalBody` ikisini HER ZAMAN gönderir (tam kayıt, testle kilitli). Formda aynı türden
anne seçici; detayda anne çipi, baba kodu ve yavrular (liste `damId`'ye göre süzülür).
Buzağılama kaydedilince bildirimde "Yavruyu kaydet" → `/animals/new?damId=&birth=` (tür
annenin türüyle gelir). Döngü ve başka işletmenin hayvanı sunucuda 422.

**Nokta sağlığı** (backend ADR 0113, `GET /spout-health`): nokta 7 günde farklı hayvanlarda
ünitesinin diğer noktalarından belirgin düşük debi ölçüyorsa (`low` SUNUCUDAN) Cihazlar'da
çevrimiçi satır SARI "Düşük debi · %44", ünite açık gelir, sayaç sayfasında açıklama.
Okunamazsa sessizce düşer (ağaç ondan bağımsız). Mock'ta yok. Sunucu ayrıca
`spout_low_flow` uyarısı açar.

**305 gün** (backend ADR 0115): `AnimalTrend.lactation` — ölçülen, 305 gün tahmini
(SUNUCU, Wood eğrisi; null = 30 günden kısa, eğriye uymuyor ya da sağmal değil) ve
`complete`. Hayvan detayında eğilim kartının altında; buzağılama kaydı yoksa kart yok.
Mock'ta yok. Verim raporunda "305 gün tahmini" sütunu.

**Çiftliklerim** (`/settings/farms`, backend ADR 0116, `GET /me/farms`): hesap kartında
birden çok işletmesi olana; her işletmenin bugünkü sütü, okunmamış uyarısı, zamanı gelen
aşısı. Dokununca `switchTenant` → pano. Miktarlar seçili işletmenin biriminde gösterilir.
İçe aktarmada "Anne Küpe" ve "Baba" sütunları (ADR 0117); önizlemede `dam`/`sire` değişikliği.

**Üreme hatırlatması ve göstergeler** (backend ADR 0118, 0120): sunucu kuruya çıkarma ve
beklenen doğumdan 7 gün önce hayvana bağlı `dry_off_due` / `calving_due` uyarısı açar
(dokununca hayvan). Panoda "Üreme · son 12 ay" (`DashboardSummary.breeding`, örnek yoksa
kart yok): buzağılama aralığı, ilk tohumlamada gebelik, buzağılamadan gebeliğe — her biri
örnek sayısıyla; hesap SUNUCUDA.

**Isı stresi** (backend ADR 0119): hesap kartında sahibe "Tesis konumu"
(`/settings/farm-location`): koordinat elle, Google Haritalar'dan yapıştırılır
(`parseCoordinate`); konum İZNİ yok, telefonun konumu okunmaz. Sunucu Open-Meteo'dan THI
hesaplar, ≥ 72'de `heat_stress` uyarısı. Verim grafiğinde `AnimalDailyStat.thi ≥ 72` günler
`AppColors.chartHeat` (turuncu; §6.2 renkleri değil) dikey şeritle ve lejantla işaretlenir.

**Kızgınlık** (backend ADR 0121): üreme kartında "Kızgınlık" kaydı (bütün roller);
`Pregnancy.lastHeat/expectedHeat` SUNUCUDAN (21. gün, pencere 18–24; mock `_pregnancyOf`
ayna). Kart pencereyi yazar; "Yaklaşanlar"da `heat` olayı; sunucu pencere boyunca
`heat_expected` hatırlatması açar.

**Çıkış nedeni** (backend ADR 0122): formda durum satıldı/kesildi/öldü olunca "Çıkış
nedeni" zorunlu (`exitReasons`, `exitReasonLabel`); `animalBody` yalnızca çıkış
durumunda gönderir. Detayda durum çipi "Satıldı · Düşük verim". Panoda son 12 ayın
dağılımı (`DashboardSummary.exits`; `unknown` = "Belirtilmedi").

**İlk kurulum ve Yenilikler** (backend ADR 0123, yalnızca mobil): panonun başında sahibe
"Kuruluma başlayın" listesi (`SetupChecklistCard`): hayvanlar, sağım saatleri, bildirim
kanalı, kullanıcı, tesis konumu — durum mevcut sağlayıcılardan (ayrı uç yok; okunamayan
adım gizli), kapatma cihazda işletme başına (`setup.dismissed.<işletme>`). Yenilikler:
`WhatsNewListener` kabukta; `whatsNewId` değişince bir kez, ilk kurulumda HİÇ; hesap
kartında "Yenilikler". YENİ SÜRÜMDE `whatsNewId` ve `whatsNewItem*` ARB metinleri güncellenir.

**Sayaç kontrolü** (backend ADR 0124): hayvan detayındaki son sağımlarda sahip ve operatör
sağıma dokunur → "Elle ölçüm" (`showMeterCheck`; miktar işletmenin biriminde, kg HAYVANIN
TÜRÜNÜN yoğunluğuyla mL'ye — tank fişinden farkı: tek hayvanın sütü) →
`POST /milkings/{id}/meter-check`. Sapma ve sayacın özeti (son 10 kontrol, ≥ 3 kontrol ve
|ort.| > %5 = `needsCalibration`) SUNUCUDAN; bildirimde "Sayaç %+8.0 · son 3 kontrol
ortalaması %+8.0" (+ kalibrasyon isteyin). Sayaçsız sağım 422, mesaj olduğu gibi. Cihazlar'da
`meterSummariesProvider` (`GET /meter-checks`, okunamazsa boş): kalibrasyon gereken çevrimiçi
sayaç SARI "Kontrol sapması %+8" (çevrimdışı/hata/kalibrasyon zamanı/düşük debi önce), ünite
açık; sayaç sayfasında "Sayaç kontrolü" (`GET /meter-checks?deviceId=`, önbelleksiz): ortalama,
sayı, son 3 kontrol. Katsayı uygulamada DEĞİŞMEZ; `meter_drift` uyarısı sunucunun. Mock
üretilmiş sağımı hayvanın kimliğinden deterministik bir çevrimiçi sayaca bağlar (geçmiş
noktasız), kontroller bellekte, özet backend kuralıyla.

**Sağım hızı** (backend ADR 0125, `GET /milking-speed`): `milkingSpeedProvider` (hayvana göre,
okunamazsa boş). Detayda "Sağım hızı · son 30 gün" (ortalama/tepe debi, ortalama süre
`durationLabel`, türün sürü ortalaması; `slow` SUNUCUDAN → amber "Yavaş sağılıyor: sürü
ortalamasının %X altında"); veri yoksa kart yok. Geçmiş → Hayvanlar'da "Yavaş sağılanlar"
çipi (`AnimalFilter.slow`; hız yalnızca süzgeç açıkken okunur). Mock üretilmiş geçmişten aynı
kuralla hesaplar; üretici debiyi türün bandından sabit aldığı için mock'ta yavaş YOK.

**API anahtarları** (`/settings/api-keys`, backend ADR 0126): hesap kartından YALNIZCA sahibe.
Liste (ad, `mtk_<önek>_…`, oluşturan/tarih, son kullanım), "Anahtar oluştur"
(`showTextPrompt`) → tam anahtar BİR KEZ (kopyala + "Bu anahtar bir daha gösterilmez";
pencere dışarı dokunarak kapanmaz), iptal onayla (gateway'de ≤ 1 dk). Anahtar salt okunur:
hayvan listesi, teslimler, `GET /api/v1/exports/daily?from=&to=` + `Authorization: Bearer`.
Önbelleklenmez (Kullanıcılar gibi: çevrimdışı eski liste iptal edilmiş sanılan açık anahtarı
gösterebilir). Mock bellekte.

**Sağımcılar** (`/settings/milkers`, backend ADR 0090): hesap kartından YALNIZCA sahibe.
Sağımcı = oturumu açan / hayvanı bağlayan (ayrı seçim adımı yok). 7/30 gün; oturum, sağım,
süt, ortalama süre, düşük debi payı. Metin oranın kişiyi puanlamadığını söyler.
Süt fiyatı/gelir takibi YOK (karar 28.09.2026).

**Sağımhane tableti** (backend ADR 0091): Kullanıcılar → "Sağımhane tableti" ortak operatör
hesabı açar (parola zorunlu, davet yok). `AuthUser.kiosk` ise router HER yolu `/kiosk`'a
çevirir: yalnızca canlı ekran, sekme/hesap kartı/zil yok, ekran kararmaz (`wakelock_plus`,
`screenAwakeProvider`), çıkış onayla. Kısıt asıl gateway'de (kiosk token'ı rapor, pano,
ekip, eşik yazmada 403) — uygulamadaki yönlendirme kolaylık, güvenlik değil.

**Kırmızı uyarısı** (`RedAlertListener`, ADR 0091): canlı ekran açıkken bir nokta
kırmızıya GEÇİNCE titreşim + kısa sistem sesi, aynı sağım (nokta + hayvan) için bir kez;
açılışta zaten kırmızı olan çalmaz. Renk sunucunun — ısınma/bitiş bastırması orada, burada
ikinci kural YOK. Canlı başlıktaki zil simgesiyle kapatılır; ayar cihazda
(`settingsStoreProvider`, `live.redAlert`). Testte `redAlertSinkProvider` sahtesi.

**Sağılmayan hayvanlar** (backend ADR 0094): Geçmiş → Oturumlar'da bitmiş oturuma
dokununca `showSessionSummary` (`GET /sessions/{id}/summary`): toplam, sağmal olup
sağılmayanlar (tek bölgede bütün sağmallar, çok bölgede bu bölgenin önceki oturumunda
sağılanlar — sunucu hesaplar), düşük verim ve düşük debi. Ayrı uyarı yok; sağım özeti
bildiriminde de aynı satır. Web erişimi YOK (karar 29.09.2026).

**Hayvan grupları** (backend ADR 0092): hayvanın en çok BİR grubu (`Animal.groupId/
groupName`). Geçmiş → Hayvanlar → "Gruplar" (yalnızca sahip) ekler/adlandırır/siler;
atama formdan (`animalBody` `groupId`'yi HER ZAMAN gönderir — null = grupsuz). Listede grup
çipi ve süzgeci (`AnimalFilter.groupId`), detayda "Grup" satırı, panoda "Gruplar · bugün"
(sağılan başına ortalama; satır Geçmiş'i o gruba süzer). Tek alanlı pencereler için
`showTextPrompt` — denetleyiciyi pencere kendisi tutar.

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

**Sessiz saat** (`/settings/quiet-hours`, backend ADR 0107): hesap kartından BÜTÜN rollere,
kişiye ait (`GET/PUT /me/quiet-hours`, dakika; başlangıç > bitiş gece yarısını aşar). Bu
saatlerde backend kritik OLMAYAN push'u `milktrace_quiet` kanalına (düşük önem, sessiz)
gönderir ve veride `quiet: "1"` koyar; uygulama açıkken yerel bildirim de o kanala düşer.
Kritik ve `device_offline` her zaman çalar. **Eskalasyon** (ADR 0108): SMS/arama kanalı
formunda "Eskalasyon (dk)" (0–240, varsayılan 15, 0 kapalı) — okunmayan kritik uyarı süre
dolunca o kanala da gider. Listedeki aç/kapa gövdesi `escalationMinutes`'ı da taşır.

**Parolamı unuttum** (backend ADR 0074): giriş ekranında; pencere e-postayı
`POST /auth/password-reset`'e gönderir ve sunucunun metnini olduğu gibi gösterir (kayıtlı
olsun olmasın aynı metin). Bağlantı telefonun TARAYICISINDA açılır (panelin herkese açık
`/admin/parola-sifirla` sayfası); yeni parola orada belirlenir, uygulamada ikinci form
YOK. Posta kapalıysa 503 mesajı gösterilir. Sağlayıcı `passwordResetRequesterProvider`
(testte sahtesi). Askıdaki/kapalı işletmenin kullanıcısı giremez (ADR 0072): giriş ve
yenileme 403 ve sunucunun mesajı.

**Kullanıcılar** (`/settings/team`, backend ADR 0076): hesap kartından YALNIZCA işletme
sahibine. Operatör ve görüntüleyici ekler (parola boşsa e-postayla davet, doluysa geçici
parola; posta kapalıyken sunucu 503 ve "geçici bir parola girin"), rolünü değiştirir,
askıya alır, siler (notları "Silinmiş kullanıcı" kalır). Sahipler listede salt okunur;
sahip eklemek platformun işi. Önbelleklenmez (çevrimdışı eski listeden silme olmasın).
Mock modda bellekte. Rol etiketleri `features/auth/role_labels.dart`.

**Destek** (backend ADR 0077): giriş ekranında ve hesap kartında "WhatsApp" ve "Ara".
Numara `GET /auth/support`'tan (kimlik doğrulamasız — giremeyen de ulaşsın), uygulamaya
GÖMÜLMEZ. Numara yoksa ya da okunamazsa bölüm sessizce gizlenir. WhatsApp `wa.me` + hazır
metin ve uygulama sürümü; WhatsApp yoksa tarayıcıda açılır. Sağlayıcılar
`supportInfoProvider` / `supportLauncherProvider` (testte sahtesi — hesap kartını açan
testler de `supportInfoProvider`'ı ezmeli, yoksa ağa çıkar).

**Tek hesap, çok işletme** (backend ADR 0081): veteriner/danışman birden çok çiftliğin
üyesi olabilir. `AuthUser.tenants` girebildiği işletmeler; `role`/`tenantId` seçili
olanınki. Birden çoksa hesap kartında "İşletme değiştir" → `Auth.switchTenant`
(`POST /auth/switch`) → canlı sekme. Depo, önbellek kapsamı ve push kaydı oturumu
izlediği için kendiliğinden yeni işletmeye geçer.
Kullanıcılar ekranında kayıtlı e-posta yeni hesap açmaz, işletmeye üye olarak eklenir.
Bildirimler BÜTÜN işletmelerden gelir (backend ADR 0085): başlıkta çiftlik adı (yalnızca
çok işletmelide), veride `tenantId`; dokununca `PushMessage.tenantToSwitch` gerekirse önce
o işletmeye geçirir (app.dart), sonra açar.

**İşlem kaydı** (`/settings/audit`, backend ADR 0082): hesap kartından YALNIZCA sahibe.
Son 90 gün; eşik, hayvan, içe aktarma, buzağılama, eşleştirme kaldırma (silinen sağım),
kullanıcı ve kanal değişiklikleri — kim, ne zaman, ne. Olay kodu → Türkçe
`auditActionLabel`; tanınmayan kod ham. Kaydı backend yazar, uygulama yalnızca okur.

**Tesis yapısı uygulamada DEĞİŞMEZ** (karar 28.09.2026): bölge/ünite/nokta ve sayacın
noktaya takılması kurulum ekibinin işi, panelden. Sahip görür; yanlış takılan sayaç
veriyi başka noktaya yazar. Cihazlar sekmesine düzenleme ekleme.

**Süt birimi** (backend ADR 0086): içeride her şey mL (§3), API aynı. İşletme L ya da kg
seçer (hesap kartı, yalnızca sahip; `AuthUser.volumeUnit`). Miktar gösteren HER yer
`volumeFormatProvider` (`VolumeFormat.amount(ml, species:)`) kullanır — `Fmt.litres`
yeni kodda KULLANILMAZ. kg = L × türün yoğunluğu (`Thresholds.milkDensity`, eşik
ekranında; tür bilinmiyorsa 1,03). Eşikler (beklenen, günlük sınırlar) yine litre girilir.

**Tema** (backend ADR 0109): hesap kartında BÜTÜN rollere "Tema": Açık / Karanlık / Cihaz.
Varsayılan AÇIK (tasarım dili açık zemin; karanlık isteğe bağlı). Seçim cihazda
(`settingsStoreProvider`, `app.theme`; `appThemeModeProvider`, "Cihaz" için
`effectiveBrightnessProvider` sistem parlaklığını izler); tablette kart yok, kayıtlı seçimi
izler. `AppColors` artık SABİT DEĞİL: getter'lar geçerli parlaklığın `AppPalette`'inden
okur, kök (`app.dart`) `AppColors.brightness`'ı yazar ve MaterialApp'i parlaklıkla
anahtarlar (değişince ağaç baştan kurulur). Bu yüzden renkler `const` içinde kullanılamaz ve
widget'ta `Colors.white`/`Color(0x…)` YAZILMAZ — token'dan oku. Adlar açık temadaki ROLÜ
taşır (`darkGreenColor` karanlıkta açık yeşil metin rengidir); dolgu için `brandFill` / `warningFill` /
`dangerFill`, üstündeki yazı `onFill`. §6.2 renkleri anlamını korur, yalnızca koyu zeminde
okunacak kadar açılır.

**Tedavi ve arınma** (backend ADR 0084): hayvan detayında "Tedavi ve arınma" kartı
(`TreatmentsCard`); BÜTÜN roller ekler (veteriner), yanlış kaydı yalnızca sahip siler.
`Animal.withdrawalUntil` / `SpoutAnimal.withdrawalUntil` = sütün ayrılacağı son gün; canlı
kartta küpe satırının YERİNE kırmızı "Sütü ayır · arınma 30 Eyl" (tanınmayan küpe
önceliklidir, yükseklik aynı — testle kilitli), seçicide sağda "Sütü ayır". Sağım yine
kaydedilir; backend "ayrılan süt" olarak işaretler.

**Aşı takvimi** (backend ADR 0112): Geçmiş → Hayvanlar'da BÜTÜN rollere "Aşılar"
(`/vaccinations`, kabuğun dışında). Plan = ad + tekrar aralığı (7–1095 gün) + isteğe bağlı
tür ("Bütün türler" = null) + not; yalnızca sahip ekler/düzenler/siler (plan silinince
kayıtları da gider). Plana dokununca zamanı gelenler (`GET /vaccinations/due`, 30 gün;
kayıtsız ve en gecikmiş üstte, sunucu sıralar): seç / "Tümünü seç" → "Uygulandı olarak
işaretle" (gün, varsayılan bugün, gelecek yok; not) → TEK `POST /vaccinations`, cevap yazılan
sayı (planın türünde olmayan, satılmış hayvan ve aynı gün tekrarı sunucuda sessizce atlanır).
BÜTÜN roller işaretler (veteriner), yanlış kaydı yalnızca sahip siler. Hiç kaydı olmayan
hayvan ZAMANI GELMİŞ sayılır ("kayıt yok") — plan açılınca mevcut durum girilsin diye.
Hayvan detayında `TreatmentsCard`'ın altında `VaccinationsCard`: plan başına "sonraki 3 Eki"
/ "kayıt yok" / kırmızı "gecikti · …", satırda "Uygulandı", son 3 kayıt. Tarihler gün
olarak (`vaccineDay`). Hatırlatma uyarısı `vaccination_due` SUNUCUDAN (6 saatte bir, plan
başına tek uyarı); uygulama hesaplamaz. Uyarı `planId` taşır: dokununca
`/vaccinations/:planId` o planın zamanı gelenlerini açar (plan silinmişse liste). Mock'taki durum hesabı yalnızca ayna.

**Oturum kendiliğinden açılır/kapanır** (backend ADR 0083): açık oturumu olmayan bölgede
sayaç akış bildirince backend oturumu açar (tür saate göre), 45 dk akışsız kalınca kapatır.
Canlı ekran açık oturumu zaten listeden seçtiği için değişiklik gerekmedi; "Sağım başlat"
ve "Bitir" durur (açıkken başlatma 409). `MilkingSession.autoStarted` geçmişte
"otomatik açıldı" diye yazılır.

**Asgari sürüm** (backend ADR 0080): üç Dio'nun hepsi `X-App-Platform` ve `X-App-Build`
(versionCode, `AppBuild.load()` main'de) gönderir; gateway asgarinin altına 426 döner,
`AppBuildInterceptor` `UpgradeGate`'i açar ve router her ekranı `/update`'e ("Güncelleme
gerekli", Play düğmesi + destek) çevirir; geri dönüş yok. Uyumsuz backend değişikliğinde
önce yeni sürüm Play'e, sonra netcup'ta `MIN_APP_BUILD_ANDROID`. Bu yüzden versionCode
(`pubspec.yaml` `+N`) her yüklemede ARTMALI (§8).

**Kanal dili** (backend ADR 0095): bildirim kanalı formunda "Bildirim dili" (Türkçe /
English); sunucu teslimatta kanalın diline çevirir. Aç/kapa TAM gövdesi `language`'ı da
taşır (testle kilitli) — yoksa sunucu eskisini korur ama tam gövde kuralı bozulur.

**Kalibrasyon** (backend ADR 0097): `Device.calibratedAt` / `calibrationDueAt` (kurulum
ekibi panelden girer). Zamanı gelen çevrimiçi sayaç SARI "Kalibrasyon zamanı", ünitesi
açık gelir; ayrıntıda son ve sonraki kalibrasyon ("kayıt yok" = hatırlatma gitmez).
Sunucu işletmeye `calibration_due` uyarısı açar, kalibre edilince çözülür. Uygulamada
kalibrasyon GİRİLMEZ (tesis yapısı gibi kurulum ekibinin işi).

**Hesap silme** (backend ADR 0098; Play şartı): hesap kartının altında "Hesabımı sil"
(mock modda yok) → parola onayı → `DELETE /me` → yerel çıkış. Tek sahip silemez (409,
sunucunun mesajı, pencere açık kalır). Web karşılığı sitenin `milktrace.com.tr/hesap-sil` sayfası
— Play Console'daki silme bağlantısı.

**Sağım saatleri** (`/settings/schedule`, backend ADR 0099): hesap kartından yalnızca
sahibe; sabah/akşam saati (kapalı olabilir) ve gecikme payı. Sunucu saatten sonra oturumu
açılmamış bölge için `milking_missed` uyarısı açar; oturum açılınca çözülür.

**İki adımlı doğrulama** (backend ADR 0102): hesap kartında bütün rollere "İki adımlı
doğrulama" (`/settings/2fa`): kurulum anahtarı + "Uygulamada aç" (otpauth), kodla açma,
yedek kodlar YALNIZCA bir kez; kapatma parola + kod. Girişte sunucu `mfaRequired`
dönerse `AuthApi.login` `MfaRequired` atar, giriş ekranı kod adımına geçer
(`Auth.signInSecondFactor`). Durum önbelleklenmez. Platform yöneticisine zorunlu (panel).

**Süreli erişim** (backend ADR 0103): Kullanıcılar'da ekleme ve kişi menüsünde "Erişim
bitişi" (gün ya da süresiz). `updateTeamMember` TAM kayıt: `accessUntil` her çağrıda
taşınır — gönderilmezse süre kalkar (testle kilitli). Ertesi gün sunucu girişi keser,
sahibe `access_ended` bildirimi gider (dokununca Kullanıcılar).

**Oturumlar** (`/settings/sessions`, backend ADR 0105): hesap kartında bütün rollere;
cihaz/tarayıcı, son kullanım, IP; tek tek ya da "Diğer bütün cihazlardan çık". Uygulama
her istekte `User-Agent: MilkTrace/<sürüm> (<platform>)` gönderir (`AppBuild.headers`)
ki listede tanınsın. Repo metotları `loginSessions`… (`sessions()` sağım oturumlarıdır).
Önbelleklenmez. Yanlış parola sınırı (ADR 0104) sunucuda: 429 mesajı olduğu gibi gösterilir.

**Çökme raporu** (backend ADR 0100): `CrashReporting.init()` main'de; Firebase
Crashlytics, debug'da kapalı, Firebase yoksa sessizce atlanır. Rapora kullanıcı/işletme
bilgisi EKLENMEZ (`setUserIdentifier` çağırma). Gizlilik belgeleri buna göre.

**Geri bildirim** (`/settings/feedback`, backend ADR 0106): hesap kartında BÜTÜN rollere
"Geri bildirim" (tablette kart yok). Metin zorunlu (≤ 4000), ekran görüntüsünü kullanıcı
galeriden SEÇER (`feedbackImagePickerProvider`, testte sahtesi); tür içerikten
(PNG/JPEG/WebP) ve ≤ 2 MB uygulamada da denetlenir. `sendFeedback` → `POST /feedback`;
sürüm, platform, işletim sistemi ve cihaz modelini depo ekler (`AppBuild.feedbackInfo`;
model Android'de `MainActivity`'deki `milktrace/device` kanalından — eklenti yok, iOS'ta
boş). Önbelleklenmez, kuyruk yok. Panelde "Geri Bildirimler"; 1 yıl saklanır.

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
  **Karar (28.09.2026): pilotta iOS push KAPALI** — Apple Developer üyeliği ve APNs
  anahtarı yok; iPhone kullanan sağımcıya e-posta/SMS gider (pilot kontrol listesi §0).
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

## 8. Play Console — dahili test

Karar (28.09.2026): pilot telefonlarına Play Console **dahili test** kanalıyla. Hesap var.

**Yükleme anahtarı (bir kez, sen oluşturursun; parola kimseyle paylaşılmaz):**

```
mkdir -p ~/keystores
keytool -genkey -v -keystore ~/keystores/milktrace-upload.jks \
  -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

`android/key.properties` (repoya GİRMEZ, `.gitignore`'da):

```
storePassword=<parola>
keyPassword=<parola>
keyAlias=upload
storeFile=/Users/<sen>/keystores/milktrace-upload.jks
```

`.jks` dosyasının ve parolanın **yedeğini** al. **Play App Signing** açık kalsın
(varsayılan): uygulamayı Google'ın anahtarı imzalar, bu yalnızca YÜKLEME anahtarıdır —
kaybolursa Play Console'dan sıfırlanabilir.

**Sürüm:**

1. `pubspec.yaml`'da `version: X.Y.Z+N` — N (versionCode) her yüklemede artmalı.
2. `tool/release.sh` (API `https://api.milktrace.com.tr/api/v1`; başka ortam `MT_API_BASE=…`) → analiz, test,
   `build/app/outputs/bundle/release/app-release.aab`. Betik https olmayan adresi ve
   anahtarsız (debug imzalı) derlemeyi reddeder.
3. Play Console → uygulama → Test → **Dahili test** → Yeni sürüm → .aab'yi yükle;
   test edenler listesine sağımcıların Google hesaplarını ekle, katılım bağlantısını gönder.

İlk yüklemeden önce Console'un istediği "Uygulama içeriği" formları (veri güvenliği,
hedef kitle, gizlilik politikası bağlantısı) doldurulur. Taslaklar `docs/gizlilik/`:
gizlilik politikası, KVKK aydınlatma metni ve veri güvenliği formu cevapları — koddan
çıkarıldı, şirket bilgileri dolu (30.09.2026), **hukuki kontrol** bekliyor. Yeni izin, SDK,
bildirim sağlayıcısı ya da veri toplayan form eklenirse üçü birlikte güncellenir. Alan adı
**`milktrace.com.tr`**: site + müşteri paneli kökte, API `api.`, yönetim paneli `admin.`.
Hesap silme `https://milktrace.com.tr/hesap-sil`; gizlilik politikası ve KVKK metni sitede
herkese açık: `/gizlilik`, `/kvkk` — site (`~/WebstormProjects/milktrace-site`) bu dosyaları
kopyalar; burada değiştirince sitede `scripts/sync-legal.sh` koş. `>` alıntılar (taslak
notları) yayımlanmaz. Yurt dışı aktarım dayanağı Kurul'un standart sözleşmesi: sağlayıcılarla
imzalanıp 5 iş günü içinde Kurul'a bildirilmesi işletme sahibinin (Taner) işi.
