import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/widgets/brand_mark.dart';

void main() {
  tearDown(() => AppColors.brightness = Brightness.light);

  test('koyu temada açık damla; iki işaret de üretilmiş', () {
    expect(BrandMark.asset, 'assets/brand/mark.png');
    AppColors.brightness = Brightness.dark;
    expect(BrandMark.asset, 'assets/brand/mark_dark.png');
    for (final dir in ['', '2.0x/', '3.0x/']) {
      for (final f in ['mark.png', 'mark_dark.png']) {
        expect(
          File('assets/brand/$dir$f').existsSync(),
          isTrue,
          reason: '$dir$f',
        );
      }
    }
  });
}
