import 'package:flutter/material.dart';

import '../../interactor/stores/login_store.dart';

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
