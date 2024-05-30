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
        FormBoxWidget(
          children: [
            LoginFormWidget(
              store: store,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03),
              child: GestureDetector(
                onTap: () => Modular.to.navigate("/login/register"),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.blue),
                    text: "Crie sua conta!",
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
