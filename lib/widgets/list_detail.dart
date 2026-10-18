import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';

/// Liste–detay (iki bölme) yerleşimi (backend ADR 0141).
///
/// Yer yetiyorsa (bölmenin KENDİ genişliği ≥ [minTwoPaneWidth]) solda
/// liste, sağda detay; yetmiyorsa yalnızca liste ve detay eskisi gibi ayrı
/// ekranda açılır. Karar pencereye değil bölmenin genişliğine bakar: yan
/// rayın kapladığı yer düşülmüş olur.
///
/// Liste dokunuşta ne yapacağını [ListDetailScope.isTwoPane] ile sorar:
/// iki bölmede seçer, tek bölmede gezinir.
class ListDetail extends StatelessWidget {
  const ListDetail({
    super.key,
    required this.list,
    required this.detail,
    required this.placeholder,
  });

  final Widget list;

  /// Seçili kaydın detayı; seçim yoksa null ve [placeholder] çizilir.
  final Widget? detail;

  /// Seçim yokken sağ bölme ("Soldan bir hayvan seçin").
  final Widget placeholder;

  /// Liste ≥ 320 + detay ≥ 360. Dikey 10" tablette (800, ray 80) iki
  /// bölme; 7" dikey tablette (600) tek bölme.
  static const double minTwoPaneWidth = 680;

  static bool fits(double width) => width >= minTwoPaneWidth;

  /// Liste bölmesinin genişliği: genişliğin %38'i, 320–420 arası.
  static double listWidth(double width) =>
      (width * 0.38).clamp(320.0, 420.0).toDouble();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => fits(constraints.maxWidth)
          ? TwoPane(list: list, detail: detail ?? placeholder)
          : ListDetailScope(twoPane: false, inDetail: false, child: list),
    );
  }
}

/// İki bölmenin kendisi: karar başka yerde verildiyse (Geçmiş sekmesi
/// yönlendiriciden karar verir) doğrudan kullanılır.
class TwoPane extends StatelessWidget {
  const TwoPane({super.key, required this.list, required this.detail});

  final Widget list;
  final Widget detail;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: ListDetail.listWidth(constraints.maxWidth),
            child: ListDetailScope(twoPane: true, inDetail: false, child: list),
          ),
          VerticalDivider(width: 1, thickness: 1, color: AppColors.border),
          Expanded(
            child: ListDetailScope(
              twoPane: true,
              inDetail: true,
              child: detail,
            ),
          ),
        ],
      ),
    );
  }
}

/// Seçim yokken sağ bölmede ortalanmış kısa açıklama.
class DetailPlaceholder extends StatelessWidget {
  const DetailPlaceholder({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 44, color: AppColors.lightGreyColor),
          const SizedBox(height: AppSpacing.md),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.onSurfaceMuted),
          ),
        ],
      ),
    ),
  );
}

/// Bir widget'ın liste–detay içinde nerede durduğu.
class ListDetailScope extends InheritedWidget {
  const ListDetailScope({
    super.key,
    required this.twoPane,
    required this.inDetail,
    required super.child,
  });

  /// Liste ve detay yan yana mı?
  final bool twoPane;

  /// Bu alt ağaç sağ (detay) bölmede mi? Detayın geri oku orada gizlenir:
  /// liste zaten yanında.
  final bool inDetail;

  static ListDetailScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ListDetailScope>();

  static bool isTwoPane(BuildContext context) =>
      maybeOf(context)?.twoPane ?? false;

  static bool inDetailPane(BuildContext context) =>
      maybeOf(context)?.inDetail ?? false;

  @override
  bool updateShouldNotify(ListDetailScope old) =>
      twoPane != old.twoPane || inDetail != old.inDetail;
}
