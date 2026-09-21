import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:milktrace/data/models/auth_user.dart';

part 'auth_state.freezed.dart';

/// Oturumun üç hâli.
///
/// `restoring` ayrı bir hâl OLMAK ZORUNDA. "Kullanıcı yok" ile "henüz
/// bakmadık" aynı sayılırsa uygulama her açılışta giriş ekranını bir an
/// gösterip sonra içeri atlar — token diskten okunurken.
enum AuthStatus { restoring, signedOut, signedIn }

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    required AuthStatus status,
    AuthUser? user,
  }) = _AuthState;

  const AuthState._();

  static const restoring = AuthState(status: AuthStatus.restoring);
  static const signedOut = AuthState(status: AuthStatus.signedOut);

  bool get isSignedIn => status == AuthStatus.signedIn;
  bool get isRestoring => status == AuthStatus.restoring;
}
