import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/env.dart';
import 'package:milktrace/features/assistant/assistant_markdown.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/widgets/help_button.dart';

void main() {
  const site = 'https://milktrace.com.tr';

  tearDown(() => setL10nLocale(const Locale('tr')));

  group('Env.helpUrl', () {
    test('Türkçe /yardim/<slug>, İngilizce /en/help/<slug>', () {
      expect(Env.helpUrl('canli-sagim', 'tr'), '$site/yardim/canli-sagim');
      expect(Env.helpUrl('canli-sagim', 'en'), '$site/en/help/canli-sagim');
    });

    test('slug yoksa yardım merkezinin ana sayfası', () {
      expect(Env.helpUrl(null, 'tr'), '$site/yardim');
      expect(Env.helpUrl('', 'tr'), '$site/yardim');
      expect(Env.helpUrl(null, 'en'), '$site/en/help');
    });

    test('helpCenterUrl uygulama diline uyar', () {
      expect(Env.helpCenterUrl, '$site/yardim');
      setL10nLocale(const Locale('en'));
      expect(Env.helpCenterUrl, '$site/en/help');
    });
  });

  group('Env.localizedSitePath', () {
    test('İngilizcede /yardim ve altı çevrilir; sorgu ve çapa korunur', () {
      expect(Env.localizedSitePath('/yardim', 'en'), '/en/help');
      expect(Env.localizedSitePath('/yardim/sss', 'en'), '/en/help/sss');
      expect(
        Env.localizedSitePath('/yardim/sss#kayit', 'en'),
        '/en/help/sss#kayit',
      );
      expect(Env.localizedSitePath('/yardim?q=x', 'en'), '/en/help?q=x');
    });

    test('Türkçe ve başka yollar olduğu gibi kalır', () {
      expect(Env.localizedSitePath('/yardim/sss', 'tr'), '/yardim/sss');
      expect(Env.localizedSitePath('/gizlilik', 'en'), '/gizlilik');
      expect(Env.localizedSitePath('/yardimci', 'en'), '/yardimci');
    });
  });

  group('assistantLinkUri', () {
    test('göreli yardım bağlantısı dile göre', () {
      expect(
        assistantLinkUri('/yardim/sagim', language: 'tr').toString(),
        '$site/yardim/sagim',
      );
      expect(
        assistantLinkUri('/yardim/sagim', language: 'en').toString(),
        '$site/en/help/sagim',
      );
    });

    test('varsayılan dil uygulamanın dili', () {
      setL10nLocale(const Locale('en'));
      expect(
        assistantLinkUri('/yardim/sagim').toString(),
        '$site/en/help/sagim',
      );
    });

    test('sunucunun verdiği tam adrese dokunulmaz', () {
      expect(
        assistantLinkUri(
          'https://milktrace.com.tr/yardim/sagim',
          language: 'en',
        ).toString(),
        'https://milktrace.com.tr/yardim/sagim',
      );
    });
  });

  group('HelpButton', () {
    late List<Uri> opened;

    setUp(() {
      opened = [];
      HelpButton.launcher = (uri) async {
        opened.add(uri);
        return true;
      };
    });

    Future<void> pump(WidgetTester tester, Widget button) => tester.pumpWidget(
      MaterialApp(
        home: Scaffold(appBar: AppBar(actions: [button])),
      ),
    );

    testWidgets('Türkçe: etiket ve makale', (tester) async {
      await pump(tester, const HelpButton(slug: HelpSlug.liveMilking));
      expect(find.byTooltip('Bu ekranla ilgili yardım'), findsOneWidget);
      await tester.tap(find.byKey(const Key('helpButton')));
      expect(opened, [Uri.parse('$site/yardim/canli-sagim')]);
    });

    testWidgets('İngilizce: etiket ve /en/help', (tester) async {
      setL10nLocale(const Locale('en'));
      await pump(tester, const HelpButton(slug: HelpSlug.auditLog));
      expect(find.byTooltip('Help for this screen'), findsOneWidget);
      await tester.tap(find.byKey(const Key('helpButton')));
      expect(opened, [Uri.parse('$site/en/help/islem-kaydi')]);
    });

    testWidgets('slug yoksa yardım merkezi', (tester) async {
      await pump(tester, const HelpButton());
      await tester.tap(find.byKey(const Key('helpButton')));
      expect(opened, [Uri.parse('$site/yardim')]);
    });
  });
}
