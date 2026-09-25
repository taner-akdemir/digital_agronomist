import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/widgets/error_view.dart';

/// AsyncValue'nun üç hâlini çizer: yükleniyor, hata, veri.
///
/// Her ekranda tekrarlanan `switch (value) { AsyncLoading() => ... }`
/// bloğunu tek yere alır. Önemli olan HATA HÂLİNİN atlanmaması: eski
/// ekranlarda FutureBuilder'a `initialData: []` veriliyordu, bu yüzden
/// `hasData` anında true oluyor, yükleniyor göstergesi hiç görünmüyor ve
/// hata sessizce boş liste gibi çiziliyordu (§15.3/18).
class AsyncView<T> extends StatelessWidget {
  const AsyncView({
    super.key,
    required this.value,
    required this.errorMessage,
    required this.builder,
    this.onRetry,
  });

  final AsyncValue<T> value;

  /// "Hayvanlar yüklenemedi" gibi; ayrıntıyı ErrorView sunucudan alır.
  final String errorMessage;

  final Widget Function(T data) builder;

  /// Hata ekranındaki "Tekrar dene" (bkz. ErrorView.onRetry).
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    // ESKİ VERİ KORUNUR: provider yeniden hesaplanırken AsyncValue "loading"
    // olur ama ÖNCEKİ değerini taşır. Sadece AsyncData'yı eşlemek, hayvan
    // listesinde her filtre değişiminde listenin yerini bir an dönen
    // çemberin almasına yol açıyordu — filtreye basan kullanıcı, listenin
    // kaybolup geri gelmesini görüyordu.
    if (value.hasError) {
      return Center(
        child: ErrorView(
          message: errorMessage,
          error: value.error,
          onRetry: onRetry,
        ),
      );
    }
    if (value.hasValue) return builder(value.requireValue);
    return const Center(child: CircularProgressIndicator());
  }
}
