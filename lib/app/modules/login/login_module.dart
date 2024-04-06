import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/service/login_service.dart';
import 'package:tooth_ease_frontend/app/modules/login/interactor/stores/login_store.dart';
import 'package:tooth_ease_frontend/app/modules/login/ui/pages/login_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => LoginStore(loginService: i.get<LoginService>())), Bind.lazySingleton((i) => Dio()), Bind.lazySingleton((i) => LoginService(dio: i.get<Dio>()))];

  @override
  final List<ModularRoute> routes = [ChildRoute('/', child: (_, args) => LoginPage()),];

}