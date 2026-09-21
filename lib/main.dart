import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // ProviderScope runApp'e sarılır, MilkTraceApp.build içine DEĞİL: build
  // içinde olduğunda widget ağacının bir parçası olur ve her yeniden çiziminde
  // yeniden değerlendirilir. Kök burada olmalı.
  runApp(const ProviderScope(child: MilkTraceApp()));
}
