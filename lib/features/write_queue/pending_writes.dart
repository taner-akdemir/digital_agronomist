import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/write_queue/pending_write.dart';
import 'package:milktrace/data/write_queue/write_sender.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/write_queue_providers.dart';

/// Kuyruk ekranının yolu (backend ADR 0140).
const pendingWritesRoute = '/pending-writes';

/// Kaydın başlığı: "Not", "Tedavi", "Tohumlama · B-77", "Buzağılama".
String pendingTitle(PendingWrite w) {
  final p = w.payload;
  return switch (w.kind) {
    PendingKind.note => l10n.writeQueueKindNote,
    PendingKind.treatment => [
      l10n.writeQueueKindTreatment,
      if (p['drug'] case final String d when d.isNotEmpty) d,
    ].join(' · '),
    PendingKind.vaccination => [
      l10n.writeQueueKindVaccination,
      if (p['planName'] case final String n when n.isNotEmpty) n,
    ].join(' · '),
    PendingKind.calving => l10n.writeQueueKindCalving,
    PendingKind.breeding => switch (p['kind']) {
      'heat' => l10n.breedingHeat,
      'pregnancy_check' => l10n.modelBreedingPregnancyCheck(
        p['result'] == 'pregnant'
            ? l10n.modelBreedingResultPregnant
            : l10n.modelBreedingResultOpen,
      ),
      _ => [
        l10n.modelBreedingInsemination,
        if (p['sire'] case final String s when s.isNotEmpty) s,
      ].join(' · '),
    },
  };
}

/// Ayrıntı satırı: konu (küpe), kaydın günü ya da not metni.
String pendingDetail(PendingWrite w) {
  final p = w.payload;
  String? day(String k) =>
      p[k] is String ? Fmt.dayMonthYear(PendingPayload.parseDay(p[k])) : null;
  final what = switch (w.kind) {
    PendingKind.note => p['note'] as String?,
    PendingKind.breeding || PendingKind.calving => day('date'),
    PendingKind.treatment => day('startedOn'),
    PendingKind.vaccination => [
      day('givenOn'),
      if (p['animalIds'] case final List<dynamic> ids when ids.length > 1)
        l10n.writeQueueAnimals(ids.length),
    ].whereType<String>().join(' · '),
  };
  return [
    if (w.subject.isNotEmpty) w.subject,
    if (what != null && what.isNotEmpty) what,
  ].join(' · ');
}

/// Gönderilemeyen kaydın nedeni; bekleyende null.
String? pendingReason(PendingWrite w) => switch (w.failure) {
  null => null,
  PendingFailure.expired => l10n.writeQueueExpired,
  PendingFailure.retries => [
    l10n.writeQueueRetries,
    if (w.error case final e? when e.isNotEmpty) e,
  ].join(' '),
  PendingFailure.rejected => w.error ?? '',
};

/// Hayvanın listede gösterilecek adı: küpe (ad).
String animalSubject(WidgetRef ref, String animalId) {
  final a = ref
      .read(animalsProvider)
      .value
      ?.where((x) => x.id == animalId)
      .firstOrNull;
  if (a == null) return '';
  return [a.earTag, if (a.name case final n? when n.isNotEmpty) n].join(' · ');
}

/// "Kuyruğa alındı" bildirimi: amber, hata değil.
SnackBar writeQueuedSnackBar() => SnackBar(
  content: Text(l10n.writeQueueQueued),
  backgroundColor: AppColors.warningFill,
);

/// "Bekliyor" / "Gönderilemedi" etiketi.
class PendingChip extends StatelessWidget {
  const PendingChip({super.key, required this.write});

  final PendingWrite write;

  @override
  Widget build(BuildContext context) {
    final failed = write.isFailed;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: failed ? AppColors.lightRedColor : AppColors.lightAmberColor,
        borderRadius: AppRadius.mdAll,
      ),
      child: Text(
        failed ? l10n.writeQueueFailedChip : l10n.writeQueuePendingChip,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: failed ? AppColors.darkRedColor : AppColors.darkAmberColor,
        ),
      ),
    );
  }
}

/// Bir hayvanın kuyruktaki kayıtları, ilgili kartın içinde (iyimser
/// gösterim, ADR 0140/3): sunucuya henüz gitmedi, açıkça işaretli.
/// Dokununca kuyruk ekranı açılır.
class PendingWritesStrip extends ConsumerWidget {
  const PendingWritesStrip({
    super.key,
    required this.animalId,
    required this.kinds,
  });

  final String animalId;
  final Set<PendingKind> kinds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = [
      for (final w in ref.watch(writeQueueProvider))
        if (kinds.contains(w.kind) && _concerns(w)) w,
    ];
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final w in items)
          InkWell(
            onTap: () => context.push(pendingWritesRoute),
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Row(
                children: [
                  Icon(
                    w.isFailed ? Icons.error_outline : Icons.schedule,
                    size: 16,
                    color: w.isFailed
                        ? AppColors.darkRedColor
                        : AppColors.darkAmberColor,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      [
                        pendingTitle(w),
                        if (_detail(w) case final d when d.isNotEmpty) d,
                      ].join(' · '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.onSurfaceMuted,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  PendingChip(write: w),
                ],
              ),
            ),
          ),
      ],
    );
  }

  bool _concerns(PendingWrite w) =>
      w.animalId == animalId ||
      (w.payload['animalIds'] is List &&
          (w.payload['animalIds'] as List).contains(animalId));

  // Hayvanın kendi kartında konu (küpe) tekrar yazılmaz.
  String _detail(PendingWrite w) => pendingDetail(w.copyWith(subject: ''));
}

/// Kabuktaki gösterge: "3 kayıt gönderilmeyi bekliyor · 1 kayıt
/// gönderilemedi". Kuyruk boşken yok; dokununca kuyruk ekranı.
class PendingWritesBanner extends ConsumerWidget {
  const PendingWritesBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(writeQueueProvider);
    if (items.isEmpty) return const SizedBox.shrink();
    final pending = items.where((w) => w.isPending).length;
    final failed = items.length - pending;
    final text = [
      if (pending > 0) l10n.writeQueueBannerPending(pending),
      if (failed > 0) l10n.writeQueueBannerFailed(failed),
    ].join(' · ');
    final fg = failed > 0 ? AppColors.darkRedColor : AppColors.darkAmberColor;
    return Material(
      color: failed > 0 ? AppColors.lightRedColor : AppColors.lightAmberColor,
      child: InkWell(
        onTap: () => context.push(pendingWritesRoute),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Badge.count(
                count: items.length,
                backgroundColor: fg,
                child: Icon(Icons.cloud_upload_outlined, size: 18, color: fg),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(text, style: TextStyle(fontSize: 12, color: fg)),
              ),
              Icon(Icons.chevron_right, size: 18, color: fg),
            ],
          ),
        ),
      ),
    );
  }
}

/// Kuyruğu boşaltma tetikleyicileri (ADR 0140/6): uygulama öne gelince ve
/// bekleyen varken [interval]'da bir. Zamanlayıcı yalnızca bekleyen kayıt
/// varken çalışır; bağlantı dönüşü sağlayıcının içinde dinlenir.
class WriteQueueListener extends ConsumerStatefulWidget {
  const WriteQueueListener({
    super.key,
    required this.child,
    this.interval = const Duration(seconds: 30),
  });

  final Widget child;
  final Duration interval;

  @override
  ConsumerState<WriteQueueListener> createState() => _WriteQueueListenerState();
}

class _WriteQueueListenerState extends ConsumerState<WriteQueueListener> {
  AppLifecycleListener? _lifecycle;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(onResume: _flush);
  }

  void _flush() => unawaited(ref.read(writeQueueProvider.notifier).flush());

  void _sync(bool hasPending) {
    if (hasPending && _timer == null) {
      _timer = Timer.periodic(widget.interval, (_) => _flush());
    } else if (!hasPending && _timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _lifecycle?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasPending = ref.watch(
      writeQueueProvider.select((l) => l.any((w) => w.isPending)),
    );
    _sync(hasPending);
    return widget.child;
  }
}
