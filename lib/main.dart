import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/app.dart';
import 'package:milktrace/core/app_build.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Yapı numarası her istekte gider (asgari sürüm, backend ADR 0080).
  await AppBuild.load();
  // ProviderScope runApp'e sarılır, MilkTraceApp.build içine DEĞİL: build
  // içinde olduğunda widget ağacının bir parçası olur ve her yeniden çiziminde
  // yeniden değerlendirilir. Kök burada olmalı.
  runApp(const ProviderScope(child: MilkTraceApp()));
}
