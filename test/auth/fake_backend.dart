import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Testlerde gerçek HTTP yerine geçen adaptör.
///
/// Yanıtları elle üretir ve HER İSTEĞİ kaydeder: interceptor'ın kaç kez
/// yenileme yaptığını ancak sayarak doğrulayabiliriz.
class FakeAdapter implements HttpClientAdapter {
  FakeAdapter(this.handler);

  final Future<ResponseBody> Function(RequestOptions options) handler;

  final List<RequestOptions> requests = [];

  int countOf(String path) => requests.where((r) => r.path == path).length;

  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<Uint8List>? requestStream,
          Future<void>? cancelFuture) async {
    requests.add(options);
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody jsonResponse(int status, Map<String, dynamic> body) => ResponseBody.fromString(
      jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

/// §16 başarı zarfı.
ResponseBody okEnvelope(Map<String, dynamic> data) =>
    jsonResponse(200, {'success': true, 'data': data, 'msg': ''});

/// §16 hata zarfı.
ResponseBody errEnvelope(int status, String code, String message) => jsonResponse(
    status, {'success': false, 'error': {'code': code, 'message': message}});

/// Bellekte duran secure storage.
///
/// Gerçek FlutterSecureStorage platform kanalı ister; birim testinde yoktur.
class InMemorySecureStorage implements FlutterSecureStorage {
  final Map<String, String> values = {};

  @override
  Future<String?> read({required String key, dynamic iOptions, dynamic aOptions,
          dynamic lOptions, dynamic webOptions, dynamic mOptions, dynamic wOptions}) async =>
      values[key];

  @override
  Future<void> write({required String key, required String? value, dynamic iOptions,
      dynamic aOptions, dynamic lOptions, dynamic webOptions, dynamic mOptions,
      dynamic wOptions}) async {
    if (value == null) {
      values.remove(key);
    } else {
      values[key] = value;
    }
  }

  @override
  Future<void> delete({required String key, dynamic iOptions, dynamic aOptions,
      dynamic lOptions, dynamic webOptions, dynamic mOptions, dynamic wOptions}) async {
    values.remove(key);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('testte kullanılmıyor: ${invocation.memberName}');
}
