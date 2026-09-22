import 'package:milktrace/data/models/alert.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_milking.dart';
import 'package:milktrace/data/models/animal_trend.dart';
import 'package:milktrace/data/models/dashboard_summary.dart';
import 'package:milktrace/data/models/device.dart';
import 'package:milktrace/data/models/farm.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/spout.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/data/models/vacuum.dart';

/// Uygulamanın veri kaynağı sözleşmesi (§15.2).
///
/// İki implementasyonu vardır: MockRepository (asset JSON) ve ApiRepository
/// (dio + WebSocket). Ekranlar YALNIZCA bu arayüzü bilir; hangisinin
/// kullanıldığı repositoryProvider'da seçilir.
///
/// Mock asset'leri gerçek API'nin şekliyle birebir aynı olduğu için geçiş
/// bir bayrak değişimidir, yeniden yazım değil.
abstract interface class MilkTraceRepository {
  Future<List<Species>> species();
  Future<List<Thresholds>> thresholds();

  /// Bir türün eşiklerini günceller (§8.5 PUT /species/thresholds, owner).
  ///
  /// VARSAYIM: §8.5 yolu veriyor ama gövde şeklini vermiyor. Tek türün tam
  /// nesnesi gönderiliyor; kısmi güncelleme yerine tam nesne, iki kullanıcı
  /// aynı anda kaydettiğinde hangi alanın kazandığını belirsiz bırakmıyor.
  ///
  /// Dönen kayıt SUNUCUNUNKİdir: backend değerleri kırpabilir ya da
  /// normalize edebilir ve ekran kendi yazdığını doğru sanmamalı.
  Future<Thresholds> updateThresholds(Thresholds thresholds);

  Future<List<Farm>> farms();
  Future<List<Hall>> halls();
  Future<List<Vacuum>> vacuums({String? hallId});
  Future<List<Spout>> spouts({String? vacuumId});
  Future<List<Device>> devices();

  Future<List<Animal>> animals();

  /// Bölgedeki aktif oturumun ilk yüklemesi (§8.5 GET /sessions/{id}/live).
  Future<LiveSession> liveSession({required String hallId});

  /// Sağım başlatır (§8.5 POST /sessions).
  ///
  /// Tip TAHMİN EDİLMEZ, çağıran verir: backend de saate bakarak tahmin
  /// etmiyor çünkü beklenen verim oturum tipine göre ayrışıyor (§6.3) ve
  /// yanlış tahmin tüm renkleri sessizce kaydırırdı.
  Future<MilkingSession> startSession({
    required String hallId,
    required String type,
  });

  /// Noktaya hayvan eşleştirir (§8.5 PUT .../spouts/{spoutId}/animal).
  ///
  /// EŞLEŞTİRME OLMADAN RENK YOKTUR: hayvanı olmayan nokta §6.2 kural 1
  /// gereği gri kalır ve beklenen verim hesaplanamaz. Sağımın ilk işi bu.
  Future<void> assignAnimal({
    required String sessionId,
    required String spoutId,
    required String animalId,
  });

  /// Sağımı bitirir (§8.5 POST /sessions/{id}/end).
  Future<MilkingSession> endSession(String sessionId);

  /// Canlı güncellemeler (§8.5 WS /ws?sessionId=).
  ///
  /// İlk yükleme liveSession() ile yapılır; bu akış onun üzerine gelen
  /// değişiklikleri taşır.
  Stream<SpoutUpdate> watchSession(String sessionId);

  /// Geçmiş oturumlar (§8.5 GET /sessions?hallId&from&to).
  ///
  /// Canlı akıştaki liveSession() ile aynı ucu kullanır ama amacı başka:
  /// orada AÇIK oturum aranır, burada kapanmışlar listelenir.
  Future<List<MilkingSession>> sessions({String? hallId, DateTime? from, DateTime? to});

  /// Bir hayvanın sağım geçmişi (§8.5 GET /animals/{id}/history?from&to).
  ///
  /// Yeniden eskiye sıralı gelir: geçmiş listesinde son sağım en üsttedir.
  Future<List<AnimalMilking>> animalHistory(String animalId,
      {DateTime? from, DateTime? to});

  /// Bir hayvanın 7/30 gün trendi ve sınıfı (§8.5 GET /animals/{id}/trend).
  Future<AnimalTrend> animalTrend(String animalId);

  /// Günün özeti ve sınıf dağılımı (§8.5 GET /dashboard).
  Future<DashboardSummary> dashboard();

  /// Uyarılar (§8.5 GET /alerts). Yeniden eskiye sıralı.
  Future<List<Alert>> alerts();

  /// Push jetonunu kullanıcıya bağlar.
  ///
  /// VARSAYIM: §8.5 bu ucu listelemiyor. FCM jetonu bir yere yazılmadan
  /// `notification` servisi kime push atacağını bilemez; yol o servis
  /// yazılırken doğrulanmalı (§18).
  Future<void> registerPushToken({required String token, required String platform});

  /// Jetonun bağını koparır: çıkış yapan kullanıcının telefonuna, artık onun
  /// olmayan sürünün uyarıları gitmemeli.
  Future<void> unregisterPushToken(String token);

  /// Uyarıyı okundu işaretler (§8.5 POST /alerts/{id}/ack).
  ///
  /// Dönüş yok: güncel kaydı sunucudan tekrar okumak, iki kullanıcının aynı
  /// uyarıyı kapattığı durumda da doğru sonucu verir.
  Future<void> ackAlert(String alertId);
}
