import 'package:milktrace/data/models/notification_channel.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_channels_providers.g.dart';

/// İşletmenin bildirim kanalları. Ada göre sıralı: yeni eklenen kanalın
/// listenin neresinde çıkacağı tahmin edilebilir olsun.
@riverpod
Future<List<NotificationChannel>> notificationChannelList(Ref ref) async {
  final list = [...await ref.watch(repositoryProvider).notificationChannels()];
  list.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  return List.unmodifiable(list);
}

/// Kanal türleri ve ayar alanları; formu çizmek için.
@riverpod
Future<List<NotificationProvider>> notificationProviderList(Ref ref) =>
    ref.watch(repositoryProvider).notificationProviders();
