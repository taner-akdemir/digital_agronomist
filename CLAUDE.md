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

Şu anki faz: **Faz 4 — uyarı & trend** (§17).

Uygulama **varsayılan olarak gerçek API'ye** bağlanır (`MT_API=http`). Giriş, oturum
yenileme, oturumu geri yükleme ve çıkış çalışır; bölge/ünite/nokta/cihaz/hayvan verisi
gateway'den gelir. Canlı sağım da artık gerçek uçlardan okunur: açık oturum
`GET /sessions` listesinden seçilir, ilk yükleme `GET /sessions/{id}/live`'dan gelir.
`ApiWithMockLiveRepository` köprüsü **silindi**; mock yalnızca `MT_API=mock` modunda çalışır.

**Canlı akış GEÇİCİ OLARAK yoklamadır (polling), WebSocket değil:** §8.5'teki `/ws` ucunu
sunan `realtime` servisi henüz yazılmadı, bağlanmayı denemek canlı ekranı ilk karede
dondururdu. `ApiRepository.watchSession` 5 saniyede bir `/sessions/{id}/live` okur ve
yalnızca `ts`'si değişen noktaları yayınlar; ağ hatası akışı bitirmez, oturum kapanınca
akış biter. `realtime` gelince **yalnızca bu metot** değişir — ekran ve provider Stream
gördüğü için aynı kalır. Bu yüzden `web_socket_channel` bağımlılığı şimdilik kaldırıldı.

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

**Faz 4'ten kalan:** FCM push (`firebase_messaging` + `flutter_local_notifications`) — bir
Firebase projesi ve `google-services.json` gerekiyor, bu repoda yok. Cihazlar sekmesi
hâlâ **iskelet** (Faz 5, §17).

Mock moda dönmek: `flutter run --dart-define=MT_API=mock`. O modda kimlik sunucusu
olmadığı için giriş ekranı atlanır ve demo kullanıcısıyla çalışılır.
