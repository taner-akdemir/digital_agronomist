import 'package:milktrace/data/models/animal.dart';
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

  Future<List<Farm>> farms();
  Future<List<Hall>> halls();
  Future<List<Vacuum>> vacuums({String? hallId});
  Future<List<Spout>> spouts({String? vacuumId});
  Future<List<Device>> devices();

  Future<List<Animal>> animals();

  /// Bölgedeki aktif oturumun ilk yüklemesi (§8.5 GET /sessions/{id}/live).
  Future<LiveSession> liveSession({required String hallId});

  /// Canlı güncellemeler (§8.5 WS /ws?sessionId=).
  ///
  /// İlk yükleme liveSession() ile yapılır; bu akış onun üzerine gelen
  /// değişiklikleri taşır.
  Stream<SpoutUpdate> watchSession(String sessionId);
}
