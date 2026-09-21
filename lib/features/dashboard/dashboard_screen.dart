import 'package:flutter/material.dart';
import 'package:milktrace/widgets/stub_screen.dart';

/// Günün özeti: toplam süt, tür bazında dağılım, sınıf dağılımı, açık
/// uyarılar (§15.1).
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StubScreen(
      title: 'Dashboard',
      icon: Icons.dashboard_outlined,
      description: 'Günün özeti, tür bazında toplam süt, verim sınıfı dağılımı '
          've açık uyarılar burada görünecek.',
      phase: 'Faz 4',
    );
  }
}
