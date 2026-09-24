import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/notification_channel.dart';
import 'package:milktrace/features/settings/channel_labels.dart';
import 'package:milktrace/features/settings/notification_channels_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';

/// İşletmenin bildirim kanalları (backend docs/adr/0028).
///
/// Push her zaman gider; buradaki kanallar ONUN YANINDA e-posta, Slack,
/// Teams, SMS, sesli arama ya da webhook ekler. Yalnızca işletme sahibi
/// açabilir: kanallar alıcı telefonlarını ve API anahtarlarını taşır.
class NotificationChannelsScreen extends ConsumerWidget {
  const NotificationChannelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channels = ref.watch(notificationChannelListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Geri',
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Bildirim kanalları',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _pickProvider(context, ref),
        backgroundColor: AppColors.darkGreenColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Kanal ekle'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(notificationChannelListProvider.future),
        child: AsyncView(
          value: channels,
          errorMessage: 'Kanallar yüklenemedi',
          builder: (list) => ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              96, // FAB son kartın üstüne binmesin
            ),
            children: [
              const _PushNote(),
              const SizedBox(height: AppSpacing.md),
              if (list.isEmpty)
                const _EmptyState()
              else
                for (final c in list) _ChannelCard(channel: c),
            ],
          ),
        ),
      ),
    );
  }

  /// Önce tür ve sağlayıcı seçilir; form onun alanlarıyla çizilir.
  Future<void> _pickProvider(BuildContext context, WidgetRef ref) async {
    final picked = await showModalBottomSheet<NotificationProvider>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (_) => const _ProviderPicker(),
    );
    if (picked != null && context.mounted) {
      await context.push(
        '/settings/notifications/new'
        '?kind=${picked.kind}&provider=${picked.provider}',
      );
    }
  }
}

class _PushNote extends StatelessWidget {
  const _PushNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.flowGreenSurface,
        borderRadius: AppRadius.smAll,
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.notifications_active_outlined,
            size: 16,
            color: AppColors.darkGreenColor,
          ),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Uyarılar telefon bildirimi olarak her zaman gelir. Buradaki '
              'kanallar ek olarak e-posta, Slack, SMS gibi yollarla da '
              'gönderir.',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.darkGreenColor,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Column(
        children: [
          Icon(
            Icons.notifications_none,
            size: 40,
            color: AppColors.lightGreyColor,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Henüz kanal yok',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'E-posta ya da SMS ile de uyarı almak için kanal ekleyin.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.onSurfaceMuted, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _ChannelCard extends ConsumerWidget {
  const _ChannelCard({required this.channel});

  final NotificationChannel channel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = channel;
    // Slack, Teams ve webhook'ta sağlayıcı türle aynı ad: "Slack · Slack"
    // yazmasın.
    final provider = channelProviderLabel(c.provider);
    final subtitle = [
      channelKindLabel(c.kind),
      if (provider != channelKindLabel(c.kind) && c.kind != c.provider)
        provider,
      if (c.recipients.isNotEmpty) _recipientSummary(c),
    ].join(' · ');

    return Card(
      elevation: 0,
      color: AppColors.surface,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.mdAll,
        side: BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: AppRadius.mdAll,
        onTap: () => context.push('/settings/notifications/${c.id}'),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: c.enabled
                    ? AppColors.lightGreenColor
                    : AppColors.veryLightGreyColor,
                child: Icon(
                  channelKindIcon(c.kind),
                  size: 20,
                  color: c.enabled
                      ? AppColors.darkGreenColor
                      : AppColors.lightGreyColor,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.onSurfaceMuted,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    // Durum yalnızca renge bırakılmaz: kapalı kanal yazıyla
                    // da söylenir (Cihazlar ekranındaki kural).
                    Text(
                      c.enabled
                          ? '${severityLabel(c.minSeverity)} ve üstü · '
                                '${c.sources.map(sourceLabel).join(', ')}'
                          : 'Kapalı',
                      style: TextStyle(
                        fontSize: 11,
                        color: c.enabled
                            ? AppColors.darkGreenColor
                            : AppColors.lightGreyColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: c.enabled,
                activeThumbColor: AppColors.darkGreenColor,
                onChanged: (on) => _toggle(context, ref, on),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _recipientSummary(NotificationChannel c) => c.recipients.length == 1
      ? c.recipients.first
      : '${c.recipients.first} +${c.recipients.length - 1}';

  /// Aç/kapat: yalnızca `enabled` değişir; ayarlar (ve sırlar) korunur çünkü
  /// config boş gönderilir ve güncelleme kısmidir.
  Future<void> _toggle(BuildContext context, WidgetRef ref, bool on) async {
    final c = channel;
    try {
      await ref
          .read(repositoryProvider)
          .updateNotificationChannel(
            c.id,
            NotificationChannelDraft(
              name: c.name,
              kind: c.kind,
              provider: c.provider,
              config: const {},
              recipients: c.recipients,
              minSeverity: c.minSeverity,
              sendResolved: c.sendResolved,
              enabled: on,
              sources: c.sources,
            ),
          );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(userMessage(e) ?? 'Kaydedilemedi: $e'),
            backgroundColor: AppColors.flowRed,
          ),
        );
      }
    } finally {
      ref.invalidate(notificationChannelListProvider);
    }
  }
}

class _ProviderPicker extends ConsumerWidget {
  const _ProviderPicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providers = ref.watch(notificationProviderListProvider);

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.7,
        child: AsyncView(
          value: providers,
          errorMessage: 'Kanal türleri yüklenemedi',
          builder: (list) {
            // Türe göre gruplanır: çiftçi önce "SMS mi e-posta mı"yı seçer,
            // sağlayıcıyı sonra.
            final byKind = <String, List<NotificationProvider>>{};
            for (final p in list) {
              byKind.putIfAbsent(p.kind, () => []).add(p);
            }
            const order = ['email', 'sms', 'ivr', 'slack', 'teams', 'webhook'];
            final kinds = byKind.keys.toList()
              ..sort((a, b) {
                final ia = order.indexOf(a), ib = order.indexOf(b);
                return (ia < 0 ? 99 : ia).compareTo(ib < 0 ? 99 : ib);
              });
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              children: [
                const Text(
                  'Kanal türü',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: AppSpacing.sm),
                for (final kind in kinds) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.md),
                    child: Row(
                      children: [
                        Icon(
                          channelKindIcon(kind),
                          size: 16,
                          color: AppColors.onSurfaceMuted,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          channelKindLabel(kind),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.onSurfaceMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: AppSpacing.sm,
                    children: [
                      for (final p in byKind[kind]!)
                        ActionChip(
                          label: Text(channelProviderLabel(p.provider)),
                          onPressed: () => Navigator.of(context).pop(p),
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
              ],
            );
          },
        ),
      ),
    );
  }
}
