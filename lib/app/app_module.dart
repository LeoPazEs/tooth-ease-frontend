import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/appointments_module.dart';
import 'package:tooth_ease_frontend/app/modules/login/guard/auth_guard.dart';
import 'package:tooth_ease_frontend/app/modules/shared/interceptor.dart';
import 'package:tooth_ease_frontend/app/modules/shared/token_auth.dart';

import 'modules/home/home_module.dart';
import 'modules/kids/kids_module.dart';
import 'modules/login/login_module.dart';
import 'modules/shared/secure_storage_service.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton(
        (i) => AuthGuard(tokenAuthService: i.get<TokenAuthService>())),
    Bind.singleton(
      (i) => TokenAuthService(
        storage: i.get<SecureStorageService>(),
      ),
    ),
    Bind.singleton(
      (i) => ApiInterceptor(
        tokenAuthService: i.get<TokenAuthService>(),
        storage: i.get<SecureStorageService>(),
      ),
    ),
    Bind.singleton(
      (i) => Dio(),
    ),
    Bind.singleton(
      (i) => SecureStorageService(
        storage: const FlutterSecureStorage(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: KidsModule(), guards: [
      AuthGuard(
        tokenAuthService: TokenAuthService(
          storage: SecureStorageService(storage: const FlutterSecureStorage()),
        ),
      )
    ]),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/appointments', module: AppointmentsModule()),
  ];
}
