import 'package:milktrace/data/models/dashboard_summary.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_providers.g.dart';

/// Günün özeti (§8.5 GET /dashboard).
@riverpod
Future<DashboardSummary> dashboardSummary(Ref ref) =>
    ref.watch(repositoryProvider).dashboard();
