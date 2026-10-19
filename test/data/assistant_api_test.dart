import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/app_build.dart';
import 'package:milktrace/data/models/assistant.dart';
import 'package:milktrace/data/repositories/api_repository.dart';
import 'package:milktrace/features/assistant/assistant_markdown.dart';
import 'package:milktrace/features/assistant/assistant_providers.dart';
import 'package:milktrace/l10n/l10n.dart';

import '../auth/fake_backend.dart';

({ApiRepository repo, FakeAdapter adapter}) rig(
  Future<ResponseBody> Function(RequestOptions) handler,
) {
  final adapter = FakeAdapter(handler);
  final dio = Dio(BaseOptions(baseUrl: 'http://test/api/v1'))
    ..httpClientAdapter = adapter
    ..interceptors.add(AppBuildInterceptor());
  return (
    repo: ApiRepository(dio: dio, wsBaseUrl: 'ws://test/api/v1'),
    adapter: adapter,
  );
}

Future<Object> failureOf(Future<Object?> Function() call) async {
  try {
    await call();
  } catch (e) {
    return e;
  }
  fail('hata bekleniyordu');
}

void main() {
  tearDown(() => setL10nLocale(const Locale('tr')));

  test('durum ayrıştırılır; eksik alan kapalı sayılır', () async {
    final r = rig((o) async => okEnvelope({'enabled': true}));
    final s = await r.repo.assistantStatus();
    expect(s, const AssistantStatus(enabled: true));
    expect(r.adapter.requests.single.path, '/assistant/status');

    expect(AssistantStatus.fromJson(const {}).enabled, isFalse);
  });

  test('soru geçmişin tamamıyla ve uygulama diliyle gider', () async {
    setL10nLocale(const Locale('en'));
    final r = rig(
      (o) async => okEnvelope({
        'text': 'See [Milking](/yardim/sagim).',
        'sources': [
          {'slug': 'sagim', 'title': 'Milking', 'url': '/yardim/sagim'},
        ],
        'handoff': true,
      }),
    );
    final reply = await r.repo.askAssistant(const [
      AssistantMessage(role: 'user', text: 'a'),
      AssistantMessage(role: 'assistant', text: 'b'),
      AssistantMessage(role: 'user', text: 'c'),
    ]);

    expect(reply.handoff, isTrue);
    expect(reply.sources.single.slug, 'sagim');

    final req = r.adapter.requests.single;
    expect(req.method, 'POST');
    expect(req.path, '/assistant/messages');
    expect(req.headers['Accept-Language'], 'en');
    final body = req.data is String ? jsonDecode(req.data as String) : req.data;
    expect(body, {
      'messages': [
        {'role': 'user', 'text': 'a'},
        {'role': 'assistant', 'text': 'b'},
        {'role': 'user', 'text': 'c'},
      ],
    });
  });

  group('hata eşlemesi', () {
    Future<AssistantFailure> mapped(int status, String code, String msg) async {
      final r = rig((o) async => errEnvelope(status, code, msg));
      return assistantFailureOf(
        await failureOf(
          () => r.repo.askAssistant(const [
            AssistantMessage(role: 'user', text: 'soru'),
          ]),
        ),
      );
    }

    test('503 kapalı', () async {
      final f = await mapped(503, 'assistant_disabled', 'disabled');
      expect(f.kind, AssistantFailureKind.unavailable);
      expect(f.message, l10n.assistantUnavailable);
    });

    test('422 sunucu mesajı + yeni konuşma önerisi', () async {
      final f = await mapped(422, 'VALIDATION', 'Konuşma çok uzun.');
      expect(f.kind, AssistantFailureKind.rejected);
      expect(f.message, contains('Konuşma çok uzun.'));
      expect(f.message, contains('Yeni bir konuşma'));
    });

    test('403 sunucunun mesajı', () async {
      final f = await mapped(403, 'FORBIDDEN', 'Yetkiniz yok.');
      expect(f.kind, AssistantFailureKind.unauthorized);
      expect(f.message, 'Yetkiniz yok.');
    });

    test('ağ hatası yeniden denenebilir', () {
      final f = assistantFailureOf(
        DioException(
          requestOptions: RequestOptions(path: '/assistant/messages'),
          type: DioExceptionType.connectionError,
        ),
      );
      expect(f.kind, AssistantFailureKind.other);
      expect(f.message, l10n.coreErrorConnection);
    });
  });

  group('markdown', () {
    test('bağlantı, kalın ve liste ayrıştırılır', () {
      final blocks = parseAssistantMarkdown(
        '**Sağım** için:\n\n- [Rehber](/yardim/sagim) açın\n2. https://milktrace.com.tr/yardim/x.',
      );
      expect(blocks, hasLength(3));
      expect(blocks[0].inlines.first.bold, isTrue);
      expect(blocks[1].kind, MdBlockKind.bullet);
      expect(
        blocks[1].inlines.first.link.toString(),
        'https://milktrace.com.tr/yardim/sagim',
      );
      expect(blocks[2].kind, MdBlockKind.numbered);
      final bare = blocks[2].inlines.first;
      expect(bare.link.toString(), 'https://milktrace.com.tr/yardim/x');
      expect(blocks[2].inlines.last.text, '.');
    });

    test('http(s) dışındaki şemalar bağlantı olmaz', () {
      expect(assistantLinkUri('javascript:alert(1)'), isNull);
      expect(assistantLinkUri('intent://x'), isNull);
      expect(assistantLinkUri('//evil.example/x'), isNull);
      final i = parseMdInline('[tıkla](javascript:alert(1))');
      expect(i.every((e) => e.link == null), isTrue);
    });
  });
}
