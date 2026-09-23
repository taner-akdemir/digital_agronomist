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
| Depolama | Token → `flutter_secure_storage`; basit ayarlar → `shared_preferences` |
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

`Env.wsBaseUrl`, `apiBaseUrl`'den **türetilir** (`http` → `ws`): ayrı tanımlansaydı biri
değişip diğeri unutulduğunda canlı ekran sessizce bağlanamazdı.

**Geçmiş sekmesi tamamdır** (§15.1): oturum listesi, tür/sınıf filtreli hayvan listesi ve
hayvan detayı — sınıf rozeti (§6.4), 7/30 gün ortalaması, 30 günlük eğilim, 90 günlük verim
grafiği (fl_chart) ve son sağımlar. Uçlar `GET /sessions`, `/animals/{id}/history`,
`/animals/{id}/trend`.

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

Burada çevrimdışı **kırmızıdır**, §6.2'deki gri DEĞİL: §6.2 canlı tabloda AKIŞIN olmamasını
anlatıyor, bu ekran cihazın kendisini. Çevrimdışı sayaç müdahale gerektirir.

**Push bildirimleri yazıldı ama HENÜZ KAPALI:** Firebase projesi bağlanmadı. Uygulama
bunu bir hata saymaz — `Firebase.initializeApp()` düşünce `FirebasePushGateway` log atıp
`null` döner, `PushRegistration` `unavailable` durumunda kalır ve sağım push'suz sürer.
Proje bağlandığında **hiçbir Dart dosyası değişmez**; adımlar §7'de.

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
- PUT gövdesi VARSAYIMDIR: §8.5 yolu veriyor, gövde şeklini vermiyor. Tam nesne
  gönderiliyor — kısmi güncelleme, iki kullanıcı aynı anda kaydettiğinde hangi alanın
  kazandığını belirsiz bırakırdı.

**Profil ekranı = hesap kartıdır** (`showAccountSheet`). Ayrı bir sayfa açılmadı: dört
sekmenin hiçbirine ait olmadığı için kabuğun üstünde tam ekran bir sayfa gezinme yığınını
karıştırırdı. Kartta ad, e-posta, **rol** ve eşik ayarları bağlantısı var; rol görünür
olmalı çünkü eşiklerin neden salt okunur açıldığının cevabı orada.

Mock moda dönmek: `flutter run --dart-define=MT_API=mock`. O modda kimlik sunucusu
olmadığı için giriş ekranı atlanır ve demo kullanıcısıyla çalışılır.

---

## 7. Firebase / push bağlama

Kod tarafı hazır; eksik olan tek şey Firebase projesi. `google-services.json` olmadan da
derlendiği için `com.google.gms.google-services` Gradle eklentisi **bilerek eklenmedi** —
eklenseydi dosya yokken `assembleDebug` kırılırdı.

**Proje bağlanınca yapılacaklar:**

1. Firebase Console'da proje aç; Android uygulaması ekle — applicationId
   `com.algebran.milktrace.milktrace`. iOS için bundle id'yi ekle.
2. `google-services.json` → `android/app/`, `GoogleService-Info.plist` → `ios/Runner/`.
3. `android/settings.gradle.kts` → plugins bloğuna
   `id("com.google.gms.google-services") version "4.4.2" apply false`;
   `android/app/build.gradle.kts` → plugins bloğuna `id("com.google.gms.google-services")`.
4. iOS: APNs anahtarını Firebase'e yükle, Xcode'da **Push Notifications** ve
   **Background Modes → Remote notifications** yeteneklerini aç.
5. Dart tarafında değişiklik YOK. Bunu doğrulamak için mock modda geçici olarak gerçek
   kapı açılıp cihazda denendi: `Firebase.initializeApp` düştü, uygulama normal çalıştı.

**Backend sözleşmesi (`notification` servisi yazılırken doğrulanacak):**

- FCM mesajı **`notification` bloğu taşımalı**. Uygulama kapalıyken bildirimi sistem
  tepsisine Android koyuyor; yalnızca `data` gönderilirse hiçbir şey görünmez. Uygulama
  AÇIKKEN bildirim tepsiye düşmez, o yüzden `flutter_local_notifications` ile elle
  gösteriliyor — kanal kimliği `milktrace_alerts`, AndroidManifest'teki
  `default_notification_channel_id` ile aynı olmak zorunda.
- `data.animalId` varsa bildirime dokunuş `/history/animal/{id}`'ye, yoksa `/alerts`'e
  gider. Bilinmeyen/eksik alan `/alerts`'e düşer (`PushMessage.fromRemote`).
- Metinler Türkçe ve olduğu gibi gösterilir (§16).
- **Jeton uçları VARSAYIMDIR**, §8.5 bunları listelemiyor:
  `POST /me/push-tokens {token, platform}` ve `DELETE /me/push-tokens/{token}`.
  Jeton oturum açılınca yazılır, kapanınca silinir, yenilenince yeniden yazılır.
