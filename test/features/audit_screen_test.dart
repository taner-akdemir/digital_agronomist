import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/audit_entry.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/audit/audit_screen.dart';
import 'package:milktrace/providers/repository_providers.dart';

class _Repo extends MockRepository {
  _Repo(this.entries) : super(latency: Duration.zero);

  final List<AuditEntry> entries;

  @override
  Future<List<AuditEntry>> auditLog() async => entries;
}

Future<void> _pump(WidgetTester tester, List<AuditEntry> entries) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWith(
          (ref) => _Repo(entries) as MilkTraceRepository,
        ),
      ],
      child: const MaterialApp(home: AuditScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('olay Türkçe, hedef, ayrıntı ve yapan görünür', (tester) async {
    await _pump(tester, [
      AuditEntry(
        id: '1',
        at: DateTime.utc(2026, 9, 28, 6, 5),
        action: 'animal.update',
        target: 'TR340000008',
        detail: 'Durum: Sağmal → Kuruda',
        userName: 'Demo Çiftçi',
      ),
      AuditEntry(
        id: '2',
        at: DateTime.utc(2026, 9, 27, 6, 5),
        action: 'team.remove',
        target: 'Mehmet (op@x.tr)',
        userDeleted: true,
      ),
      AuditEntry(id: '3', at: DateTime.utc(2026, 9, 26), action: 'yeni.olay'),
    ]);

    expect(find.text('Hayvan kaydı değişti · TR340000008'), findsOneWidget);
    expect(find.text('Durum: Sağmal → Kuruda'), findsOneWidget);
    expect(find.textContaining('Demo Çiftçi · '), findsOneWidget);
    expect(find.text('Kullanıcı çıkarıldı · Mehmet (op@x.tr)'), findsOneWidget);
    expect(find.textContaining('Silinmiş kullanıcı · '), findsOneWidget);
    expect(
      find.text('yeni.olay'),
      findsOneWidget,
      reason: 'tanınmayan kod ham',
    );
  });

  testWidgets('boş kayıt açıklanır', (tester) async {
    await _pump(tester, const []);
    expect(find.text('Son 90 günde kayıtlı değişiklik yok.'), findsOneWidget);
  });
}
