import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/notification_channel.dart';
import 'package:milktrace/data/repositories/api_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';

import '../auth/fake_backend.dart';

Future<String> _diskAsset(String path) async => File(path).readAsStringSync();

NotificationChannelDraft draft({
  String kind = 'sms',
  String provider = 'netgsm',
  Map<String, String> config = const {
    'usercode': '8501112233',
    'password': 'gizli',
    'msgheader': 'MILKTRACE',
  },
  List<String> recipients = const ['+905321112233'],
  bool enabled = true,
}) => NotificationChannelDraft(
  name: 'Sahip SMS',
  kind: kind,
  provider: provider,
  config: config,
  recipients: recipients,
  minSeverity: 'critical',
  sendResolved: false,
  enabled: enabled,
  sources: const ['ops'],
);

void main() {
  // Asset backend'in sağlayıcı tanımlarından ÜRETİLDİ; ayrışırsa mock modda
  // form gerçek API'dekinden farklı alanlar isterdi.
  test('sağlayıcı asset\'i API şekliyle ayrıştırılır', () async {
    final raw =
        jsonDecode(
              File(
                'assets/data/notification_providers.json',
              ).readAsStringSync(),
            )
            as List<dynamic>;
    final specs = raw
        .map((e) => NotificationProvider.fromJson(e as Map<String, dynamic>))
        .toList();
    expect(specs, hasLength(13));
    final netgsm = specs.firstWhere(
      (s) => s.kind == 'sms' && s.provider == 'netgsm',
    );
    expect(netgsm.recipients, 'phone');
    expect(
      netgsm.fields.firstWhere((f) => f.name == 'password').secret,
      isTrue,
    );
    final slack = specs.firstWhere((s) => s.kind == 'slack');
    expect(slack.recipients, 'none');
  });

  group('MockRepository', () {
    late MockRepository repo;
    setUp(
      () =>
          repo = MockRepository(latency: Duration.zero, loadAsset: _diskAsset),
    );

    test('sır geri dönmez, yalnızca ayarlı olduğu söylenir', () async {
      final c = await repo.createNotificationChannel(draft());
      expect(c.config, {'usercode': '8501112233', 'msgheader': 'MILKTRACE'});
      expect(c.secrets, {'password': true});
      expect(c.sources, ['ops']);
      expect(
        (await repo.notificationChannels()).map((e) => e.id),
        contains(c.id),
      );
    });

    test(
      'güncelleme kısmi: gönderilmeyen sır korunur, boş dize siler',
      () async {
        final c = await repo.createNotificationChannel(draft());
        final kept = await repo.updateNotificationChannel(
          c.id,
          draft(config: const {'msgheader': 'CIFTLIK'}),
        );
        expect(kept.secrets['password'], isTrue, reason: 'parola korunmalı');
        expect(kept.config['msgheader'], 'CIFTLIK');

        await expectLater(
          repo.updateNotificationChannel(
            c.id,
            draft(config: const {'password': ''}),
          ),
          throwsA(
            isA<ApiException>().having(
              (e) => e.message,
              'message',
              contains('password'),
            ),
          ),
          reason: 'zorunlu sır silinemez',
        );
      },
    );

    test('silinen kanal listeden çıkar ve denenemez', () async {
      final c = await repo.createNotificationChannel(draft());
      await repo.deleteNotificationChannel(c.id);
      expect(
        (await repo.notificationChannels()).map((e) => e.id),
        isNot(contains(c.id)),
      );
      await expectLater(
        repo.testNotificationChannel(c.id),
        throwsA(isA<ApiException>()),
      );
    });
  });

  group('ApiRepository', () {
    late List<RequestOptions> seen;
    late ResponseBody Function(RequestOptions) respond;
    late ApiRepository repo;

    setUp(() {
      seen = [];
      respond = (_) => okEnvelope({});
      final dio = Dio(BaseOptions(baseUrl: 'http://test/api/v1'))
        ..httpClientAdapter = FakeAdapter((o) async {
          seen.add(o);
          return respond(o);
        });
      repo = ApiRepository(dio: dio, wsBaseUrl: 'ws://test/api/v1');
    });

    Map<String, dynamic> channelJson() => {
      'id': 'c1',
      'name': 'Sahip SMS',
      'kind': 'sms',
      'provider': 'netgsm',
      'config': {'usercode': '8501112233'},
      'secrets': {'password': true},
      'recipients': ['+905321112233'],
      'minSeverity': 'critical',
      'sendResolved': false,
      'enabled': true,
      'sources': ['ops'],
    };

    test('kanal listesi ve sağlayıcılar doğru uçlardan', () async {
      respond = (o) => okEnvelope2(
        o.path == '/notification-channels' ? [channelJson()] : [],
      );
      final list = await repo.notificationChannels();
      await repo.notificationProviders();
      expect(list.single.secrets, {'password': true});
      expect(seen.map((o) => o.path), [
        '/notification-channels',
        '/notification-providers',
      ]);
    });

    test('güncelleme PUT; tür ve sağlayıcı gövdede yok', () async {
      respond = (_) => okEnvelope(channelJson());
      await repo.updateNotificationChannel(
        'c1',
        draft(config: const {'msgheader': 'YENI'}),
      );
      final o = seen.single;
      expect(o.method, 'PUT');
      expect(o.path, '/notification-channels/c1');
      final body = o.data as Map<String, dynamic>;
      expect(body.containsKey('kind'), isFalse);
      expect(body.containsKey('provider'), isFalse);
      expect(body['config'], {'msgheader': 'YENI'});
    });

    // Sağlayıcının reddi (ör. yanlış API anahtarı) kullanıcıya backend'in
    // metniyle ulaşmalı; ham DioException değil.
    test('test hatası backend mesajıyla gösterilir', () async {
      respond = (_) =>
          errEnvelope(502, 'VALIDATION', 'gönderilemedi: netgsm: kod 30 yetki');
      Object? caught;
      try {
        await repo.testNotificationChannel('c1');
      } catch (e) {
        caught = e;
      }
      expect(seen.single.path, '/notification-channels/c1/test');
      expect(userMessage(caught), 'gönderilemedi: netgsm: kod 30 yetki');
    });
  });

  test('userMessage API dışı hatada null', () {
    expect(userMessage(StateError('x')), isNull);
    expect(userMessage(null), isNull);
  });
}
