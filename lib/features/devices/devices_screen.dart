import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/device.dart';
import 'package:milktrace/data/models/device_error.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/features/devices/devices_providers.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:milktrace/widgets/light_info.dart';
import 'package:milktrace/widgets/milk_palette.dart';

/// Bölge → ünite → nokta ağacı ve sayaçların çevrimiçi durumu (§15.1).
///
/// Sayaç sağlığı ile SÜT rengi ayrı şeylerdir: §6.2'de "cihaz çevrimdışı"
/// canlı tabloda GRİ görünür, çünkü orada anlatılan şey akışın olmaması.
/// Burada anlatılan şey cihazın kendisi; çevrimdışı bir sayaç müdahale
/// gerektirir ve KIRMIZIdır.
class DevicesScreen extends ConsumerWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tree = ref.watch(deviceTreeProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(deviceTreeProvider);
        await ref.read(deviceTreeProvider.future);
      },
      child: AsyncView(
        value: tree,
        errorMessage: l10n.devicesLoadFailed,
        onRetry: () => ref.invalidate(deviceTreeProvider),
        builder: (t) => ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          children: [
            _Summary(tree: t),
            if (hasMixedSources(t)) _Sources(tree: t),
            const SizedBox(height: AppSpacing.md),
            for (final hall in t.halls) ...[
              _HallSection(node: hall, showProtocol: hasMixedSources(t)),
              const SizedBox(height: AppSpacing.md),
            ],
            if (t.unassigned.isNotEmpty) _UnassignedCard(devices: t.unassigned),
          ],
        ),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.tree});

  final DeviceTree tree;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        LightInfo(
          color: AppColors.flowGreen,
          label: l10n.devicesOnlineCount(tree.online),
        ),
        LightInfo(
          color: AppColors.flowRed,
          label: l10n.devicesOfflineCount(tree.offline),
        ),
        // Sayaçsız nokta SAYILIR: sağım başladığında o noktadan hiç veri
        // gelmeyecek ve eksik ancak burada fark edilir.
        if (tree.emptySpouts > 0)
          LightInfo(
            color: AppColors.flowGrey,
            label: l10n.devicesEmptySpoutsCount(tree.emptySpouts),
          ),
        // Profili olmayan sayaç KARANTİNADA bekliyor (§8.4) ve verisi
        // işlenmiyor; sessizce gizlense eksik verinin sebebi aranamazdı.
        if (tree.unprofiled > 0)
          LightInfo(
            color: AppColors.flowYellow,
            label: l10n.devicesUnprofiledCount(tree.unprofiled),
          ),
      ],
    );
  }
}

/// Tesisteki veri kaynakları (§9.0).
///
/// YALNIZCA KARIŞIK tesiste görünür: tek kaynaklı bir tesiste "MILKTRACE 30"
/// yazmak hiçbir şey ayırt etmez. Faz 5'in demosu tam olarak bu satır —
/// native MQTT, üretici MQTT ve Modbus sayaçları aynı ekranda (§17).
///
/// Üretici adı VERİdir (§16/1); uygulama onu gösterir, ona göre davranmaz.
class _Sources extends StatelessWidget {
  const _Sources({required this.tree});

  final DeviceTree tree;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm, left: AppSpacing.xs),
      child: Wrap(
        spacing: AppSpacing.md,
        runSpacing: AppSpacing.xs,
        children: [
          Text(
            l10n.devicesSourcesLabel,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurfaceMuted,
            ),
          ),
          for (final s in tree.sources)
            Text(
              '${s.profile.vendor} · ${s.profile.protocolLabel} · ${s.count}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.onSurfaceMuted,
              ),
            ),
        ],
      ),
    );
  }
}

class _HallSection extends StatelessWidget {
  const _HallSection({required this.node, required this.showProtocol});

  final HallNode node;
  final bool showProtocol;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.xs,
            bottom: AppSpacing.sm,
          ),
          child: Text(
            l10n.devicesHallTitle(node.hall.name),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGreenColor,
            ),
          ),
        ),
        if (node.vacuums.isEmpty)
          _Card(
            child: Text(
              l10n.devicesHallNoVacuums,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.onSurfaceMuted,
              ),
            ),
          )
        else
          for (final v in node.vacuums) ...[
            _VacuumCard(node: v, showProtocol: showProtocol),
            const SizedBox(height: AppSpacing.sm),
          ],
      ],
    );
  }
}

class _VacuumCard extends StatelessWidget {
  const _VacuumCard({required this.node, required this.showProtocol});

  final VacuumNode node;
  final bool showProtocol;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    // Yakın zamanda hata bildiren sayaç da ilgilenilmeli sayılır: çevrimiçi
    // ama arızalı bir sayaç, kapalı bir ünitenin içinde kaybolmamalı.
    final problems = node.spouts
        .where(
          (s) =>
              s.device == null ||
              s.device!.status != 'online' ||
              s.device!.hasRecentError(now) ||
              s.device!.isCalibrationDue(now),
        )
        .length;

    return _Card(
      padding: EdgeInsets.zero,
      // Varsayılan olarak KAPALI ve sorunlu ünite AÇIK: 30 noktayı birden
      // açmak, ilgilenilmesi gereken iki satırı kaydırma içinde kaybederdi.
      child: ExpansionTile(
        initiallyExpanded: problems > 0,
        shape: const Border(),
        collapsedShape: const Border(),
        // Ok rengi TEMADAN değil token'dan: ColorScheme'in birincil rengi
        // mavi ve ok, yeşil paletin ortasında tek başına mavi duruyordu
        // (§15 tasarım dili).
        iconColor: AppColors.darkGreenColor,
        collapsedIconColor: AppColors.iconGreyColor,
        tilePadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        childrenPadding: const EdgeInsets.only(bottom: AppSpacing.sm),
        title: Text(
          l10n.devicesVacuumTitle(node.vacuum.name),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          problems == 0
              ? l10n.devicesVacuumAllOnline(node.spouts.length)
              : l10n.devicesVacuumProblems(node.spouts.length, problems),
          style: TextStyle(
            fontSize: 12,
            color: problems == 0 ? AppColors.onSurfaceMuted : AppColors.flowRed,
          ),
        ),
        children: [
          for (final s in node.spouts)
            _SpoutRow(node: s, showProtocol: showProtocol),
        ],
      ),
    );
  }
}

class _SpoutRow extends StatelessWidget {
  const _SpoutRow({required this.node, required this.showProtocol});

  final SpoutNode node;

  /// Karışık protokollü tesiste satırda protokol de yazılır.
  final bool showProtocol;

  @override
  Widget build(BuildContext context) {
    final device = node.device;
    final status = _DeviceStatus.of(device);
    final palette = MilkPalette.of(status.color);

    return InkWell(
      onTap: device == null ? null : () => _showDeviceSheet(context, device),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: palette.foreground,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            SizedBox(
              width: 68,
              child: Text(
                l10n.devicesSpoutLabel(node.spout.positionNo),
                style: const TextStyle(fontSize: 13),
              ),
            ),
            Expanded(
              child: Text(
                _serialLine(device),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.onSurfaceMuted,
                ),
              ),
            ),
            ConstrainedBox(
              // Uzun metin satırı taşırmasın: "Çevrimdışı · 24 dk" dar
              // ekranda seri numarasını dışarı itiyordu.
              constraints: const BoxConstraints(maxWidth: 132),
              child: Text(
                status.detail(device),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 11, color: palette.foreground),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _serialLine(Device? device) {
    if (device == null) return '—';
    if (!showProtocol) return device.serialNo;

    final protocol = device.profile?.protocolLabel ?? l10n.devicesNoProfile;
    return '${device.serialNo} · $protocol';
  }
}

class _UnassignedCard extends StatelessWidget {
  const _UnassignedCard({required this.devices});

  final List<Device> devices;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.devicesUnassignedTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.xs),
          // Bunlar ARIZA DEĞİL: dolapta bekleyen yedekler de buraya düşer.
          // Ayrı başlık altında olmaları, üstteki ağaçtaki eksikle
          // karıştırılmalarını önlüyor.
          Text(
            l10n.devicesUnassignedHint,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.onSurfaceMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final d in devices)
            InkWell(
              onTap: () => _showDeviceSheet(context, d),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  children: [
                    const Icon(
                      Icons.sensors_off_outlined,
                      size: 16,
                      color: AppColors.lightGreyColor,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        d.serialNo,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    Text(
                      l10n.devicesFirmwareShort(d.firmware ?? '—'),
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.onSurfaceMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Sayaç ayrıntısı.
///
/// Seri no, yazılım ve kalibrasyon katsayısı sahada TELEFONDAN okunuyor:
/// cihazın üstündeki etiket sağım sırasında görünmüyor ve destek hattı ilk
/// bunları soruyor.
void _showDeviceSheet(BuildContext context, Device device) {
  final status = _DeviceStatus.of(device);

  showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (_) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    device.serialNo,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: MilkPalette.of(status.color).filled.surface,
                    borderRadius: AppRadius.smAll,
                  ),
                  child: Text(
                    status.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: MilkPalette.of(status.color).foreground,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            // Profil §16/1 gereği VERİdir: uygulama üretici adını gösterir,
            // hiçbir yerde ona göre davranmaz.
            _DetailRow(
              l10n.devicesDetailProfile,
              device.profile?.title ?? l10n.devicesProfileUnassigned,
            ),
            _DetailRow(
              l10n.devicesDetailProtocol,
              device.profile?.protocolLabel ?? l10n.devicesUnknown,
            ),
            _DetailRow(
              l10n.devicesDetailFirmware,
              device.firmware ?? l10n.devicesUnknown,
            ),
            _DetailRow(
              l10n.devicesDetailCalibration,
              device.calibrationFactor.toStringAsFixed(3),
            ),
            // Kalibrasyon günü (backend ADR 0097); kurulum ekibi girer.
            _DetailRow(
              l10n.devicesDetailCalibratedAt,
              device.calibratedAt == null
                  ? l10n.devicesCalibrationNoRecord
                  : Fmt.dayMonthYear(device.calibratedAt!),
            ),
            if (device.calibrationDueAt case final due?)
              _DetailRow(
                l10n.devicesDetailCalibrationDue,
                device.isCalibrationDue(DateTime.now())
                    ? l10n.devicesCalibrationOverdue(Fmt.dayMonthYear(due))
                    : Fmt.dayMonthYear(due),
              ),
            _DetailRow(
              l10n.devicesDetailLastSeen,
              device.lastSeenAt == null
                  ? l10n.devicesNoRecord
                  : '${Fmt.since(device.lastSeenAt!)} '
                        '(${Fmt.dayMonth(device.lastSeenAt!)} '
                        '${Fmt.time(device.lastSeenAt!)})',
            ),
            _DetailRow(
              l10n.devicesDetailLastError,
              _lastErrorText(device.lastError),
            ),
            if (device.isSimulated)
              // Simülatör cihazı GÖRÜNÜR olmalı: demo verisini gerçek sanıp
              // sahada arayan olmasın (§10).
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.md),
                child: Row(
                  children: [
                    const Icon(
                      Icons.science_outlined,
                      size: 14,
                      color: AppColors.lightGreyColor,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      l10n.devicesSimulated,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.onSurfaceMuted,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

/// Son hata satırı: "E17 · Akış sensörü arızası (3 sa önce, 24.09 14:48)".
/// Açıklama profilin tablosundan gelir; yoksa kod ham kalır.
String _lastErrorText(DeviceError? e) {
  if (e == null) return l10n.devicesNoRecord;
  final what = e.description == null ? e.code : '${e.code} · ${e.description}';
  return '$what (${Fmt.since(e.at)}, '
      '${Fmt.dayMonth(e.at)} ${Fmt.time(e.at)})';
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.onSurfaceMuted,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

/// Sayacın durumu: etiket, renk ve satır sonundaki kısa açıklama.
class _DeviceStatus {
  const _DeviceStatus(this.label, this.color);

  final String label;
  final MilkColor color;

  /// Cihaz yoksa nokta BOŞtur — "bilinmiyor" ile aynı şey değil.
  static _DeviceStatus of(Device? device) => switch (device?.status) {
    null => _DeviceStatus(l10n.devicesStatusNoMeter, MilkColor.grey),
    // Çevrimiçi ama son 24 saatte hata bildirdi: SARI, kırmızı değil.
    // Sayaç veri gönderiyor; arıza kodu ilgilenilmesi gereken bir işaret,
    // çevrimdışı kadar acil değil (backend ADR 0044).
    'online' when device!.hasRecentError(DateTime.now()) => _DeviceStatus(
      l10n.devicesStatusReportedError,
      MilkColor.yellow,
    ),
    // Kalibrasyon zamanı (backend ADR 0097): bakım işareti, SARI.
    'online' when device!.isCalibrationDue(DateTime.now()) => _DeviceStatus(
      l10n.devicesStatusCalibrationDue,
      MilkColor.yellow,
    ),
    'online' => _DeviceStatus(l10n.devicesStatusOnline, MilkColor.green),
    'offline' => _DeviceStatus(l10n.devicesStatusOffline, MilkColor.red),
    _ => _DeviceStatus(l10n.devicesUnknown, MilkColor.grey),
  };

  /// Satır sonunda görünen metin.
  ///
  /// Çevrimiçi sayaçta "Çevrimiçi" yazmak yerine SON GÖRÜLME yazılır: 30
  /// satırın 27'sinde aynı kelimeyi tekrarlamak, farklı olan üçünü
  /// gizlerdi.
  ///
  /// Sorunlu durumlarda etiket YAZIYLA da durur: durumu yalnızca renge
  /// bırakmak, renk körü bir kullanıcı için satırı okunamaz yapardı.
  String detail(Device? device) {
    final err = device?.lastError;
    if (device?.status == 'online' &&
        err != null &&
        device!.hasRecentError(DateTime.now())) {
      return l10n.devicesErrorShort(err.code, Fmt.sinceShort(err.at));
    }
    if (device?.status == 'online' &&
        device!.isCalibrationDue(DateTime.now())) {
      return label;
    }
    final seen = device?.lastSeenAt;
    if (seen == null) return label;
    if (device?.status == 'online') return Fmt.since(seen);
    return '$label · ${Fmt.sinceShort(seen)}';
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) => Container(
    padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: AppRadius.mdAll,
      border: Border.all(color: AppColors.border),
    ),
    clipBehavior: Clip.antiAlias,
    child: child,
  );
}
