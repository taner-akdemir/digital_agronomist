import 'package:flutter/material.dart';
import 'package:milktrace/widgets/stub_screen.dart';

/// Bölge → ünite → nokta ağacı ve cihazların çevrimiçi durumu (§15.1).
class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StubScreen(
      title: 'Cihazlar',
      icon: Icons.sensors,
      description: 'Bölge → ünite → nokta ağacı ve sayaçların çevrimiçi/'
          'çevrimdışı durumu burada görünecek.',
      phase: 'Faz 3',
    );
  }
}
