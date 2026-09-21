import 'package:flutter/material.dart';
import 'package:milktrace/widgets/stub_screen.dart';

/// Oturum listesi, hayvan listesi ve hayvan detayı: verim grafiği ve
/// trend (§15.1).
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StubScreen(
      title: 'Geçmiş',
      icon: Icons.history,
      description: 'Geçmiş sağım oturumları, hayvan bazında verim grafiği ve '
          '7/30 günlük trend burada görünecek.',
      phase: 'Faz 4',
    );
  }
}
