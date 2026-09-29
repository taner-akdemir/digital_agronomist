import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/device.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/devices/devices_screen.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

/// İlk çevrimiçi ve hatasız sayacın kalibrasyon zamanı geçmiş.
class _Due extends MockRepository {
  _Due() : super(latency: Duration.zero, loadAsset: _disk);

  String? serial;

  @override
  Future<List<Device>> devices() async {
    final all = await super.devices();
    var done = false;
    return [
      for (final d in all)
        if (!done &&
            d.status == 'online' &&
            d.lastError == null &&
            d.spoutId != null)
          () {
            done = true;
            serial = d.serialNo;
            return d.copyWith(
              calibratedAt: DateTime(2026, 1, 10),
              calibrationDueAt: DateTime(2026, 7, 9),
            );
          }()
        else
          d,
    ];
  }
}

void main() {
  test('kalibrasyon zamanı gün bazında', () {
    final d = Device(
      id: 'd',
      serialNo: 'SN',
      calibrationDueAt: DateTime.utc(2026, 9, 29),
    );
    expect(d.isCalibrationDue(DateTime(2026, 9, 28, 23)), isFalse);
    expect(d.isCalibrationDue(DateTime(2026, 9, 29, 8)), isTrue);
    expect(
      const Device(id: 'd', serialNo: 'SN').isCalibrationDue(DateTime(2030)),
      isFalse,
      reason: 'tarih yoksa hatırlatma yok',
    );
  });

  testWidgets('zamanı gelen sayaç sarı ve ayrıntıda tarihiyle', (tester) async {
    tester.view.physicalSize = const Size(1200, 5200);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final repo = _Due();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
        ],
        child: const MaterialApp(home: Scaffold(body: DevicesScreen())),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Kalibrasyon zamanı'), findsWidgets);

    await tester.tap(find.textContaining(repo.serial!).first);
    await tester.pumpAndSettle();
    expect(find.text('Son kalibrasyon'), findsOneWidget);
    expect(find.textContaining('zamanı geldi'), findsOneWidget);
  });
}
