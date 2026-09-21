import 'package:dio/dio.dart';
import 'package:milktrace/core/env.dart';
import 'package:milktrace/data/repositories/api_repository.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

/// Uygulamanın veri kaynağı.
///
/// Mock mu gerçek API mi olduğu YALNIZCA burada bilinir; ekranlar arayüzü
/// görür. Geçiş `--dart-define=MT_API=http` ile yapılır (§15.2).
@Riverpod(keepAlive: true)
MilkTraceRepository repository(Ref ref) {
  if (Env.apiMode == ApiMode.mock) {
    return MockRepository();
  }

  final dio = Dio(BaseOptions(
    baseUrl: Env.apiBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
  ));
  ref.onDispose(dio.close);

  return ApiRepository(
    dio: dio,
    wsBaseUrl: Env.apiBaseUrl.replaceFirst('http', 'ws').replaceFirst('/api/v1', ''),
  );
}
