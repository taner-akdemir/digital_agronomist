import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/alert.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_group.dart';
import 'package:milktrace/data/models/animal_import.dart';
import 'package:milktrace/data/models/animal_milking.dart';
import 'package:milktrace/data/models/animal_note.dart';
import 'package:milktrace/data/models/animal_trend.dart';
import 'package:milktrace/data/models/audit_entry.dart';
import 'package:milktrace/data/models/breeding.dart';
import 'package:milktrace/data/models/dashboard_summary.dart';
import 'package:milktrace/data/models/delivery.dart';
import 'package:milktrace/data/models/device.dart';
import 'package:milktrace/data/models/farm.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/milking_schedule.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/notification_channel.dart';
import 'package:milktrace/data/models/quiet_hours.dart';
import 'package:milktrace/data/models/session_milking.dart';
import 'package:milktrace/data/models/session_summary.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/spout.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/models/team_member.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/data/models/treatment.dart';
import 'package:milktrace/data/models/unmatched_tag_row.dart';
import 'package:milktrace/data/models/user_session.dart';
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
    this._today,
    Future<String> Function(String assetPath)? loadAsset,
  }) : _random = random ?? Random(7),
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
    // Süren arınma (backend ADR 0084) ve üreme durumu (ADR 0088)
    // hayvanın üstünde görünsün.
    final species = await _list('species.json', Species.fromJson);
    return [
      for (final a in out)
        a.copyWith(
          withdrawalUntil: _withdrawalOf(a.id),
          pregnancy: _pregnancyOf(a, species),
          // Grup adı sunucudaki gibi okunurken çözülür (ADR 0092).
          groupId: _groups.containsKey(a.groupId) ? a.groupId : null,
          groupName: _groups[a.groupId]?.name,
        ),
    ];
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

  DateTime? _withdrawalOf(String animalId) {
    DateTime? best;
    for (final t in _treatments[animalId] ?? const <Treatment>[]) {
      if (t.activeOn(_clock) &&
          (best == null || t.withdrawalUntil.isAfter(best))) {
        best = t.withdrawalUntil;
      }
    }
    return best;
  }

  /// Mock'ta üreme kayıtları bellekte (backend ADR 0088).
  final Map<String, List<BreedingEvent>> _breeding = {};
  int _breedingSeq = 0;

  /// Sunucudaki kuralın aynısı (herd store.pregnancyOf).
  Pregnancy? _pregnancyOf(Animal a, List<Species> species) {
    final events = _breeding[a.id] ?? const <BreedingEvent>[];
    if (events.isEmpty) return null;
    DateTime? ins;
    BreedingEvent? check;
    for (final e in events) {
      if (e.isInsemination) {
        if (ins == null || e.eventDate.isAfter(ins)) ins = e.eventDate;
      } else if (check == null || e.eventDate.isAfter(check.eventDate)) {
        check = e;
      }
    }
    final calving = a.lastCalvingDate;
    if (ins != null && calving != null && !ins.isAfter(calving)) ins = null;
    var status = 'open';
    if (check != null &&
        (ins == null || !check.eventDate.isBefore(ins)) &&
        (calving == null || check.eventDate.isAfter(calving))) {
      status = check.result ?? 'open';
    } else if (ins != null) {
      status = 'inseminated';
    }
    if (ins == null || status == 'open') {
      return Pregnancy(status: status, lastInsemination: ins);
    }
    final code = species.where((s) => s.id == a.speciesId).firstOrNull?.code;
    final days = switch (code) {
      'goat' => 150,
      'sheep' => 147,
      _ => 283,
    };
    final expected = ins.add(Duration(days: days));
    return Pregnancy(
      status: status,
      lastInsemination: ins,
      expectedCalving: expected,
      dryOffDate: expected.subtract(const Duration(days: 60)),
    );
  }

  @override
  Future<List<BreedingEvent>> breedingEvents(String animalId) =>
      _delayed(() async => List.unmodifiable(_breeding[animalId] ?? const []));

  @override
  Future<BreedingEvent> addBreeding(
    String animalId, {
    required String kind,
    required DateTime date,
    String sire = '',
    String? result,
    String note = '',
  }) => _delayed(() async {
    final e = BreedingEvent(
      id: 'mock-breeding-${++_breedingSeq}',
      animalId: animalId,
      kind: kind,
      eventDate: date,
      sire: sire.trim(),
      result: kind == 'pregnancy_check' ? result : null,
      note: note.trim(),
      authorName: 'Demo Çiftçi',
    );
    (_breeding[animalId] ??= []).insert(0, e);
    return e;
  });

  @override
  Future<void> deleteBreeding(String animalId, String eventId) => _delayed(
    () async => _breeding[animalId]?.removeWhere((e) => e.id == eventId),
  );

  @override
  Future<List<UpcomingBreeding>> upcomingBreeding({int days = 30}) =>
      _delayed(() async {
        final today = DateTime(_clock.year, _clock.month, _clock.day);
        final from = today.subtract(const Duration(days: 14));
        final to = today.add(Duration(days: days));
        bool inWindow(DateTime? d) =>
            d != null && !d.isBefore(from) && !d.isAfter(to);
        final out = <UpcomingBreeding>[];
        for (final a in await animals()) {
          final p = a.pregnancy;
          if (p == null || p.status == 'open') continue;
          if (a.isMilking && inWindow(p.dryOffDate)) {
            out.add(
              UpcomingBreeding(
                animalId: a.id,
                earTag: a.earTag,
                name: a.name,
                event: 'dry_off',
                date: p.dryOffDate!,
                status: p.status,
              ),
            );
          }
          if (inWindow(p.expectedCalving)) {
            out.add(
              UpcomingBreeding(
                animalId: a.id,
                earTag: a.earTag,
                name: a.name,
                event: 'calving',
                date: p.expectedCalving!,
                status: p.status,
              ),
            );
          }
        }
        out.sort((x, y) => x.date.compareTo(y.date));
        return out;
      });

  /// Mock'ta tedaviler bellekte (backend ADR 0084).
  final Map<String, List<Treatment>> _treatments = {};
  int _treatmentSeq = 0;

  @override
  Future<List<Treatment>> treatments(String animalId) => _delayed(
    () async => List.unmodifiable(_treatments[animalId] ?? const []),
  );

  @override
  Future<Treatment> addTreatment(
    String animalId, {
    required String drug,
    required DateTime startedOn,
    required DateTime withdrawalUntil,
    String note = '',
  }) => _delayed(() async {
    if (withdrawalUntil.isBefore(startedOn)) {
      throw const ApiException(
        code: 'VALIDATION',
        message: 'arınma bitişi başlangıçtan önce olamaz',
        status: 422,
      );
    }
    final t = Treatment(
      id: 'mock-treatment-${++_treatmentSeq}',
      animalId: animalId,
      drug: drug.trim(),
      startedOn: startedOn,
      withdrawalUntil: withdrawalUntil,
      note: note.trim(),
      authorName: 'Demo Çiftçi',
      createdAt: _clock.toUtc(),
    );
    (_treatments[animalId] ??= []).insert(0, t);
    return t;
  });

  @override
  Future<void> deleteTreatment(String animalId, String treatmentId) =>
      _delayed(() async {
        _treatments[animalId]?.removeWhere((t) => t.id == treatmentId);
      });

  /// Mock'ta rapor üretici YOK: .xlsx backend'de yazılıyor (ADR 0064).
  @override
  Future<ReportFile> yieldReport({DateTime? from, DateTime? to}) => _delayed(
    () async => throw const ApiException(
      code: 'NOT_SUPPORTED',
      message: 'Demo modunda rapor yok; gerçek sunucuyla deneyin',
      status: 501,
    ),
  );

  /// Mock'ta dosya okuyucu YOK: CSV/.xlsx çözümü backend'de (ADR 0063) ve
  /// burada ikinci bir kopyası ayrışırdı.
  @override
  Future<AnimalImportReport> importAnimals(
    List<int> file, {
    String? speciesId,
    required bool dryRun,
    bool update = false,
  }) => _delayed(
    () async => throw const ApiException(
      code: 'NOT_SUPPORTED',
      message: 'Demo modunda içe aktarma yok; gerçek sunucuyla deneyin',
      status: 501,
    ),
  );

  @override
  Future<Animal> recordCalving(String animalId, DateTime date) =>
      _delayed(() async {
        final a = (await animals()).firstWhere((x) => x.id == animalId);
        final day = DateTime.utc(date.year, date.month, date.day);
        final last = a.lastCalvingDate;
        // Backend'in kuralları (ADR 0060): aynı gün ikinci kez, önceki
        // buzağılamadan önce reddedilir.
        if (last != null && !day.isAfter(last)) {
          throw day == last
              ? const ApiException(
                  code: 'CONFLICT',
                  message: 'bu tarihte buzağılama zaten kayıtlı',
                  status: 409,
                )
              : const ApiException(
                  code: 'VALIDATION',
                  message: 'buzağılama tarihi son buzağılamadan önce olamaz',
                  status: 422,
                );
        }
        // Yeni laktasyon: eski sınıf taşınmaz (backend ADR 0060).
        final saved = a.copyWith(
          lastCalvingDate: day,
          lactationNo: a.lactationNo + 1,
          status: 'active',
          yieldClass: YieldClass.normal,
          yieldClassAt: null,
        );
        _savedAnimals[saved.id] = saved;
        var note =
            'Buzağıladı: ${day.day.toString().padLeft(2, '0')}.'
            '${day.month.toString().padLeft(2, '0')}.${day.year} '
            '(${saved.lactationNo}. laktasyon)';
        if (!a.isMilking) note += '; durum: ${a.statusLabel} → Sağmal';
        // Biten laktasyonun son sınıfı (backend ADR 0060): yalnızca son
        // buzağılamadan sonra hesaplandıysa.
        final at = a.yieldClassAt;
        if (at != null && (last == null || !at.isBefore(last))) {
          note +=
              '; önceki laktasyon: ${a.yieldClass.label} '
              '(${at.day.toString().padLeft(2, '0')}.'
              '${at.month.toString().padLeft(2, '0')}.${at.year} hesabı)';
        }
        (_notes[saved.id] ??= []).insert(
          0,
          AnimalNote(
            id: 'mock-note-${(_notes[saved.id]?.length ?? 0) + 1}',
            animalId: saved.id,
            note: note,
            authorName: 'Demo Kullanıcı',
            createdAt: DateTime.now().toUtc(),
            kind: 'calving',
          ),
        );
        return saved;
      });

  /// Mock'ta kaydedilen hayvanlar (id → hayvan).
  final Map<String, Animal> _savedAnimals = {};

  @override
  Future<Animal> saveAnimal(Animal a) => _delayed(() async {
    final before = a.id.isEmpty
        ? null
        : (await animals()).where((x) => x.id == a.id).firstOrNull;
    final saved = a.id.isEmpty
        ? a.copyWith(id: 'mock-animal-${_savedAnimals.length + 1}')
        : a;
    _savedAnimals[saved.id] = saved;
    // Backend gibi: durum değiştiyse otomatik not (ADR 0057).
    if (before != null && before.status != saved.status) {
      (_notes[saved.id] ??= []).insert(
        0,
        AnimalNote(
          id: 'mock-note-${(_notes[saved.id]?.length ?? 0) + 1}',
          animalId: saved.id,
          note: 'Durum: ${before.statusLabel} → ${saved.statusLabel}',
          authorName: 'Demo Kullanıcı',
          createdAt: DateTime.now().toUtc(),
          kind: 'status',
        ),
      );
    }
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
    // Eşleştirmesi kaldırılan nokta boşa döner; asset'teki hayvanı ve
    // ölçümü (backend'de silinen sağım) artık görünmez.
    if (_unassigned.contains(u.spoutId)) {
      return SpoutUpdate(
        sessionId: u.sessionId,
        spoutId: u.spoutId,
        ts: u.ts,
        unmatchedTag: u.unmatchedTag,
      );
    }
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

  /// Geçmiş oturumun sağımları: canlı demodaki yerleşim, üstüne boştaki 8.
  /// noktada Gelin — seçicinin "önceki sağımda bu noktadaydı" önerisi
  /// demoda görünsün (backend ADR 0062).
  @override
  Future<List<SessionMilking>> sessionMilkings(String sessionId) =>
      _delayed(() async {
        final live = await _load(
          'live_session.json',
          (json) => LiveSession.fromJson(json as Map<String, dynamic>),
        );
        final at = DateTime.utc(2026, 9, 20, 17, 0);
        return [
          for (final u in live.updates)
            if (u.animal case final a?)
              SessionMilking(
                animalId: a.id,
                earTag: a.earTag,
                spoutId: u.spoutId,
                startedAt: at,
                endedAt: at.add(const Duration(minutes: 7)),
                volumeMl: 9000,
              ),
          SessionMilking(
            animalId: '0192a1f0-0070-7000-8000-000000000008',
            earTag: 'TR340000008',
            spoutId: '0192a1f0-0050-7000-8000-000000000008',
            startedAt: at,
            endedAt: at.add(const Duration(minutes: 7)),
            volumeMl: 8000,
          ),
        ];
      });

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

  /// Demo modda birim yalnızca uygulamada tutulur (Auth.applyVolumeUnit).
  @override
  Future<void> setVolumeUnit(String unit) => _delayed(() async {});

  /// Mock'ta iki oturum: bu telefon ve panel.
  final List<UserSession> _sessions = [
    UserSession(
      id: 's1',
      userAgent: 'MilkTrace/1.0.0 (android)',
      current: true,
      startedAt: DateTime.utc(2026, 9, 1),
      lastUsedAt: DateTime.utc(2026, 9, 29, 6),
    ),
    UserSession(
      id: 's2',
      userAgent: 'Mozilla/5.0 (Macintosh) Chrome/140',
      ip: '85.100.1.2',
      startedAt: DateTime.utc(2026, 9, 20),
      lastUsedAt: DateTime.utc(2026, 9, 28, 18),
    ),
  ];

  @override
  Future<List<UserSession>> loginSessions() =>
      _delayed(() async => List.unmodifiable(_sessions));

  @override
  Future<void> revokeLoginSession(String id) => _delayed(
    () async => _sessions.removeWhere((s) => s.id == id && !s.current),
  );

  @override
  Future<int> revokeOtherLoginSessions() => _delayed(() async {
    final n = _sessions.where((s) => !s.current).length;
    _sessions.removeWhere((s) => !s.current);
    return n;
  });

  /// Mock'ta 2FA bellekte; kod "123456" geçer (demo).
  bool _twoFactor = false;

  @override
  Future<bool> twoFactorEnabled() => _delayed(() async => _twoFactor);

  @override
  Future<({String secret, String uri})> twoFactorSetup() => _delayed(
    () async => (
      secret: 'JBSWY3DPEHPK3PXP',
      uri:
          'otpauth://totp/Milk%20Trace:demo?secret=JBSWY3DPEHPK3PXP&issuer=Milk%20Trace',
    ),
  );

  @override
  Future<List<String>> twoFactorEnable(String code) => _delayed(() async {
    if (code != '123456') {
      throw const ApiException(
        code: 'VALIDATION',
        message:
            'kod tutmadı; telefonun saatini ve girdiğiniz kodu kontrol edin',
        status: 422,
      );
    }
    _twoFactor = true;
    return [for (var i = 0; i < 10; i++) 'demo$i-kod$i'];
  });

  @override
  Future<void> twoFactorDisable({
    required String password,
    required String code,
  }) => _delayed(() async => _twoFactor = false);

  MilkingSchedule _schedule = const MilkingSchedule();
  QuietHours _quiet = const QuietHours();

  @override
  Future<QuietHours> quietHours() => _delayed(() async => _quiet);

  /// Backend ile aynı: açıkken başlangıç ve bitiş aynı olamaz.
  @override
  Future<QuietHours> setQuietHours(QuietHours quiet) => _delayed(() async {
    if (quiet.enabled && quiet.startMinute == quiet.endMinute) {
      throw const ApiException(
        code: 'VALIDATION',
        message: 'sessiz saatin başlangıcı ve bitişi aynı olamaz',
        status: 422,
      );
    }
    return _quiet = quiet;
  });

  @override
  Future<MilkingSchedule> milkingSchedule() => _delayed(() async => _schedule);

  @override
  Future<MilkingSchedule> setMilkingSchedule(MilkingSchedule schedule) =>
      _delayed(() async => _schedule = schedule);

  /// Demo modda silinecek hesap yok (kimlik sunucusu yok).
  @override
  Future<void> deleteMyAccount(String password) => _delayed(() async {});

  /// Mock'ta oturum özeti: sağım kaydı üretilmiş geçmişte tutulmadığı
  /// için sağmal hayvanlardan sabit bir örnek (ADR 0094).
  @override
  Future<SessionSummary> sessionSummary(String sessionId) => _delayed(() async {
    final milking = (await animals()).where((a) => a.isMilking).toList();
    final skipped = milking.length > 3
        ? milking.sublist(milking.length - 1)
        : const <Animal>[];
    return SessionSummary(
      sessionId: sessionId,
      hallName: 'A',
      animals: milking.length - skipped.length,
      volumeMl: (milking.length - skipped.length) * 9800,
      expectedMl: (milking.length - skipped.length) * 11000,
      notMilked: [
        for (final a in skipped)
          AnimalBrief(animalId: a.id, earTag: a.earTag, name: a.name ?? ''),
      ],
    );
  });

  /// Mock'ta gruplar bellekte (ADR 0092).
  final Map<String, AnimalGroup> _groups = {};
  int _groupSeq = 0;

  static const _groupConflict = ApiException(
    code: 'CONFLICT',
    message: 'bu adla bir grup zaten var',
    status: 409,
  );

  bool _groupNameTaken(String name, {String? except}) => _groups.values.any(
    (g) => g.id != except && g.name.toLowerCase() == name.toLowerCase(),
  );

  @override
  Future<List<AnimalGroup>> animalGroups() => _delayed(() async {
    final current = await animals();
    return [
      for (final g in _groups.values)
        g.copyWith(
          animals: current
              .where((a) => a.groupId == g.id && a.isMilking)
              .length,
        ),
    ]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  });

  @override
  Future<AnimalGroup> createGroup(String name) => _delayed(() async {
    final n = name.trim();
    if (_groupNameTaken(n)) throw _groupConflict;
    final g = AnimalGroup(id: 'mock-group-${++_groupSeq}', name: n);
    return _groups[g.id] = g;
  });

  @override
  Future<AnimalGroup> renameGroup(String id, String name) => _delayed(() async {
    final n = name.trim();
    if (_groupNameTaken(n, except: id)) throw _groupConflict;
    return _groups[id] = _groups[id]!.copyWith(name: n);
  });

  @override
  Future<void> deleteGroup(String id) => _delayed(() async {
    _groups.remove(id);
    for (final e in _savedAnimals.entries.toList()) {
      if (e.value.groupId == id) {
        _savedAnimals[e.key] = e.value.copyWith(groupId: null, groupName: null);
      }
    }
  });

  /// Mock'ta teslimler bellekte. Sayaç toplamı üretilmiş geçmişten
  /// çıkarılmıyor: karşılaştırma yok (`compared` false) — farkı uydurmak,
  /// demoda gerçek sanılacak bir alarm göstermek olurdu.
  final List<Delivery> _deliveries = [];
  double _tolerance = 5;
  int _deliverySeq = 0;

  @override
  Future<Deliveries> deliveries() => _delayed(
    () async => Deliveries(
      tolerancePct: _tolerance,
      items: [..._deliveries]
        ..sort((a, b) => b.deliveredOn.compareTo(a.deliveredOn)),
    ),
  );

  @override
  Future<Delivery> addDelivery({
    required DateTime day,
    required int volumeMl,
    String note = '',
  }) => _delayed(() async {
    final d = DateTime(day.year, day.month, day.day);
    if (_deliveries.any((e) => e.deliveredOn == d)) {
      throw const ApiException(
        code: 'CONFLICT',
        message: 'bu güne teslim zaten girilmiş; yanlışsa silip yeniden girin',
      );
    }
    final out = Delivery(
      id: 'mock-delivery-${++_deliverySeq}',
      deliveredOn: d,
      volumeMl: volumeMl,
      note: note.trim(),
      authorName: 'Demo Çiftçi',
    );
    _deliveries.add(out);
    return out;
  });

  @override
  Future<void> deleteDelivery(String id) =>
      _delayed(() async => _deliveries.removeWhere((e) => e.id == id));

  @override
  Future<void> setDeliveryTolerance(double pct) =>
      _delayed(() async => _tolerance = pct);

  @override
  Future<List<Milker>> milkers({int days = 7}) => _delayed(
    () async => [
      Milker(
        userId: 'demo',
        name: 'Demo Çiftçi',
        sessions: days * 2,
        milkings: days * 2 * 24,
        volumeMl: days * 2 * 24 * 9800,
        avgDurationSec: 372,
        lowFlowMilkings: days,
      ),
    ],
  );

  /// İşlem kaydı: demo için birkaç tipik olay (backend ADR 0082).
  @override
  Future<List<AuditEntry>> auditLog() => _delayed(
    () async => [
      AuditEntry(
        id: 'a1',
        at: _clock.subtract(const Duration(hours: 2)),
        action: 'spout.unassign',
        target: 'TR340000012',
        detail: 'Eşleştirme kaldırıldı, açık sağım silindi (3.4 L)',
        userName: 'Mehmet Yılmaz',
      ),
      AuditEntry(
        id: 'a2',
        at: _clock.subtract(const Duration(days: 1)),
        action: 'animal.update',
        target: 'TR340000008',
        detail: 'Durum: Sağmal → Kuruda',
        userName: 'Demo Çiftçi',
      ),
      AuditEntry(
        id: 'a3',
        at: _clock.subtract(const Duration(days: 3)),
        action: 'thresholds.update',
        target: 'İnek',
        detail: 'Düşük debi 1 → 1.2',
        userName: 'Demo Çiftçi',
      ),
    ],
  );

  /// İşletmenin kullanıcıları BELLEKTE (backend ADR 0076): demo sahibi ve
  /// bir sağımcıyla başlar. Demo modda e-posta yok; parolasız ekleme de
  /// "davet gönderildi" der ki akış gösterilebilsin.
  late final Map<String, TeamMember> _team = {
    // Demo kullanıcısının kendisi (auth_providers _mockUser).
    '0192a1f0-00a0-7000-8000-000000000002': const TeamMember(
      id: '0192a1f0-00a0-7000-8000-000000000002',
      email: 'ciftci@milktrace.local',
      fullName: 'Demo Çiftçi',
      role: 'tenant_owner',
    ),
    'mock-operator': const TeamMember(
      id: 'mock-operator',
      email: 'sagimci@milktrace.local',
      fullName: 'Mehmet Yılmaz',
      role: 'tenant_operator',
    ),
  };
  int _teamSeq = 0;

  static const _teamNotFound = ApiException(
    code: 'NOT_FOUND',
    message: 'kullanıcı bulunamadı',
    status: 404,
  );

  @override
  Future<List<TeamMember>> teamMembers() =>
      _delayed(() async => _team.values.toList());

  @override
  Future<TeamAddResult> addTeamMember({
    required String email,
    required String fullName,
    required String role,
    String? password,
    bool kiosk = false,
    DateTime? accessUntil,
  }) => _delayed(() async {
    final e = email.trim().toLowerCase();
    if (_team.values.any((m) => m.email == e)) {
      throw const ApiException(
        code: 'CONFLICT',
        message: 'bu e-posta başka bir hesapta kayıtlı',
        status: 409,
      );
    }
    final m = TeamMember(
      id: 'mock-user-${++_teamSeq}',
      email: e,
      fullName: fullName.trim(),
      // Tablet her zaman operatördür (backend ADR 0091).
      role: kiosk ? 'tenant_operator' : role,
      kiosk: kiosk,
      accessUntil: accessUntil,
    );
    _team[m.id] = m;
    final invited = password == null || password.isEmpty;
    return (
      member: m,
      message: invited
          ? 'kullanıcı eklendi, davet e-postası gönderildi'
          : 'kullanıcı eklendi',
    );
  });

  @override
  Future<TeamMember> updateTeamMember(
    String id, {
    required String fullName,
    required String role,
    required String status,
    DateTime? accessUntil,
  }) => _delayed(() async {
    final old = _team[id];
    if (old == null || !old.isManageable) throw _teamNotFound;
    return _team[id] = old.copyWith(
      fullName: fullName,
      role: role,
      status: status,
      accessUntil: accessUntil,
    );
  });

  @override
  Future<void> deleteTeamMember(String id) => _delayed(() async {
    final old = _team[id];
    if (old == null || !old.isManageable) throw _teamNotFound;
    _team.remove(id);
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
    final esc = draft.escalationMinutes;
    if (esc != null && (esc < 0 || esc > 240)) {
      throw const ApiException(
        code: 'VALIDATION',
        message: 'eskalasyon süresi 0 ile 240 dakika arasında olmalı',
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
      // Dil verilmezse eskisi kalır (backend ADR 0095).
      language: draft.language ?? base.language,
      escalationMinutes: draft.escalationMinutes ?? base.escalationMinutes,
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

  /// Gönderilen geri bildirimler (backend ADR 0106); mock'ta bellekte.
  final List<({String message, Uint8List? screenshot, String? contentType})>
  sentFeedback = [];

  @override
  Future<void> sendFeedback({
    required String message,
    Uint8List? screenshot,
    String? contentType,
  }) => _delayed(
    () async => sentFeedback.add((
      message: message,
      screenshot: screenshot,
      contentType: contentType,
    )),
  );

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
    final animalMl = <String, int>{};

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
        animalMl.update(
          animal.id,
          (v) => v + m.volumeMl,
          ifAbsent: () => m.volumeMl,
        );
      }
    }

    // Gruplar (ADR 0092): üyelik kaydedilen hayvanlardan.
    final current = await this.animals();
    final byGroup = [
      for (final g in _groups.values)
        () {
          final members = current.where((a) => a.groupId == g.id).toList();
          final milked = members.where((a) => animalMl.containsKey(a.id));
          return GroupTotal(
            groupId: g.id,
            name: g.name,
            animals: members.where((a) => a.isMilking).length,
            milked: milked.length,
            totalMl: milked.fold(0, (s, a) => s + animalMl[a.id]!),
          );
        }(),
    ]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

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
      byGroup: byGroup,
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

  /// Eşleştirmesi kaldırılan noktalar (asset'te hayvanı olanlar dahil).
  final Set<String> _unassigned = {};

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
  }) => _delayed(() async {
    _assignments[spoutId] = animalId;
    _unassigned.remove(spoutId);
  });

  /// Mock'un tanınmayan küpeleri: canlı demodaki 8. noktanın küpesi
  /// (live_session.json) — iki ekran aynı hikâyeyi anlatsın.
  final Map<String, UnmatchedTagRow> _unmatched = {
    '982000123456789': UnmatchedTagRow(
      rfid: '982000123456789',
      lastSessionId: '0192a1f0-0080-7000-8000-000000000001',
      lastSpoutId: '0192a1f0-0050-7000-8000-000000000008',
      firstSeenAt: DateTime.utc(2026, 9, 20, 6, 4),
      lastSeenAt: DateTime.utc(2026, 9, 21, 6, 11, 48),
      readCount: 3,
    ),
  };

  @override
  Future<List<UnmatchedTagRow>> unmatchedTags() => _delayed(() async {
    // Backend gibi HESAPLANIR: bir hayvanın kaydına girilen küpe düşer.
    final known = {for (final a in await animals()) ?a.rfid};
    return [
      for (final t in _unmatched.values)
        if (!known.contains(t.rfid)) t,
    ];
  });

  @override
  Future<void> dismissUnmatchedTag(String rfid) =>
      _delayed(() async => _unmatched.remove(rfid));

  @override
  Future<void> unassignAnimal({
    required String sessionId,
    required String spoutId,
  }) => _delayed(() async {
    _assignments.remove(spoutId);
    _unassigned.add(spoutId);
  });

  @override
  Future<MilkingSession> endSession(String sessionId) => _delayed(() async {
    final live = await _load(
      'live_session.json',
      (json) => LiveSession.fromJson(json as Map<String, dynamic>),
    );

    _sessionEnded = true;
    _assignments.clear();
    _unassigned.clear();
    return live.session.copyWith(status: 'ended', endedAt: _clock);
  });
}
