import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';

/// Açılış ekranı.
///
/// Eskiden 2 saniyelik bir Timer'la kendi kendine /live'a giderdi. Artık
/// yönlendirmeyi YAPMAZ: oturumun geri yüklenip yüklenmediğini router'ın
/// redirect'i bilir ve hazır olduğunda buradan çıkarır. İki yönlendirme
/// kaynağı olsaydı, token okuması 2 saniyeden uzun sürdüğünde uygulama
/// giriş yapmamış hâlde /live'a düşerdi.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Milk Trace',
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: AppColors.darkGreenColor,
              ),
            ),
            SizedBox(height: AppSpacing.xl),
            SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: AppColors.darkGreenColor),
            ),
          ],
        ),
      ),
    );
  }
}
