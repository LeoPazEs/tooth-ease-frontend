import 'package:flutter/material.dart';

import '../../data/entities/error_register_entities.dart';
import '../../interactor/states/register_state.dart';
import '../../interactor/stores/login_store.dart';
import '../../interactor/stores/register_store.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key, required this.store});
  final LoginStore store;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  @override
  Widget build(BuildContext context) {
    final EdgeInsets paddingFormFields =
        EdgeInsets.all(MediaQuery.of(context).size.height * 0.005);

    final EdgeInsets contentPaddingFormFields = EdgeInsets.only(
      left: MediaQuery.of(context).size.height * 0.01,
    );

    const borderFormFields =
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)));

    return Form(
        key: widget.store.formKey,
        child: Column(
          children: [
            Padding(
                padding: paddingFormFields,
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Usuário',
                      contentPadding: contentPaddingFormFields,
                      border: borderFormFields),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (usuario) => usuario == null || usuario.isEmpty
                      ? 'Por favor, insira um usuário'
                      : null,
                  controller: widget.store.userController,
                )),
            Padding(
                padding: paddingFormFields,
                child: TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      contentPadding: contentPaddingFormFields,
                      border: borderFormFields),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (senha) => senha == null || senha.isEmpty
                      ? 'Por favor, insira uma senha'
                      : null,
                  controller: widget.store.senhaController,
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFADF5F1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () {
                if (widget.store.formKey.currentState!.validate()) {
                  widget.store.login(widget.store.userController.text,
                      widget.store.senhaController.text);
                }
              },
              child: const Text('Entrar'),
            ),
          ],
        ));
  }
}

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key, required this.store});
  final RegisterStore store;

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  @override
  Widget build(BuildContext context) {
    final EdgeInsets paddingFormFields =
        EdgeInsets.all(MediaQuery.of(context).size.height * 0.005);

    final EdgeInsets contentPaddingFormFields = EdgeInsets.only(
      left: MediaQuery.of(context).size.height * 0.01,
    );

    const borderFormFields =
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)));

    return Form(
        key: widget.store.formKey,
        child: Column(
          children: [
            Padding(
                padding: paddingFormFields,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    contentPadding: contentPaddingFormFields,
                    border: borderFormFields,
                    errorMaxLines: 3,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (usuario) {
                    if (usuario == null || usuario.isEmpty) {
                      return 'Por favor, insira um usuário';
                    }
                    if (widget.store.state is ErrorExceptionRegisterState) {
                      ErrorRegister error =
                          (widget.store.state as ErrorExceptionRegisterState)
                              .error;
                      if (error.username.isNotEmpty) {
                        return error.username;
                      }
                    }
                    return null;
                  },
                  controller: widget.store.usernameController,
                )),
            Padding(
                padding: paddingFormFields,
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Nome',
                      contentPadding: contentPaddingFormFields,
                      border: borderFormFields),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (nome) {
                    if (nome == null || nome.isEmpty) {
                      return 'Por favor, insira um nome';
                    }
                    if (widget.store.state is ErrorExceptionRegisterState) {
                      ErrorRegister error =
                          (widget.store.state as ErrorExceptionRegisterState)
                              .error;
                      if (error.firstName.isNotEmpty) {
                        return error.firstName;
                      }
                    }
                    return null;
                  },
                  controller: widget.store.firstNameController,
                )),
            Padding(
                padding: paddingFormFields,
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Sobrenome',
                      contentPadding: contentPaddingFormFields,
                      border: borderFormFields),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (sobrenome) {
                    if (sobrenome == null || sobrenome.isEmpty) {
                      return 'Por favor, insira um sobrenome';
                    }
                    if (widget.store.state is ErrorExceptionRegisterState) {
                      ErrorRegister error =
                          (widget.store.state as ErrorExceptionRegisterState)
                              .error;
                      if (error.lastName.isNotEmpty) {
                        return error.lastName;
                      }
                    }
                    return null;
                  },
                )),
            Padding(
                padding: paddingFormFields,
                child: TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      contentPadding: contentPaddingFormFields,
                      border: borderFormFields),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (senha) {
                    if (senha == null || senha.isEmpty) {
                      return 'Por favor, insira uma senha';
                    }
                    if (widget.store.state is ErrorExceptionRegisterState) {
                      ErrorRegister error =
                          (widget.store.state as ErrorExceptionRegisterState)
                              .error;
                      if (error.password.isNotEmpty) {
                        return error.password;
                      }
                    }
                    return null;
                  },
                  controller: widget.store.passwordController,
                )),
            Padding(
                padding: paddingFormFields,
                child: TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      labelText: 'Confirmar senha',
                      contentPadding: contentPaddingFormFields,
                      border: borderFormFields),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (senha) {
                    if (senha == null || senha.isEmpty) {
                      return 'Por favor, confirme a senha';
                    } else if (senha != widget.store.passwordController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                  controller: widget.store.confirmPasswordController,
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFADF5F1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () {
                if (widget.store.formKey.currentState!.validate()) {
                  widget.store.register(
                    widget.store.usernameController.text,
                    widget.store.firstNameController.text,
                    widget.store.lastNameController.text,
                    widget.store.passwordController.text,
                  );
                }
              },
              child: const Text('Criar usuário'),
            ),
          ],
        ));
  }
}
