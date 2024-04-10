import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import '../widgets/form_widget.dart';
import '../widgets/form_box_widget.dart';
import '../../interactor/stores/login_store.dart';

class LoginWidget extends StatefulWidget {
  final LoginStore store;
  const LoginWidget({super.key, required this.store});
  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  final LoginStore store = Modular.get<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return Center(
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
    ));
  }
}
