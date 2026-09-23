import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/auth/auth_api.dart';
import 'package:milktrace/data/auth/auth_interceptor.dart';
import 'package:milktrace/data/auth/token_store.dart';
import 'package:milktrace/data/models/auth_user.dart';

import 'fake_backend.dart';

/// Tüm Dio'ları aynı sahte backend'e bağlayan düzenek.
class _Rig {
  _Rig({required this.handler}) {
    adapter = FakeAdapter(handler);
    storage = InMemorySecureStorage();
    store = TokenStore(storage: storage);

    BaseOptions opts() => BaseOptions(baseUrl: 'http://test/api/v1');

    bare = Dio(opts())..httpClientAdapter = adapter;
    retry = Dio(opts())..httpClientAdapter = adapter;
    authed = Dio(opts())..httpClientAdapter = adapter;

    interceptor = AuthInterceptor(
      authApi: AuthApi(dio: bare),
      store: store,
      retryDio: retry,
    );
    authed.interceptors.add(interceptor);
  }

  final Future<ResponseBody> Function(RequestOptions) handler;

  late final FakeAdapter adapter;
  late final InMemorySecureStorage storage;
  late final TokenStore store;
  late final Dio bare;
  late final Dio retry;
  late final Dio authed;
  late final AuthInterceptor interceptor;

  void dispose() => interceptor.dispose();
}

void main() {
  test('her isteğe erişim token\'ı eklenir', () async {
    final rig = _Rig(handler: (o) async => okEnvelope({'ok': true}));
    addTearDown(rig.dispose);
    rig.interceptor.setTokens(
      const AuthTokens(accessToken: 'A1', refreshToken: 'R1'),
    );

    await rig.authed.get<dynamic>('/halls');

    expect(rig.adapter.requests.single.headers['Authorization'], 'Bearer A1');
  });

  test('token yokken Authorization başlığı EKLENMEZ', () async {
    // Boş bir "Bearer " göndermek sunucuda 401 yerine ayrıştırma hatası
    // üretir; giriş uçları da bu Dio'dan geçebilir.
    final rig = _Rig(handler: (o) async => okEnvelope({'ok': true}));
    addTearDown(rig.dispose);

    await rig.authed.get<dynamic>('/halls');

    expect(
      rig.adapter.requests.single.headers.containsKey('Authorization'),
      isFalse,
    );
  });

  test(
    '401 alınca token yenilenir ve istek yeni token\'la tekrarlanır',
    () async {
      var hallsCalls = 0;
      final rig = _Rig(
        handler: (o) async {
          if (o.path == '/auth/refresh') {
            return okEnvelope({'accessToken': 'A2', 'refreshToken': 'R2'});
          }
          hallsCalls++;
          // İlk çağrı süresi dolmuş token'la geliyor.
          if (o.headers['Authorization'] == 'Bearer A1') {
            return errEnvelope(401, 'TOKEN_EXPIRED', 'Oturum süresi doldu.');
          }
          return okEnvelope({'ok': true});
        },
      );
      addTearDown(rig.dispose);
      rig.interceptor.setTokens(
        const AuthTokens(accessToken: 'A1', refreshToken: 'R1'),
      );

      final r = await rig.authed.get<dynamic>('/halls');

      expect(r.statusCode, 200);
      expect(hallsCalls, 2, reason: 'bir kez düşmeli, bir kez tekrarlanmalı');
      expect(rig.adapter.countOf('/auth/refresh'), 1);
    },
  );

  test('yenilemede dönen İKİ token da diske yazılır', () async {
    // Yalnızca erişim token'ı yazılsaydı bir sonraki yenileme eski (artık
    // iptal edilmiş) yenileme token'ını gönderir ve sunucu bunu TEKRAR
    // KULLANIM sayıp kullanıcının tüm oturumlarını kapatırdı.
    final rig = _Rig(
      handler: (o) async {
        if (o.path == '/auth/refresh') {
          return okEnvelope({'accessToken': 'A2', 'refreshToken': 'R2'});
        }
        return o.headers['Authorization'] == 'Bearer A1'
            ? errEnvelope(401, 'TOKEN_EXPIRED', 'Oturum süresi doldu.')
            : okEnvelope({'ok': true});
      },
    );
    addTearDown(rig.dispose);
    rig.interceptor.setTokens(
      const AuthTokens(accessToken: 'A1', refreshToken: 'R1'),
    );

    await rig.authed.get<dynamic>('/halls');

    final saved = await rig.store.readTokens();
    expect(saved?.accessToken, 'A2');
    expect(
      saved?.refreshToken,
      'R2',
      reason: 'yenileme token\'ı da dönmüş olmalı',
    );
  });

  test('EŞZAMANLI 401\'lerde yalnızca BİR yenileme yapılır', () async {
    // En kritik test. Canlı ekran açılışta beş istek birden atıyor; token
    // süresi dolmuşsa beşi de 401 alır. Her biri ayrı yenileme yapsaydı,
    // dönen yenileme token'ı yüzünden ikinci istek sunucuya TEKRAR KULLANIM
    // gibi görünür ve kullanıcı hiç yoktan oturumdan atılırdı.
    final rig = _Rig(
      handler: (o) async {
        if (o.path == '/auth/refresh') {
          // Yarış penceresini gerçekçi kılmak için gecikme.
          await Future<void>.delayed(const Duration(milliseconds: 30));
          return okEnvelope({'accessToken': 'A2', 'refreshToken': 'R2'});
        }
        return o.headers['Authorization'] == 'Bearer A1'
            ? errEnvelope(401, 'TOKEN_EXPIRED', 'Oturum süresi doldu.')
            : okEnvelope({'ok': true});
      },
    );
    addTearDown(rig.dispose);
    rig.interceptor.setTokens(
      const AuthTokens(accessToken: 'A1', refreshToken: 'R1'),
    );

    final responses = await Future.wait([
      rig.authed.get<dynamic>('/halls'),
      rig.authed.get<dynamic>('/vacuums'),
      rig.authed.get<dynamic>('/spouts'),
      rig.authed.get<dynamic>('/devices'),
      rig.authed.get<dynamic>('/animals'),
    ]);

    expect(responses.every((r) => r.statusCode == 200), isTrue);
    expect(
      rig.adapter.countOf('/auth/refresh'),
      1,
      reason: 'beş istek tek bir yenilemeyi paylaşmalı',
    );
  });

  test('yenileme düşerse oturum kapanır ve token\'lar silinir', () async {
    final rig = _Rig(
      handler: (o) async {
        if (o.path == '/auth/refresh') {
          return errEnvelope(401, 'INVALID_REFRESH_TOKEN', 'Oturum sonlandı.');
        }
        return errEnvelope(401, 'TOKEN_EXPIRED', 'Oturum süresi doldu.');
      },
    );
    addTearDown(rig.dispose);
    rig.interceptor.setTokens(
      const AuthTokens(accessToken: 'A1', refreshToken: 'R1'),
    );
    await rig.store.writeTokens(
      const AuthTokens(accessToken: 'A1', refreshToken: 'R1'),
    );

    final signedOut = rig.interceptor.onForcedSignOut.first;

    await expectLater(
      rig.authed.get<dynamic>('/halls'),
      throwsA(isA<DioException>()),
    );

    await signedOut.timeout(const Duration(seconds: 2));
    expect(await rig.store.readTokens(), isNull);
  });

  test('/auth/* uçlarındaki 401 yenilemeyi TETİKLEMEZ', () async {
    // Yanlış parolayla giriş 401 döner. Bu da yenilemeyi tetikleseydi
    // her hatalı giriş denemesi gereksiz bir yenileme turu başlatırdı.
    final rig = _Rig(
      handler: (o) async => errEnvelope(
        401,
        'INVALID_CREDENTIALS',
        'E-posta veya parola hatalı.',
      ),
    );
    addTearDown(rig.dispose);
    rig.interceptor.setTokens(
      const AuthTokens(accessToken: 'A1', refreshToken: 'R1'),
    );

    await expectLater(
      rig.authed.post<dynamic>(
        '/auth/login',
        data: {'email': 'a@b.c', 'password': 'x'},
      ),
      throwsA(isA<DioException>()),
    );

    expect(rig.adapter.countOf('/auth/refresh'), 0);
  });

  test('yenilemeden sonra HÂLÂ 401 geliyorsa ikinci kez denenmez', () async {
    // Yetkisiz bir uca (örn. platform yöneticisi ucu) istek atılırsa 401
    // token yüzünden değildir; sonsuz yenile-dene döngüsüne girilmemeli.
    var refreshes = 0;
    final rig = _Rig(
      handler: (o) async {
        if (o.path == '/auth/refresh') {
          refreshes++;
          return okEnvelope({'accessToken': 'A2', 'refreshToken': 'R2'});
        }
        return errEnvelope(401, 'UNAUTHORIZED', 'Yetkiniz yok.');
      },
    );
    addTearDown(rig.dispose);
    rig.interceptor.setTokens(
      const AuthTokens(accessToken: 'A1', refreshToken: 'R1'),
    );

    await expectLater(
      rig.authed.get<dynamic>('/admin/devices'),
      throwsA(isA<DioException>()),
    );

    expect(refreshes, 1, reason: 'yalnızca bir kez yenilenmeli');
    expect(
      rig.adapter.countOf('/admin/devices'),
      2,
      reason: 'bir deneme + bir tekrar',
    );
  });
}
