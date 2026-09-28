import 'package:milktrace/core/volume.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'catalog_providers.g.dart';

/// Nadiren değişen katalog verisi: bölgeler, türler, eşikler, hayvanlar.
///
/// ÜÇ SEKME de bunları okuyor (Canlı, Geçmiş, Cihazlar). Önce canlı ekranın
/// kendi dosyasındaydılar; Geçmiş'in Canlı'dan provider almak zorunda
/// kalması, iki sekmeyi birbirine gereksiz yere bağlardı.
@riverpod
Future<List<Hall>> halls(Ref ref) => ref.watch(repositoryProvider).halls();

@riverpod
Future<List<Species>> speciesList(Ref ref) =>
    ref.watch(repositoryProvider).species();

@riverpod
Future<List<Thresholds>> thresholdsList(Ref ref) =>
    ref.watch(repositoryProvider).thresholds();

@riverpod
Future<List<Animal>> animals(Ref ref) =>
    ref.watch(repositoryProvider).animals();

/// Süt miktarı biçimi: işletmenin birimi ve türlerin yoğunluğu (backend
/// ADR 0086). Eşik ya da tür listesi okunamazsa birim yine uygulanır,
/// yoğunluk varsayılana (1,03) düşer.
@riverpod
VolumeFormat volumeFormat(Ref ref) {
  final unit = ref.watch(authProvider).user?.volumeUnit ?? 'L';
  if (unit != 'kg') return VolumeFormat.litre;
  return VolumeFormat.from(
    unit,
    ref.watch(thresholdsListProvider).value ?? const [],
    ref.watch(speciesListProvider).value ?? const [],
  );
}
