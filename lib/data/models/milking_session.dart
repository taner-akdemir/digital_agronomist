import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:milktrace/data/models/spout_update.dart';

part 'milking_session.freezed.dart';
part 'milking_session.g.dart';

/// Sağım Oturumu — bir bölgede başlatılan toplu sağım (§4, §8.4).
@freezed
abstract class MilkingSession with _$MilkingSession {
  const factory MilkingSession({
    required String id,
    required String hallId,

    /// morning | evening | other. Beklenen verim hesabı oturum tipine göre
    /// ayrışır: sabah sağımı akşamdan düzenli olarak yüksektir (§6.3).
    @Default('morning') String type,
    DateTime? startedAt,
    DateTime? endedAt,
    @Default('active') String status,
  }) = _MilkingSession;

  factory MilkingSession.fromJson(Map<String, dynamic> json) =>
      _$MilkingSessionFromJson(json);
}

/// `GET /sessions/{id}/live` yanıtı: oturum + noktaların anlık durumu (§8.5).
@freezed
abstract class LiveSession with _$LiveSession {
  const factory LiveSession({
    required MilkingSession session,
    @Default(<SpoutUpdate>[]) List<SpoutUpdate> updates,
  }) = _LiveSession;

  factory LiveSession.fromJson(Map<String, dynamic> json) =>
      _$LiveSessionFromJson(json);
}
