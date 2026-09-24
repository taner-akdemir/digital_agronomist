import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/alert.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_milking.dart';
import 'package:milktrace/data/models/animal_note.dart';
import 'package:milktrace/data/models/animal_trend.dart';
import 'package:milktrace/data/models/dashboard_summary.dart';
import 'package:milktrace/data/models/device.dart';
import 'package:milktrace/data/models/farm.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/notification_channel.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/spout.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/data/models/vacuum.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_lactation.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/domain/thresholds_engine.dart';
import 'package:milktrace/domain/yield_class.dart';

/// Asset JSON'larından okuyan sahte kaynak.
///
/// Backend hazır olana kadar geliştirme bununla sürer (§15.2). Dosyalar bir
/// kez okunup belleğe alınır — eski Api sınıfı HER çağrıda bundle'dan okuyup
/// yeniden parse ediyordu.
class MockRepository implements MilkTraceRepository {
  MockRepository({
    this.latency = const Duration(milliseconds: 400),
    Random? random,
    DateTime? today,
    Future<String> Function(String assetPath)? loadAsset,
  }) : _random = random ?? Random(7),
       _today = today,
       _loadAsset = loadAsset ?? rootBundle.loadString;

  /// Asset okuyucu.
  ///
  /// Widget testleri diskten okuyan bir işlev veriyor: rootBundle'ın dosya
  /// okuması GERÇEK asenkron iş ve testWidgets'ın sahte saatinde ikinci
  /// ekran kurulumundan itibaren tamamlanmıyordu — liste sonsuza kadar
  /// yükleniyor görünüyordu.
  final Future<String> Function(String assetPath) _loadAsset;

  /// Geçmiş verisinin dayandığı "bugün".
  ///
  /// Testler sabit bir gün verir: üretilen seri tarihe bağlı olduğu için
  /// DateTime.now() ile beklenen değerler her gün kayardı.
  final DateTime? _today;

  /// Şu an. Gün matematiği için [_now] (gün başı) kullanılır.
  DateTime get _clock => _today ?? DateTime.now();

  DateTime get _now => DateTime(_clock.year, _clock.month, _clock.day);

  /// Yapay gecikme: yükleniyor göstergelerinin gerçekten görünmesi için.
  final Duration latency;
  final Random _random;

  final Map<String, Object?> _cache = {};

  Future<T> _load<T>(String name, T Function(dynamic json) parse) async {
    if (_cache.containsKey(name)) return _cache[name] as T;
    final raw = await _loadAsset('assets/data/$name');
    final parsed = parse(jsonDecode(raw));
    _cache[name] = parsed;
    return parsed;
  }

  Future<List<T>> _list<T>(
    String name,
    T Function(Map<String, dynamic>) from,
  ) => _load(
    name,
    (json) => (json as List)
        .map((e) => from(e as Map<String, dynamic>))
        .toList(growable: false),
  );

  Future<T> _delayed<T>(Future<T> Function() body) async {
    await Future<void>.delayed(latency);
    return body();
  }

  @override
  Future<List<Species>> species() =>
      _delayed(() => _list('species.json', Species.fromJson));

  @override
  Future<List<Thresholds>> thresholds() => _delayed(() async {
    final all = await _list('thresholds.json', Thresholds.fromJson);
    return [for (final t in all) _thresholdOverrides[t.speciesId] ?? t];
  });

  /// Kaydedilen eşikler, YAZILMA SIRASIYLA. Testler "kaydet gerçekten bir
  /// şey yaptı mı" sorusunu ancak böyle sorabiliyor.
  List<Thresholds> get thresholdWrites => List.unmodifiable(_thresholdWrites);
  final List<Thresholds> _thresholdWrites = [];

  /// Eşik ayarları ekranında kaydedilen değerler.
  ///
  /// Asset dosyası salt okunur; değişiklikler BELLEKTE tutuluyor ki mock
  /// modda "kaydet" gerçekten bir şey yapsın ve canlı ekranın renkleri
  /// yeni eşiklere göre hesaplansın. Uygulama kapanınca sıfırlanır.
  final Map<String, Thresholds> _thresholdOverrides = {};

  @override
  Future<Thresholds> updateThresholds(Thresholds thresholds) =>
      _delayed(() async {
        _thresholdOverrides[thresholds.speciesId] = thresholds;
        _thresholdWrites.add(thresholds);
        return thresholds;
      });

  @override
  Future<List<Farm>> farms() =>
      _delayed(() => _list('farms.json', Farm.fromJson));

  @override
  Future<List<Hall>> halls() =>
      _delayed(() => _list('halls.json', Hall.fromJson));

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
  Future<List<Device>> devices() => _delayed(() async {
    final all = await _list('devices.json', Device.fromJson);
    return [for (final d in all) d.copyWith(lastSeenAt: _lastSeen(d))];
  });

  /// "Son görülme" damgasını ŞU ANA göre üretir.
  ///
  /// Asset'teki damga sabit: demo hangi gün yapılırsa yapılsın çevrimiçi bir
  /// sayaç "3 gün önce görüldü" diyordu ve Cihazlar ekranı kendi kendisiyle
  /// çelişiyordu. Çevrimiçi sayaç saniyeler, çevrimdışı sayaç dakikalar önce
  /// görülmüş sayılır; takılı olmayanın damgası yoktur.
  DateTime? _lastSeen(Device d) {
    final jitter = d.id.hashCode.abs();
    return switch (d.status) {
      'online' => _clock.subtract(Duration(seconds: 3 + jitter % 40)),
      'offline' => _clock.subtract(Duration(minutes: 12 + jitter % 50)),
      _ => null,
    };
  }

  @override
  Future<List<Animal>> animals() => _delayed(() async {
    final base = await _list('animals.json', Animal.fromJson);
    // Kaydedilenler asset'in ÜSTÜNE: düzenlenen yerini alır, yeni eklenir.
    final out = [
      for (final a in base) _savedAnimals[a.id] ?? a,
      for (final a in _savedAnimals.values)
        if (!base.any((b) => b.id == a.id)) a,
    ];
    return out;
  });

  /// Mock'ta yazılan notlar (hayvan → notlar, en yeni başta).
  final Map<String, List<AnimalNote>> _notes = {};

  @override
  Future<List<AnimalNote>> animalNotes(String animalId) =>
      _delayed(() async => List.unmodifiable(_notes[animalId] ?? const []));

  @override
  Future<AnimalNote> addAnimalNote(String animalId, String note) =>
      _delayed(() async {
        final n = AnimalNote(
          id: 'mock-note-${(_notes[animalId]?.length ?? 0) + 1}',
          animalId: animalId,
          note: note.trim(),
          authorName: 'Demo Kullanıcı',
          createdAt: DateTime.now().toUtc(),
        );
        (_notes[animalId] ??= []).insert(0, n);
        return n;
      });

  /// Mock'ta kaydedilen hayvanlar (id → hayvan).
  final Map<String, Animal> _savedAnimals = {};

  @override
  Future<Animal> saveAnimal(Animal a) => _delayed(() async {
    final saved = a.id.isEmpty
        ? a.copyWith(id: 'mock-animal-${_savedAnimals.length + 1}')
        : a;
    _savedAnimals[saved.id] = saved;
    return saved;
  });

  @override
  Future<LiveSession> liveSession({required String hallId}) => _delayed(
    () async {
      final live = await _load(
        'live_session.json',
        (json) => LiveSession.fromJson(json as Map<String, dynamic>),
      );

      if (_sessionEnded) {
        // Oturum yok: ekran "Sağımı Başlat" diyebilsin. Boş liste
        // "oturum var ama nokta yok" ile karışırdı.
        return LiveSession(
          session: MilkingSession(id: '', hallId: hallId, status: 'none'),
        );
      }

      final updates = [for (final u in live.updates) await _withAssignment(u)];

      // Mock'ta tek bir oturum var; istenen bölgeye uyarlanır ki bölge
      // değiştirildiğinde ekran boş kalmasın.
      return live.copyWith(
        session: live.session.copyWith(hallId: hallId),
        updates: updates,
      );
    },
  );

  /// Elle eşleştirilmiş noktaya hayvanı yazar.
  ///
  /// Hayvan bulunamazsa nokta OLDUĞU GİBİ kalır: mock verisiyle tutarsız
  /// bir kimlik yüzünden canlı ekranı düşürmek orantısız olurdu.
  Future<SpoutUpdate> _withAssignment(SpoutUpdate u) async {
    final animalId = _assignments[u.spoutId];
    if (animalId == null) return u;

    final animals = await _list('animals.json', Animal.fromJson);
    final animal = animals.where((a) => a.id == animalId).firstOrNull;
    if (animal == null) return u;

    final species = await _list('species.json', Species.fromJson);
    final code = species
        .where((sp) => sp.id == animal.speciesId)
        .firstOrNull
        ?.code;

    // Elle eşleştirme tanınmayan küpe uyarısını siler (backend de yeni
    // sağım açılınca siliyor).
    return u.copyWith(
      unmatchedTag: null,
      animal: SpoutAnimal(
        id: animal.id,
        earTag: animal.earTag,
        species: code,
        name: animal.name,
      ),
    );
  }

  @override
  Stream<SpoutUpdate> watchSession(String sessionId) async* {
    final live = await _load(
      'live_session.json',
      (json) => LiveSession.fromJson(json as Map<String, dynamic>),
    );

    final updates = List<SpoutUpdate>.from(live.updates);

    // Sağımın başından beri geçen süre. TAKİP EDİLMEK ZORUNDA: §6.2'nin
    // ısınma kuralı bu değere bakıyor ve sabit bir sayı verilirse sağımın
    // ilk saniyelerindeki düşük debi yanlışlıkla KIRMIZI görünür.
    final elapsed = <String, int>{
      for (final u in updates) u.spoutId: _initialElapsed(u),
    };

    // Gerçek cihaz 1-2 sn aralıkla telemetri gönderir (§9.2).
    const tick = Duration(seconds: 2);
    while (true) {
      await Future<void>.delayed(tick);
      for (var i = 0; i < updates.length; i++) {
        final u = updates[i];
        if (u.state == SpoutState.milking) {
          elapsed[u.spoutId] = (elapsed[u.spoutId] ?? 0) + tick.inSeconds;
        }
        final next = _advance(u, elapsed[u.spoutId] ?? 0);
        updates[i] = next;
        yield await _withAssignment(next);
      }
    }
  }

  /// Fixture'daki bir kaydın sağımın neresinde olduğunu hacimden tahmin eder.
  ///
  /// Gerçek payload elapsed taşımaz (§8.5); backend bunu oturum başlangıcından
  /// hesaplar. Mock'ta yaklaşık bir değer yeterli — önemli olan ısınma
  /// fazındaki bir noktanın ısınmada KALMASI.
  int _initialElapsed(SpoutUpdate u) {
    if (u.flowRate <= 0) return 0;
    final minutes = u.volumeMl / (u.flowRate * 1000);
    return (minutes * 60).round();
  }

  /// Bir noktayı bir adım ilerletir: hacim birikir, debi biraz dalgalanır.
  ///
  /// Renkler YENİDEN HESAPLANIR — mock'ta backend yok, o yüzden aynanın
  /// (ThresholdsEngine) çalıştığı tek yer burasıdır.
  SpoutUpdate _advance(SpoutUpdate u, int elapsedSec) {
    if (u.state != SpoutState.milking) return u;

    final jitter = (_random.nextDouble() - 0.5) * 0.2;
    final flow = (u.flowRate + jitter).clamp(0.0, 9.0);
    final volume = u.volumeMl + (flow * 1000 * 2 / 60).round();

    return u.copyWith(
      flowRate: double.parse(flow.toStringAsFixed(2)),
      volumeMl: volume,
      yieldPct: ThresholdsEngine.yieldPct(volume, u.expectedMl),
      flowColor: ThresholdsEngine.flowColor(
        flowLpm: flow,
        elapsedSec: elapsedSec,
        volumeMl: volume,
        expectedMl: u.expectedMl,
        attached: true,
        animalAssigned: u.animal != null,
        t: ThresholdsEngine.cowDefaults,
      ),
      yieldColor: ThresholdsEngine.yieldColor(
        volume,
        u.expectedMl,
        ThresholdsEngine.cowDefaults,
      ),
    );
  }

  @override
  Future<List<MilkingSession>> sessions({
    String? hallId,
    DateTime? from,
    DateTime? to,
  }) => _delayed(() async {
    final halls = await _list('halls.json', Hall.fromJson);
    final live = await _load(
      'live_session.json',
      (json) => LiveSession.fromJson(json as Map<String, dynamic>),
    );

    final out = <MilkingSession>[];

    // Açık oturum EN ÜSTTE ve canlı ekrandakiyle AYNI kayıt: iki ekranın
    // aynı anda farklı oturum göstermesi mock'u güvenilmez yapardı.
    if (hallId == null || live.session.hallId == hallId) {
      out.add(live.session);
    }

    for (var back = 0; back < 14; back++) {
      final day = _now.subtract(Duration(days: back));
      if (from != null && day.isBefore(from)) continue;
      if (to != null && day.isAfter(to)) continue;

      for (final hall in halls) {
        if (hallId != null && hall.id != hallId) continue;
        for (final type in const ['evening', 'morning']) {
          final started = DateTime(
            day.year,
            day.month,
            day.day,
            type == 'morning' ? 6 : 18,
            5,
          );
          // HENÜZ OLMAMIŞ sağım listelenmez: bugünün akşam sağımı sabah
          // yapılan bir demoda "geçmiş"te görünüyordu.
          if (started.isAfter(_clock)) continue;
          if (back == 0 &&
              hall.id == live.session.hallId &&
              type == live.session.type) {
            continue; // az önce eklenen açık oturumun kendisi
          }

          out.add(
            MilkingSession(
              id: 'mock-${hall.id}-${day.toIso8601String().substring(0, 10)}-$type',
              hallId: hall.id,
              type: type,
              startedAt: started,
              endedAt: started.add(const Duration(minutes: 75)),
              status: 'ended',
            ),
          );
        }
      }
    }
    return List.unmodifiable(out);
  });

  @override
  Future<List<AnimalMilking>> animalHistory(
    String animalId, {
    DateTime? from,
    DateTime? to,
  }) => _delayed(() async {
    final (animal, t) = await _animalWithThresholds(animalId);
    return MockLactation.history(animal, t, _now, from: from, to: to);
  });

  @override
  Future<AnimalTrend> animalTrend(String animalId) => _delayed(() async {
    final (animal, t) = await _animalWithThresholds(animalId);
    return MockLactation.trend(animal, t, _now);
  });

  /// Hayvan + TÜRÜNÜN eşikleri.
  ///
  /// Eşikler tür bazındadır (§4) ve keçi ile ineğin beklenen verimi on kat
  /// farklı; inek varsayılanını herkese uygulamak keçilerin tamamını
  /// "süt vermiyor" gösterirdi.
  Future<(Animal, Thresholds)> _animalWithThresholds(String animalId) async {
    final animals = await _list('animals.json', Animal.fromJson);
    final animal = animals.firstWhere(
      (a) => a.id == animalId,
      orElse: () => throw ArgumentError('mock: hayvan yok: $animalId'),
    );

    final all = await _list('thresholds.json', Thresholds.fromJson);
    final t = all.firstWhere(
      (x) => x.speciesId == animal.speciesId,
      orElse: () => ThresholdsEngine.cowDefaults,
    );
    return (animal, t);
  }

  // ------------------------------------------------------ bildirim kanalları

  @override
  Future<List<NotificationProvider>> notificationProviders() => _delayed(
    () => _list('notification_providers.json', NotificationProvider.fromJson),
  );

  /// Bildirim kanalları BELLEKTE: asset'teki demo kanalla başlar, eklenen ve
  /// değiştirilenler uygulama kapanınca sıfırlanır. Sırlar ayrı tutulur ve
  /// backend gibi GERİ DÖNMEZ; yalnızca ayarlı olup olmadıkları görünür.
  Map<String, NotificationChannel>? _channels;
  final Map<String, Map<String, String>> _channelSecrets = {};
  int _channelSeq = 0;

  Future<Map<String, NotificationChannel>> _channelMap() async {
    if (_channels case final map?) return map;
    final seeded = await _list(
      'notification_channels.json',
      NotificationChannel.fromJson,
    );
    // Asset'teki kanalın sırrı "kayıtlı" işaretli ama değeri yok. Yer tutucu
    // saklanmazsa ilk güncellemede sır kaybolmuş görünürdü; gerçek backend
    // gönderilmeyen sırrı korur.
    for (final c in seeded) {
      _channelSecrets[c.id] = {
        for (final e in c.secrets.entries)
          if (e.value) e.key: 'demo',
      };
    }
    return _channels = {for (final c in seeded) c.id: c};
  }

  @override
  Future<List<NotificationChannel>> notificationChannels() =>
      _delayed(() async => (await _channelMap()).values.toList());

  @override
  Future<NotificationChannel> createNotificationChannel(
    NotificationChannelDraft draft,
  ) => _delayed(() async {
    final spec = await _providerSpec(draft.kind, draft.provider);
    final id = 'mock-channel-${++_channelSeq}';
    final channel = _applyDraft(
      NotificationChannel(
        id: id,
        name: draft.name,
        kind: draft.kind,
        provider: draft.provider,
        createdAt: _clock,
      ),
      spec,
      draft,
      previousSecrets: const {},
    );
    (await _channelMap())[id] = channel;
    return channel;
  });

  @override
  Future<NotificationChannel> updateNotificationChannel(
    String id,
    NotificationChannelDraft draft,
  ) => _delayed(() async {
    final map = await _channelMap();
    final old = map[id];
    if (old == null) {
      throw const ApiException(
        code: 'NOT_FOUND',
        message: 'kanal bulunamadı',
        status: 404,
      );
    }
    final spec = await _providerSpec(old.kind, old.provider);
    final channel = _applyDraft(
      old,
      spec,
      draft,
      previousConfig: old.config,
      previousSecrets: _channelSecrets[id] ?? const {},
    );
    map[id] = channel;
    return channel;
  });

  @override
  Future<void> deleteNotificationChannel(String id) => _delayed(() async {
    (await _channelMap()).remove(id);
    _channelSecrets.remove(id);
  });

  /// Demo modda gerçek gönderim yok; kanal varsa başarılı sayılır.
  @override
  Future<void> testNotificationChannel(String id) => _delayed(() async {
    if (!(await _channelMap()).containsKey(id)) {
      throw const ApiException(
        code: 'NOT_FOUND',
        message: 'kanal bulunamadı',
        status: 404,
      );
    }
  });

  Future<NotificationProvider> _providerSpec(
    String kind,
    String provider,
  ) async {
    final specs = await _list(
      'notification_providers.json',
      NotificationProvider.fromJson,
    );
    return specs.firstWhere(
      (s) => s.kind == kind && s.provider == provider,
      orElse: () => throw const ApiException(
        code: 'VALIDATION',
        message: 'bilinmeyen kanal türü ya da sağlayıcı',
        status: 422,
      ),
    );
  }

  /// Backend'in birleştirme kuralı: gönderilmeyen ayar korunur, boş dize
  /// siler; zorunlu alan eksikse aynı Türkçe hata.
  NotificationChannel _applyDraft(
    NotificationChannel base,
    NotificationProvider spec,
    NotificationChannelDraft draft, {
    Map<String, String> previousConfig = const {},
    required Map<String, String> previousSecrets,
  }) {
    final merged = {...previousConfig, ...previousSecrets};
    draft.config.forEach(
      (k, v) => v.isEmpty ? merged.remove(k) : merged[k] = v,
    );
    for (final f in spec.fields) {
      if (f.required && (merged[f.name] ?? '').trim().isEmpty) {
        throw ApiException(
          code: 'VALIDATION',
          message: '${f.name} ayarı gerekli',
          status: 422,
        );
      }
    }
    // Backend ile aynı: 0 türün varsayılanı, aralık dışı reddedilir.
    if (draft.dailyLimit < 0 || draft.dailyLimit > 10000) {
      throw const ApiException(
        code: 'VALIDATION',
        message: 'günlük sınır 1 ile 10000 arasında olmalı (0: varsayılan)',
        status: 422,
      );
    }
    final limit = draft.dailyLimit == 0 ? null : draft.dailyLimit;
    final secretNames = {
      for (final f in spec.fields)
        if (f.secret) f.name,
    };
    _channelSecrets[base.id] = {
      for (final e in merged.entries)
        if (secretNames.contains(e.key)) e.key: e.value,
    };
    return base.copyWith(
      name: draft.name,
      config: {
        for (final e in merged.entries)
          if (!secretNames.contains(e.key)) e.key: e.value,
      },
      secrets: {for (final s in secretNames) s: merged[s]?.isNotEmpty == true},
      recipients: draft.recipients,
      minSeverity: draft.minSeverity,
      sendResolved: draft.sendResolved,
      enabled: draft.enabled,
      sources: draft.sources,
      dailyLimit: limit,
      effectiveDailyLimit: limit ?? spec.defaultDailyLimit,
      updatedAt: _clock,
    );
  }

  /// Okundu işaretlenen uyarılar.
  ///
  /// Asset dosyası salt okunurdur; onaylar BELLEKTE tutulur ki mock modda
  /// "okundu" düğmesi gerçekten bir şey yapsın. Uygulama kapanınca sıfırlanır.
  final Map<String, DateTime> _acks = {};

  @override
  Future<List<Alert>> alerts() => _delayed(() async {
    final all = await _list('alerts.json', Alert.fromJson);
    return [
      for (final a in all)
        if (_acks[a.id] case final at?)
          a.copyWith(acknowledgedAt: at, acknowledgedBy: 'demo')
        else
          a,
    ];
  });

  @override
  Future<void> ackAlert(String alertId) =>
      _delayed(() async => _acks[alertId] = _clock);

  /// Günün özeti.
  ///
  /// Diğer ekranlarla AYNI kaynaklardan hesaplanır (aynı üretilmiş geçmiş,
  /// aynı uyarı dosyası): dashboard'un toplamıyla hayvan detayındaki
  /// sağımların toplamı tutmazsa mock'a kimse güvenmez.
  @override
  Future<DashboardSummary> dashboard() => _delayed(() async {
    final animals = await _list('animals.json', Animal.fromJson);
    final thresholds = await _list('thresholds.json', Thresholds.fromJson);

    var totalMl = 0;
    var milkingCount = 0;
    final milkedAnimals = <String>{};
    final speciesMl = <String, int>{};
    final speciesAnimals = <String, Set<String>>{};

    for (final animal in animals) {
      final t = thresholds.firstWhere(
        (x) => x.speciesId == animal.speciesId,
        orElse: () => ThresholdsEngine.cowDefaults,
      );

      for (final m in MockLactation.history(animal, t, _now, from: _now)) {
        // HENÜZ OLMAMIŞ sağım sayılmaz: sabah yapılan bir demoda akşam
        // sağımı da toplama giriyordu ve gün ortasında günlük toplam
        // akşamki değerini gösteriyordu.
        if (m.startedAt == null || m.startedAt!.isAfter(_clock)) continue;

        totalMl += m.volumeMl;
        milkingCount++;
        milkedAnimals.add(animal.id);
        speciesMl.update(
          animal.speciesId,
          (v) => v + m.volumeMl,
          ifAbsent: () => m.volumeMl,
        );
        (speciesAnimals[animal.speciesId] ??= {}).add(animal.id);
      }
    }

    final counts = <YieldClass, int>{for (final c in YieldClass.values) c: 0};
    for (final a in animals) {
      counts[a.yieldClass] = (counts[a.yieldClass] ?? 0) + 1;
    }

    final alertList = await alerts();
    final sessionList = await sessions();

    return DashboardSummary(
      date: _now,
      totalMl: totalMl,
      milkingCount: milkingCount,
      animalCount: milkedAnimals.length,
      activeSessions: sessionList.where((s) => s.status == 'active').length,
      openAlerts: alertList.where((a) => !a.isAcknowledged).length,
      bySpecies: [
        for (final entry in speciesMl.entries)
          SpeciesTotal(
            speciesId: entry.key,
            totalMl: entry.value,
            animalCount: speciesAnimals[entry.key]?.length ?? 0,
          ),
      ],
      classDistribution: [
        for (final entry in counts.entries)
          YieldClassCount(yieldClass: entry.key, count: entry.value),
      ],
    );
  });

  /// Kayıtlı push jetonları.
  ///
  /// Mock'ta gidecek bir sunucu yok; yine de TUTULUYOR, çünkü "jeton
  /// kaydedildi mi, çıkışta silindi mi" sorusunun cevabı ancak böyle
  /// doğrulanabiliyor.
  final List<String> pushTokens = [];

  @override
  Future<void> registerPushToken({
    required String token,
    required String platform,
  }) => _delayed(() async => pushTokens.add(token));

  @override
  Future<void> unregisterPushToken(String token) =>
      _delayed(() async => pushTokens.remove(token));

  @override
  Future<int> sendTestPush() => _delayed(() async => pushTokens.length);

  // ------------------------------------------------- sağım kontrolü --

  /// Oturum kapatıldı mı.
  ///
  /// Varsayılan AÇIK: mock modun amacı demo ve o demonun canlı ekranı dolu
  /// açılmalı. "Sağımı Bitir"e basılınca kapanıyor ki düğme gerçekten bir
  /// şey yapsın; "Sağımı Başlat" tekrar açıyor.
  bool _sessionEnded = false;

  /// Noktalara elle yapılan eşleştirmeler (spoutId -> animalId).
  ///
  /// Canlı görüntüye UYGULANIR: eşleştirme yapıldığında kartın gri kalması,
  /// düğmenin çalışmadığı izlenimi verirdi.
  final Map<String, String> _assignments = {};

  @override
  Future<MilkingSession> startSession({
    required String hallId,
    required String type,
  }) => _delayed(() async {
    final live = await _load(
      'live_session.json',
      (json) => LiveSession.fromJson(json as Map<String, dynamic>),
    );

    // Fixture'daki oturum YENİDEN KULLANILIR: canlı ekran, geçmiş ve
    // dashboard hep o kimliğe bakıyor. Yeni bir kimlik üretmek mock'u
    // kendi içinde tutarsız yapardı.
    _sessionEnded = false;
    return live.session.copyWith(hallId: hallId, type: type, status: 'active');
  });

  @override
  Future<void> assignAnimal({
    required String sessionId,
    required String spoutId,
    required String animalId,
  }) => _delayed(() async => _assignments[spoutId] = animalId);

  @override
  Future<MilkingSession> endSession(String sessionId) => _delayed(() async {
    final live = await _load(
      'live_session.json',
      (json) => LiveSession.fromJson(json as Map<String, dynamic>),
    );

    _sessionEnded = true;
    _assignments.clear();
    return live.session.copyWith(status: 'ended', endedAt: _clock);
  });
}
