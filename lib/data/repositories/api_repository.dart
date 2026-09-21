import 'dart:convert';

import 'package:dio/dio.dart';
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
import 'package:web_socket_channel/web_socket_channel.dart';

/// Gerçek backend'e bağlanan kaynak (§8.5).
///
/// DURUM: iskelet. Uçlar §8.5'teki yollara göre yazıldı ama backend Faz 2'de
/// geleceği için henüz çalıştırılmadı. Mock ile AYNI fromJson'ları kullanır;
/// geçiş `--dart-define=MT_API=http` ile yapılır.
class ApiRepository implements MilkTraceRepository {
  ApiRepository({required Dio dio, required String wsBaseUrl})
      : _dio = dio,
        _wsBaseUrl = wsBaseUrl;

  final Dio _dio;
  final String _wsBaseUrl;

  /// §16'daki zarf: {"success":..,"data":..,"error":{"code","message"}}
  List<T> _listOf<T>(Response<dynamic> r, T Function(Map<String, dynamic>) from) {
    final data = (r.data as Map<String, dynamic>)['data'] as List<dynamic>;
    return data.map((e) => from(e as Map<String, dynamic>)).toList(growable: false);
  }

  Map<String, dynamic> _dataOf(Response<dynamic> r) =>
      (r.data as Map<String, dynamic>)['data'] as Map<String, dynamic>;

  @override
  Future<List<Species>> species() async =>
      _listOf(await _dio.get<dynamic>('/species'), Species.fromJson);

  @override
  Future<List<Thresholds>> thresholds() async =>
      _listOf(await _dio.get<dynamic>('/species/thresholds'), Thresholds.fromJson);

  @override
  Future<List<Farm>> farms() async =>
      _listOf(await _dio.get<dynamic>('/farms'), Farm.fromJson);

  @override
  Future<List<Hall>> halls() async =>
      _listOf(await _dio.get<dynamic>('/halls'), Hall.fromJson);

  @override
  Future<List<Vacuum>> vacuums({String? hallId}) async => _listOf(
      await _dio.get<dynamic>('/vacuums',
          queryParameters: {'hallId': ?hallId}),
      Vacuum.fromJson);

  @override
  Future<List<Spout>> spouts({String? vacuumId}) async => _listOf(
      await _dio.get<dynamic>('/spouts',
          queryParameters: {'vacuumId': ?vacuumId}),
      Spout.fromJson);

  @override
  Future<List<Device>> devices() async =>
      _listOf(await _dio.get<dynamic>('/devices'), Device.fromJson);

  @override
  Future<List<Animal>> animals() async =>
      _listOf(await _dio.get<dynamic>('/animals'), Animal.fromJson);

  @override
  Future<LiveSession> liveSession({required String hallId}) async {
    final sessions = await _dio.get<dynamic>('/sessions',
        queryParameters: {'hallId': hallId, 'status': 'active'});
    final list = (sessions.data as Map<String, dynamic>)['data'] as List<dynamic>;
    if (list.isEmpty) {
      return LiveSession(
        session: MilkingSession(id: '', hallId: hallId, status: 'none'),
      );
    }
    final id = (list.first as Map<String, dynamic>)['id'] as String;
    return LiveSession.fromJson(_dataOf(await _dio.get<dynamic>('/sessions/$id/live')));
  }

  @override
  Stream<SpoutUpdate> watchSession(String sessionId) {
    final channel =
        WebSocketChannel.connect(Uri.parse('$_wsBaseUrl/ws?sessionId=$sessionId'));

    return channel.stream.map((event) {
      final json = jsonDecode(event as String) as Map<String, dynamic>;
      return SpoutUpdate.fromJson(json);
    });
  }
}
