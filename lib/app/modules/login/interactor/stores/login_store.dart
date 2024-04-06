import 'package:mobx/mobx.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/entities/auth_entities.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/entities/user_credentials_entities.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/service/login_service.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;
abstract class _LoginStoreBase with Store {
  final ILoginService loginService;

  _LoginStoreBase({required this.loginService});
  AuthEntity? auth;
  
  login() async {
    await loginService.login(montarDados());
  }
  
  UserCredentialsEntity montarDados() => UserCredentialsEntity(username: '', password: '');
}