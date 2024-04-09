import 'package:flutter/material.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

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
        key: _formKey,
        child: Column(
          children: [
            Padding(
                padding: paddingFormFields,
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Usuário',
                        contentPadding: contentPaddingFormFields,
                        border: borderFormFields))),
            Padding(
                padding: paddingFormFields,
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Senha',
                        contentPadding: contentPaddingFormFields,
                        border: borderFormFields))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFADF5F1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () {},
              child: const Text('Entrar'),
            ),
          ],
        ));
  }
}
