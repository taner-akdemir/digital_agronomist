import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/dairy.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dairy_sharing_screen.g.dart';

/// İşletmenin mandıra paylaşım onayları (backend ADR 0137). Önbelleklenmez.
@riverpod
Future<List<DairyShare>> dairyShares(Ref ref) =>
    ref.watch(repositoryProvider).dairyShares();

/// Onay verilebilecek mandıralar.
@riverpod
Future<List<Dairy>> dairies(Ref ref) => ref.watch(repositoryProvider).dairies();

/// Entegrasyonlar → Mandıra paylaşımı: hesap kartından, YALNIZCA işletme
/// sahibine (backend diğer rollere 403).
///
/// Veri VARSAYILAN OLARAK GİZLİDİR: çiftçi mandırayı seçip açık rızasıyla ve
/// seçtiği süreyle onay vermedikçe mandıraya hiçbir veri akmaz. Ekran neyin
/// paylaşılıp neyin paylaşılmadığını onaydan ÖNCE söyler; onay kutusu
/// işaretlenmeden düğme açılmaz. İptal tek dokunuş ve anında.
class DairySharingScreen extends ConsumerWidget {
  const DairySharingScreen({super.key});

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final share = await showModalBottomSheet<DairyShare>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.surface,
      builder: (_) => const _GrantSheet(),
    );
    if (share == null) return;
    ref.invalidate(dairySharesProvider);
    messenger.showSnackBar(
      SnackBar(
        content: Text(l10n.dairyGranted(share.dairyName)),
        backgroundColor: AppColors.brandFill,
      ),
    );
  }

  Future<void> _revoke(
    BuildContext context,
    WidgetRef ref,
    DairyShare s,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.dairyRevokeTitle),
        content: Text(l10n.dairyRevokeBody(s.dairyName)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.dangerFill,
            ),
            child: Text(l10n.dairyRevoke),
          ),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await ref.read(repositoryProvider).revokeDairyShare(s.id);
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.dairyRevoked),
          backgroundColor: AppColors.brandFill,
        ),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.commonSaveFailed(e)),
          backgroundColor: AppColors.dangerFill,
        ),
      );
    } finally {
      ref.invalidate(dairySharesProvider);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(dairySharesProvider);
    final muted = TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted);
    final heading = TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.darkGreenColor,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.dairyTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _add(context, ref),
        backgroundColor: AppColors.brandFill,
        foregroundColor: AppColors.onFill,
        icon: const Icon(Icons.handshake_outlined),
        label: Text(l10n.dairyAdd),
      ),
      body: AsyncView(
        value: list,
        errorMessage: l10n.commonLoadFailed,
        onRetry: () => ref.invalidate(dairySharesProvider),
        builder: (shares) {
          final active = [
            for (final s in shares)
              if (s.isActive) s,
          ];
          final past = [
            for (final s in shares)
              if (!s.isActive) s,
          ];
          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              96,
            ),
            children: [
              Text(
                l10n.dairyPitch,
                style: TextStyle(color: AppColors.darkGreenColor),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(l10n.dairyPrivateByDefault, style: muted),
              const SizedBox(height: AppSpacing.md),
              _InfoBox(
                title: l10n.dairySharedTitle,
                body: l10n.dairySharedItems,
                icon: Icons.visibility_outlined,
              ),
              const SizedBox(height: AppSpacing.sm),
              _InfoBox(
                title: l10n.dairyNotSharedTitle,
                body: l10n.dairyNotSharedItems,
                icon: Icons.visibility_off_outlined,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(l10n.dairyActiveTitle, style: heading),
              const SizedBox(height: AppSpacing.sm),
              if (active.isEmpty) Text(l10n.dairyNoActive, style: muted),
              for (final s in active)
                Card(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: ListTile(
                    leading: Icon(
                      Icons.handshake_outlined,
                      color: AppColors.darkGreenColor,
                    ),
                    title: Text(_name(s)),
                    subtitle: Text(
                      [
                        l10n.dairySince(Fmt.dayMonthYear(s.grantedAt)),
                        if (s.expiresAt case final t?)
                          l10n.dairyUntil(Fmt.dayMonthYear(t))
                        else
                          l10n.dairyUnlimited,
                      ].join(' · '),
                    ),
                    trailing: TextButton(
                      onPressed: () => _revoke(context, ref, s),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.darkRedColor,
                      ),
                      child: Text(l10n.dairyRevoke),
                    ),
                  ),
                ),
              if (past.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.dairyHistoryTitle, style: heading),
                for (final s in past)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      _name(s),
                      style: TextStyle(color: AppColors.onSurfaceMuted),
                    ),
                    subtitle: Text(
                      [
                        l10n.dairySince(Fmt.dayMonthYear(s.grantedAt)),
                        if (s.revokedAt case final t?)
                          l10n.dairyRevokedAt(Fmt.dayMonthYear(t))
                        else
                          l10n.dairyExpired,
                      ].join(' · '),
                      style: muted,
                    ),
                  ),
              ],
            ],
          );
        },
      ),
    );
  }

  static String _name(DairyShare s) =>
      s.dairyCity.isEmpty ? s.dairyName : '${s.dairyName} · ${s.dairyCity}';
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.title, required this.body, required this.icon});

  final String title;
  final String body;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.smAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.darkGreenColor),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(body, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Onay penceresi: mandıra, süre ve AÇIK RIZA kutusu.
class _GrantSheet extends ConsumerStatefulWidget {
  const _GrantSheet();

  @override
  ConsumerState<_GrantSheet> createState() => _GrantSheetState();
}

class _GrantSheetState extends ConsumerState<_GrantSheet> {
  Dairy? _dairy;
  SharePeriod _period = SharePeriod.oneYear;
  bool _consent = false;
  bool _busy = false;
  String? _error;

  Future<void> _submit() async {
    final d = _dairy;
    if (d == null || !_consent) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final share = await ref
          .read(repositoryProvider)
          .grantDairyShare(dairyId: d.id, period: _period);
      if (mounted) Navigator.of(context).pop(share);
    } catch (e) {
      setState(() {
        _busy = false;
        _error = userMessage(e) ?? l10n.commonSaveFailed(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dairies = ref.watch(dairiesProvider);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.dairyAddTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.md),
            AsyncView(
              value: dairies,
              errorMessage: l10n.commonLoadFailed,
              onRetry: () => ref.invalidate(dairiesProvider),
              builder: (list) => list.isEmpty
                  ? Text(l10n.dairyNoDairies)
                  : DropdownButtonFormField<Dairy>(
                      initialValue: _dairy,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: l10n.dairySelect,
                        border: const OutlineInputBorder(
                          borderRadius: AppRadius.smAll,
                        ),
                      ),
                      items: [
                        for (final d in list)
                          DropdownMenuItem(
                            value: d,
                            child: Text(
                              d.city.isEmpty ? d.name : '${d.name} · ${d.city}',
                            ),
                          ),
                      ],
                      onChanged: _busy
                          ? null
                          : (d) => setState(() => _dairy = d),
                    ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.dairyPeriod),
            const SizedBox(height: AppSpacing.xs),
            SegmentedButton<SharePeriod>(
              segments: [
                ButtonSegment(
                  value: SharePeriod.threeMonths,
                  label: Text(l10n.dairyPeriod3m),
                ),
                ButtonSegment(
                  value: SharePeriod.oneYear,
                  label: Text(l10n.dairyPeriod1y),
                ),
                ButtonSegment(
                  value: SharePeriod.unlimited,
                  label: Text(l10n.dairyPeriodUnlimited),
                ),
              ],
              selected: {_period},
              onSelectionChanged: _busy
                  ? null
                  : (v) => setState(() => _period = v.single),
            ),
            const SizedBox(height: AppSpacing.md),
            CheckboxListTile(
              value: _consent,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: _busy
                  ? null
                  : (v) => setState(() => _consent = v ?? false),
              title: Text(
                l10n.dairyConsent(_dairy?.name ?? l10n.dairyConsentPlaceholder),
                style: const TextStyle(fontSize: 13),
              ),
            ),
            if (_error case final e?) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(e, style: TextStyle(color: AppColors.darkRedColor)),
            ],
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: _busy || _dairy == null || !_consent ? null : _submit,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.brandFill,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              ),
              child: Text(l10n.dairyGrant),
            ),
          ],
        ),
      ),
    );
  }
}
