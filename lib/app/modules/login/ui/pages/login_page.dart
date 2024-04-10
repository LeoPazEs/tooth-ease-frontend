import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import '../widgets/background_widget.dart';
import '../widgets/form_widget.dart';
import '../widgets/form_box_widget.dart';
import '../../interactor/stores/login_store.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final LoginStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        const BackgroundWidget(),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
                child: FractionallySizedBox(
                    heightFactor: 0.4,
                    widthFactor: 0.8,
                    child: LoginFormBoxWidget(
                      children: [
                        LoginFormWidget(
                          store: store,
                        )
                      ],
                    )))
          ],
        )),
      ]),
    );
  }
}
