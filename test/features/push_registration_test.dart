import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/push/push_gateway.dart';
import 'package:milktrace/data/push/push_message.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/push_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

/// Oturumu testin elinde tutan Auth.
///
/// Gerçek Auth açılışta diske ve /me'ye gidiyor; push kaydının oturuma
/// bağlanmasını sınamak için bize sadece "açık mı kapalı mı" lazım.
class _FakeAuth extends Auth {
  _FakeAuth(this._initial);

  final AuthState _initial;

  @override
  AuthState build() => _initial;

  void enter() => state = const AuthState(
        status: AuthStatus.signedIn,
        user: AuthUser(
          id: 'u1',
          email: 'ciftci@milktrace.local',
          fullName: 'Demo',
          role: 'tenant_owner',
          tenantId: 't1',
        ),
      );

  void leave() => state = AuthState.signedOut;
}

/// Firebase'siz push kapısı.
class _FakeGateway implements PushGateway {
  /// Jeton null olabilir: Firebase bağlı değilken start() null döner.
  String? token = 'tok-1';
  int starts = 0;
  int stops = 0;

  final _taps = StreamController<PushMessage>.broadcast();
  final _tokens = StreamController<String>.broadcast();

  void refreshToken(String next) => _tokens.add(next);

  @override
  Future<String?> start() async {
    starts++;
    return token;
  }

  @override
  Stream<PushMessage> get taps => _taps.stream;

  @override
  Stream<String> get tokenRefresh => _tokens.stream;

  @override
  Future<void> stop() async => stops++;

  @override
  Future<void> dispose() async {
    await _taps.close();
    await _tokens.close();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _FakeGateway gateway;
  late MockRepository repo;
  late ProviderContainer container;

  ProviderContainer build({AuthState auth = AuthState.signedOut}) {
    gateway = _FakeGateway();
    repo = MockRepository(latency: Duration.zero);

    return ProviderContainer(overrides: [
      pushGatewayProvider.overrideWithValue(gateway),
      repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
      authProvider.overrideWith(() => _FakeAuth(auth)),
    ]);
  }

  tearDown(() => container.dispose());

  // Oturum KAPALIYKEN push'un hiç başlatılmadığını doğrular.
  //
  // Başlatılsaydı giriş ekranındaki kullanıcıya bildirim izni penceresi
  // açılır ve jeton sahipsiz kaydedilirdi.
  test('oturum kapalıyken jeton kaydedilmez', () async {
    container = build();

    expect(await container.read(pushRegistrationProvider.future),
        PushStatus.idle);
    expect(gateway.starts, 0);
    expect(repo.pushTokens, isEmpty);
  });

  test('oturum açılınca jeton kaydedilir', () async {
    container = build();
    await container.read(pushRegistrationProvider.future);

    (container.read(authProvider.notifier) as _FakeAuth).enter();

    expect(await container.read(pushRegistrationProvider.future),
        PushStatus.registered);
    expect(repo.pushTokens, ['tok-1']);
  });

  // Firebase BAĞLI DEĞİLKEN uygulamanın çalışmaya devam ettiğini doğrular.
  //
  // Proje henüz bağlanmadı; start() null dönüyor ve bu bir hata değil.
  test('push yapılandırılmamışsa durum unavailable olur', () async {
    container = build(auth: const AuthState(status: AuthStatus.signedIn));
    gateway.token = null;

    expect(await container.read(pushRegistrationProvider.future),
        PushStatus.unavailable);
    expect(repo.pushTokens, isEmpty);
  });

  // Jeton YENİLENDİĞİNDE yenisinin de yazıldığını doğrular.
  //
  // Yazılmasaydı eski jetona gönderilen push kimseye ulaşmaz ve kullanıcı
  // sessizce uyarı almaz hâle gelirdi.
  test('yenilenen jeton da kaydedilir', () async {
    container = build(auth: const AuthState(status: AuthStatus.signedIn));
    await container.read(pushRegistrationProvider.future);

    gateway.refreshToken('tok-2');

    // Akış dinleyicisi → kayıt çağrısı → sahte gecikme: birkaç olay döngüsü
    // turu gerekiyor. Sabit bir bekleme yerine koşul yoklanıyor.
    for (var i = 0; i < 100 && repo.pushTokens.length < 2; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 1));
    }

    expect(repo.pushTokens, ['tok-1', 'tok-2']);
  });

  // ÇIKIŞTA jetonun bağının koptuğunu doğrular.
  //
  // Kopmasaydı telefonu devreden çıkan kullanıcıya, artık onun olmayan
  // sürünün uyarıları gitmeye devam ederdi.
  test('çıkışta jeton silinir ve dinleme durur', () async {
    container = build(auth: const AuthState(status: AuthStatus.signedIn));
    await container.read(pushRegistrationProvider.future);
    expect(repo.pushTokens, ['tok-1']);

    (container.read(authProvider.notifier) as _FakeAuth).leave();

    expect(await container.read(pushRegistrationProvider.future),
        PushStatus.idle);
    expect(repo.pushTokens, isEmpty);
    expect(gateway.stops, greaterThan(0));
  });
}
