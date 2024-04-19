import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/service/login_service.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/service/register_service.dart';
import 'package:tooth_ease_frontend/app/modules/login/interactor/stores/login_store.dart';
import 'package:tooth_ease_frontend/app/modules/login/interactor/stores/register_store.dart';
import 'package:tooth_ease_frontend/app/modules/login/ui/pages/login_page.dart';
import 'package:tooth_ease_frontend/app/modules/login/ui/pages/register_page.dart';
import 'package:tooth_ease_frontend/app/modules/shared/secure_storage_service.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore(loginService: i.get<LoginService>())),
    Bind.lazySingleton((i) => LoginService(
        dio: i.get<Dio>(), storage: i.get<ISecureStorageService>())),
    Bind.lazySingleton(
        (i) => RegisterStore(registerService: i.get<RegisterService>())),
    Bind.lazySingleton((i) => RegisterService(dio: i.get<Dio>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const LoginPage()),
    ChildRoute('/register', child: (_, args) => const RegisterPage())
  ];
}
