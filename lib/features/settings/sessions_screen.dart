import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/user_session.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sessions_screen.g.dart';

/// Açık oturumlar (backend ADR 0105).
@riverpod
Future<List<UserSession>> loginSessions(Ref ref) =>
    ref.watch(repositoryProvider).loginSessions();

/// Kişinin açık oturumları: cihaz/tarayıcı, son kullanım; tek tek ya da
/// "diğer bütün cihazlardan çık". Kaybolan telefonu kapatmanın yolu.
class SessionsScreen extends ConsumerWidget {
  const SessionsScreen({super.key});

  Future<void> _run(
    BuildContext context,
    WidgetRef ref,
    Future<void> Function() action,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await action();
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? '$e'),
          backgroundColor: AppColors.dangerFill,
        ),
      );
    } finally {
      ref.invalidate(loginSessionsProvider);
    }
  }

  String _title(UserSession s) {
    final k = s.kind;
    if (!k.app) return l10n.sessionsBrowser;
    return switch (k.platform) {
      'android' => l10n.sessionsAppAndroid,
      'ios' => l10n.sessionsAppIos,
      _ => l10n.sessionsApp,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(loginSessionsProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.sessionsTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: AsyncView(
        value: list,
        errorMessage: l10n.commonLoadFailed,
        onRetry: () => ref.invalidate(loginSessionsProvider),
        builder: (sessions) {
          final others = sessions.where((s) => !s.current).length;
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Text(
                l10n.sessionsIntro,
                style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
              ),
              const SizedBox(height: AppSpacing.md),
              for (final s in sessions)
                Card(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: ListTile(
                    leading: Icon(
                      s.kind.app ? Icons.smartphone : Icons.laptop,
                      color: AppColors.darkGreenColor,
                    ),
                    title: Text(
                      s.current
                          ? '${_title(s)} · ${l10n.sessionsThisDevice}'
                          : _title(s),
                    ),
                    subtitle: Text(
                      [
                        if (s.lastUsedAt case final t?)
                          l10n.sessionsLastUsed(Fmt.since(t)),
                        if (s.ip.isNotEmpty) s.ip,
                      ].join(' · '),
                    ),
                    trailing: s.current
                        ? null
                        : IconButton(
                            tooltip: l10n.sessionsSignOut,
                            icon: const Icon(Icons.logout),
                            onPressed: () => _run(
                              context,
                              ref,
                              () => ref
                                  .read(repositoryProvider)
                                  .revokeLoginSession(s.id),
                            ),
                          ),
                  ),
                ),
              if (others > 0) ...[
                const SizedBox(height: AppSpacing.md),
                OutlinedButton.icon(
                  onPressed: () => _run(
                    context,
                    ref,
                    () =>
                        ref.read(repositoryProvider).revokeOtherLoginSessions(),
                  ),
                  icon: const Icon(Icons.phonelink_erase),
                  label: Text(l10n.sessionsSignOutOthers),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkRedColor,
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
