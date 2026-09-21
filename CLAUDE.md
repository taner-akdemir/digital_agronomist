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
| Canlı veri | `web_socket_channel` + yeniden bağlanma; ilk yükleme `GET /sessions/{id}/live` |
| Depolama | Token → `flutter_secure_storage`; basit ayarlar → `shared_preferences` |
| Model | `freezed` + `json_serializable`. Elle `fromJson` YAZILMAZ. |
| Navigasyon | `go_router` + `StatefulShellRoute` (4 sekme) |
| Veri katmanı | `MilkTraceRepository` arayüzü + `MockRepository` / `ApiRepository` |

**Mock ↔ gerçek geçişi:** `--dart-define=MT_API=mock` (varsayılan) veya `http`. Backend hazır
olana kadar mock ile geliştirilir. Mock asset'leri gerçek API'nin şekliyle birebir aynıdır;
geçiş bir bayrak değişimidir, yeniden yazım değil.

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

Şu anki faz: **Faz 2 — gerçek API bağlantısı** (§17).

Uygulama artık **varsayılan olarak gerçek API'ye** bağlanır (`MT_API=http`). Giriş, oturum
yenileme, oturumu geri yükleme ve çıkış çalışır; bölge/ünite/nokta/cihaz/hayvan verisi
gateway'den gelir.

**Canlı sağım akışı hâlâ mock'tur** ve bu geçicidir: `milking` servisinin HTTP katmanı
(`/sessions`, `/ws`) Faz 3'te yazılacak. Köprü `ApiWithMockLiveRepository`'de ve tek
commit'te silinecek şekilde izole; hangi metodun nereye gittiği orada tek tek yazılı.

Dashboard, Geçmiş ve Cihazlar sekmeleri **iskelet**tir. Push bildirimleri (FCM) ve trend
grafikleri Faz 3–4'e aittir; şimdi yazılmaz.

Mock moda dönmek: `flutter run --dart-define=MT_API=mock`. O modda kimlik sunucusu
olmadığı için giriş ekranı atlanır ve demo kullanıcısıyla çalışılır.
