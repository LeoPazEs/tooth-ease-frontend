import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/entities/user_credentials_entities.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/service/login_service.dart';
import 'package:tooth_ease_frontend/app/modules/login/interactor/states/login_state.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/entities/error_login_entities.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final ILoginService loginService;

  @observable
  LoginState state = const StartLoginState();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  _LoginStoreBase({required this.loginService});

  @action
  Future login(String usuario, String senha) async {
    state = const LoadingLoginState();
    LoginState response = await loginService.login(montarDados(usuario, senha));

    if (response is SuccessLoginState) {
      Modular.to.navigate("/home");
    } else if (response is ErrorExceptionLoginState) {
      ErrorLogin error = response.error;
      Fluttertoast.showToast(
          msg: error.detail,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    state = response;
  }

  UserCredentialsEntity montarDados(username, password) =>
      UserCredentialsEntity(username: username, password: password);
}
