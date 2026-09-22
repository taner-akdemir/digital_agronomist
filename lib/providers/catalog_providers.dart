import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/thresholds.dart';
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
Future<List<Animal>> animals(Ref ref) => ref.watch(repositoryProvider).animals();
