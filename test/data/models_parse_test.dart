import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/device.dart';
import 'package:milktrace/data/models/device_profile.dart';
import 'package:milktrace/data/models/farm.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/spout.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/data/models/vacuum.dart';
import 'package:milktrace/domain/flow_color.dart';

/// Mock asset'lerin modellere sorunsuz çözüldüğünü ve ilişkilerin tutarlı
/// olduğunu doğrular.
///
/// NEDEN ÖNEMLİ: eski mock veride yabancı anahtar hem id hem gömülü obje
/// olarak iki kez duruyordu ve ikisi ÇELİŞMİŞTİ (§15.3/3,4). Bu test o hata
/// sınıfının geri gelmesini engeller.
void main() {
  List<dynamic> readList(String name) =>
      jsonDecode(File('assets/data/$name').readAsStringSync()) as List<dynamic>;

  Map<String, dynamic> readMap(String name) =>
      jsonDecode(File('assets/data/$name').readAsStringSync())
          as Map<String, dynamic>;

  test('türler ve eşikler çözülür', () {
    final species = readList('species.json')
        .map((e) => Species.fromJson(e as Map<String, dynamic>))
        .toList();
    expect(species, hasLength(3));
    expect(species.map((s) => s.code), containsAll(['cow', 'goat', 'sheep']));

    final thresholds = readList('thresholds.json')
        .map((e) => Thresholds.fromJson(e as Map<String, dynamic>))
        .toList();
    expect(thresholds, hasLength(3));

    final speciesIds = species.map((s) => s.id).toSet();
    for (final t in thresholds) {
      expect(speciesIds, contains(t.speciesId),
          reason: 'eşik tanımsız bir türe bağlı');
      expect(t.flowLow, lessThan(t.flowHigh));
      expect(t.yieldRedPct, lessThan(t.yieldGreenPct));
    }
  });

  test('tesis hiyerarşisi çözülür ve yabancı anahtarlar tutarlı', () {
    final farms = readList('farms.json')
        .map((e) => Farm.fromJson(e as Map<String, dynamic>))
        .toList();
    final halls = readList('halls.json')
        .map((e) => Hall.fromJson(e as Map<String, dynamic>))
        .toList();
    final vacuums = readList('vacuums.json')
        .map((e) => Vacuum.fromJson(e as Map<String, dynamic>))
        .toList();
    final spouts = readList('spouts.json')
        .map((e) => Spout.fromJson(e as Map<String, dynamic>))
        .toList();

    expect(farms, hasLength(1));
    expect(halls, hasLength(3));
    expect(vacuums, hasLength(3));
    expect(spouts, hasLength(30));

    final farmIds = farms.map((f) => f.id).toSet();
    final hallIds = halls.map((h) => h.id).toSet();
    final vacuumIds = vacuums.map((v) => v.id).toSet();

    for (final h in halls) {
      expect(farmIds, contains(h.farmId));
    }
    for (final v in vacuums) {
      expect(hallIds, contains(v.hallId), reason: 'ünite tanımsız bölgeye bağlı');
    }
    for (final s in spouts) {
      expect(vacuumIds, contains(s.vacuumId), reason: 'nokta tanımsız üniteye bağlı');
    }

    // Ünitenin bildirdiği nokta sayısı gerçekten var mı?
    for (final v in vacuums) {
      final count = spouts.where((s) => s.vacuumId == v.id).length;
      expect(count, v.totalSpouts,
          reason: '${v.name} totalSpouts=${v.totalSpouts} ama $count nokta var');
    }
  });

  test('cihazlar noktalara bire bir bağlı', () {
    final devices = readList('devices.json')
        .map((e) => Device.fromJson(e as Map<String, dynamic>))
        .toList();
    final spoutIds = readList('spouts.json')
        .map((e) => Spout.fromJson(e as Map<String, dynamic>).id)
        .toSet();

    final assigned = devices.map((d) => d.spoutId).whereType<String>().toList();
    expect(assigned.toSet(), hasLength(assigned.length),
        reason: 'aynı noktaya iki cihaz takılı olamaz');
    for (final d in devices) {
      if (d.spoutId != null) expect(spoutIds, contains(d.spoutId));
    }
    expect(devices.map((d) => d.serialNo).toSet(), hasLength(devices.length),
        reason: 'seri numaraları tekil olmalı');

    // Fixture'da her üç durum da BULUNMALI: Cihazlar ekranı çevrimiçi,
    // çevrimdışı, takılı olmayan sayaç ve sayaçsız nokta hâllerinin
    // dördünü de çiziyor; hepsi online olsaydı üçü hiç denenmezdi.
    expect(devices.where((d) => d.status == 'online'), isNotEmpty);
    expect(devices.where((d) => d.status == 'offline'), isNotEmpty);
    expect(devices.where((d) => d.spoutId == null), isNotEmpty);
    expect(spoutIds.difference(assigned.toSet()), isNotEmpty,
        reason: 'sayaç takılmamış en az bir nokta olmalı');

    // §17 Faz 5 demosu birden fazla protokol istiyor; tek protokol olsaydı
    // karışım hiç denenmemiş olurdu.
    final protocols = devices
        .map((d) => d.profile?.protocol)
        .whereType<String>()
        .toSet();
    expect(protocols.length, greaterThan(1), reason: 'protokol karışımı yok');
    expect(devices.where((d) => d.profile == null), isNotEmpty,
        reason: 'profili atanmamış (karantinadaki) bir cihaz da olmalı');
  });

  test('hayvanlar çözülür; küpe numarası var, tür id ile bağlı', () {
    final animals = readList('animals.json')
        .map((e) => Animal.fromJson(e as Map<String, dynamic>))
        .toList();
    final speciesIds = readList('species.json')
        .map((e) => Species.fromJson(e as Map<String, dynamic>).id)
        .toSet();

    expect(animals, hasLength(30));
    for (final a in animals) {
      expect(a.earTag, isNotEmpty, reason: 'küpe numarası zorunlu (§15.3/8)');
      expect(speciesIds, contains(a.speciesId));
    }
    expect(animals.map((a) => a.earTag).toSet(), hasLength(30),
        reason: 'küpe numaraları tekil olmalı');
  });

  test('canlı oturum §8.5 payload şekliyle çözülür', () {
    final live = LiveSession.fromJson(readMap('live_session.json'));

    expect(live.session.hallId, isNotEmpty);
    expect(live.updates, hasLength(10));

    final spoutIds = readList('spouts.json')
        .map((e) => Spout.fromJson(e as Map<String, dynamic>).id)
        .toSet();
    for (final u in live.updates) {
      expect(spoutIds, contains(u.spoutId));
      expect(u.sessionId, live.session.id);
    }

    // Dört rengin de demoda görünmesi gerekiyor; aksi halde sarı bandı
    // (§15.3/14) yine fark edilmez.
    final colors = live.updates.map((u) => u.flowColor).toSet();
    expect(colors, containsAll([MilkColor.green, MilkColor.yellow,
        MilkColor.red, MilkColor.grey]));
  });

  test('eşleşmemiş nokta hayvansız ve gri gelir', () {
    final live = LiveSession.fromJson(readMap('live_session.json'));
    final idle = live.updates.where((u) => u.state == SpoutState.idle);

    expect(idle, isNotEmpty);
    for (final u in idle) {
      expect(u.animal, isNull);
      expect(u.flowColor, MilkColor.grey);
    }
  });

  test('int/double karışıklığına dayanıklı', () {
    // Eski modelde json["targetAmount"] as double sert cast'i vardı ve JSON'da
    // 20 (int) gelirse ÇÖKÜYORDU (§15.3/5,6). Üretilen kod num -> double
    // dönüşümü yapar; bu test o davranışı kilitler.
    final u = SpoutUpdate.fromJson({
      'sessionId': 's', 'spoutId': 'p',
      'flowRate': 2, // int
      'volumeMl': 1000, 'expectedMl': 11000,
      'yieldPct': 9, // int
      'flowColor': 'green', 'yieldColor': 'green', 'state': 'milking',
    });
    expect(u.flowRate, 2.0);
    expect(u.yieldPct, 9.0);
  });

  // Protokol etiketi backend'in GERÇEKTEN yazdığı kodları tanımalı.
  //
  // Referans Modbus profili `modbus` yazıyor (register haritası RTU/TCP'de
  // aynı); eşleme yalnızca modbus-rtu/modbus-tcp'yi tanıdığı için gerçek
  // API'de ekranda ham "modbus" görünüyordu. Mock `modbus-tcp` kullandığı
  // için bu, mock modda hiç fark edilmedi.
  test('protokol etiketi backend kodlarını tanır', () {
    String label(String p) =>
        DeviceProfile(id: 'p', protocol: p).protocolLabel;

    expect(label('mqtt'), 'MQTT');
    expect(label('modbus'), 'Modbus');
    expect(label('modbus-rtu'), 'Modbus RTU');
    expect(label('modbus-tcp'), 'Modbus TCP');
    expect(label('http'), 'HTTP');
    expect(label(''), 'Bilinmiyor');
    // Tanınmayan kod olduğu gibi: boş bırakmak protokolsüz izlenimi verirdi.
    expect(label('bacnet-ip'), 'bacnet-ip');
  });
}
