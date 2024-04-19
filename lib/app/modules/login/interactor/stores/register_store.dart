
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/entities/user_register_entity.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/service/register_service.dart';
import 'package:tooth_ease_frontend/app/modules/login/interactor/states/register_state.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/entities/error_register_entities.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStoreBase with _$RegisterStore;

abstract class _RegisterStoreBase with Store {
  final IRegisterService registerService;

  @observable
  RegisterState state = const StartRegisterState();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  _RegisterStoreBase({required this.registerService});

  @action
  Future register(String username, String password, String firstName,
      String lastName) async {
    state = const LoadingRegisterState();
    RegisterState response = await registerService
        .register(montarDados(username, password, firstName, lastName));

    if (response is SuccessRegisterState) {
      Fluttertoast.showToast(
          msg: "Usuário cadastrado com sucesso!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Modular.to.navigate("/");
    } else if (response is ErrorExceptionRegisterState) {
      ErrorRegister error = response.error;
      if (error.detail.isNotEmpty) {
        Fluttertoast.showToast(
            msg: error.detail,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    state = response;
  }

  UserRegisterEntity montarDados(String username, String password,
          String firstName, String lastName) =>
      UserRegisterEntity(
          username: username,
          password: password,
          firstName: firstName,
          lastName: lastName);
}
