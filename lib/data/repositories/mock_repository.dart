import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;
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
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/domain/thresholds_engine.dart';

/// Asset JSON'larından okuyan sahte kaynak.
///
/// Backend hazır olana kadar geliştirme bununla sürer (§15.2). Dosyalar bir
/// kez okunup belleğe alınır — eski Api sınıfı HER çağrıda bundle'dan okuyup
/// yeniden parse ediyordu.
class MockRepository implements MilkTraceRepository {
  MockRepository({this.latency = const Duration(milliseconds: 400), Random? random})
      : _random = random ?? Random(7);

  /// Yapay gecikme: yükleniyor göstergelerinin gerçekten görünmesi için.
  final Duration latency;
  final Random _random;

  final Map<String, Object?> _cache = {};

  Future<T> _load<T>(String name, T Function(dynamic json) parse) async {
    if (_cache.containsKey(name)) return _cache[name] as T;
    final raw = await rootBundle.loadString('assets/data/$name');
    final parsed = parse(jsonDecode(raw));
    _cache[name] = parsed;
    return parsed;
  }

  Future<List<T>> _list<T>(String name, T Function(Map<String, dynamic>) from) =>
      _load(name, (json) => (json as List)
          .map((e) => from(e as Map<String, dynamic>))
          .toList(growable: false));

  Future<T> _delayed<T>(Future<T> Function() body) async {
    await Future<void>.delayed(latency);
    return body();
  }

  @override
  Future<List<Species>> species() =>
      _delayed(() => _list('species.json', Species.fromJson));

  @override
  Future<List<Thresholds>> thresholds() =>
      _delayed(() => _list('thresholds.json', Thresholds.fromJson));

  @override
  Future<List<Farm>> farms() => _delayed(() => _list('farms.json', Farm.fromJson));

  @override
  Future<List<Hall>> halls() => _delayed(() => _list('halls.json', Hall.fromJson));

  @override
  Future<List<Vacuum>> vacuums({String? hallId}) => _delayed(() async {
        final all = await _list('vacuums.json', Vacuum.fromJson);
        if (hallId == null) return all;
        return all.where((v) => v.hallId == hallId).toList(growable: false);
      });

  @override
  Future<List<Spout>> spouts({String? vacuumId}) => _delayed(() async {
        final all = await _list('spouts.json', Spout.fromJson);
        if (vacuumId == null) return all;
        return all.where((s) => s.vacuumId == vacuumId).toList(growable: false);
      });

  @override
  Future<List<Device>> devices() =>
      _delayed(() => _list('devices.json', Device.fromJson));

  @override
  Future<List<Animal>> animals() =>
      _delayed(() => _list('animals.json', Animal.fromJson));

  @override
  Future<LiveSession> liveSession({required String hallId}) => _delayed(() async {
        final live = await _load('live_session.json',
            (json) => LiveSession.fromJson(json as Map<String, dynamic>));

        // Mock'ta tek bir oturum var; istenen bölgeye uyarlanır ki bölge
        // değiştirildiğinde ekran boş kalmasın.
        if (live.session.hallId == hallId) return live;
        return live.copyWith(session: live.session.copyWith(hallId: hallId));
      });

  @override
  Stream<SpoutUpdate> watchSession(String sessionId) async* {
    final live = await _load('live_session.json',
        (json) => LiveSession.fromJson(json as Map<String, dynamic>));

    var updates = List<SpoutUpdate>.from(live.updates);

    // Gerçek cihaz 1-2 sn aralıkla telemetri gönderir (§9.2).
    while (true) {
      await Future<void>.delayed(const Duration(seconds: 2));
      for (var i = 0; i < updates.length; i++) {
        final next = _advance(updates[i]);
        updates[i] = next;
        yield next;
      }
    }
  }

  /// Bir noktayı bir adım ilerletir: hacim birikir, debi biraz dalgalanır.
  ///
  /// Renkler YENİDEN HESAPLANIR — mock'ta backend yok, o yüzden aynanın
  /// (ThresholdsEngine) çalıştığı tek yer burasıdır.
  SpoutUpdate _advance(SpoutUpdate u) {
    if (u.state != SpoutState.milking) return u;

    final jitter = (_random.nextDouble() - 0.5) * 0.2;
    final flow = (u.flowRate + jitter).clamp(0.0, 9.0);
    final volume = u.volumeMl + (flow * 1000 * 2 / 60).round();

    return u.copyWith(
      flowRate: double.parse(flow.toStringAsFixed(2)),
      volumeMl: volume,
      yieldPct: ThresholdsEngine.yieldPct(volume, u.expectedMl),
      // elapsedSec mock'ta bilinmiyor; ısınma fazı geçmiş varsayılır.
      flowColor: ThresholdsEngine.flowColor(
        flowLpm: flow,
        elapsedSec: 999,
        volumeMl: volume,
        expectedMl: u.expectedMl,
        attached: true,
        animalAssigned: u.animal != null,
        t: ThresholdsEngine.cowDefaults,
      ),
      yieldColor: ThresholdsEngine.yieldColor(
          volume, u.expectedMl, ThresholdsEngine.cowDefaults),
    );
  }
}
