import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import '../../interactor/stores/register_store.dart';
import '../widgets/form_widget.dart';
import '../widgets/form_box_widget.dart';

class RegisterWidget extends StatefulWidget {
  final RegisterStore store;
  const RegisterWidget({super.key, required this.store});
  @override
  RegisterWidgetState createState() => RegisterWidgetState();
}

class RegisterWidgetState extends State<RegisterWidget> {
  final RegisterStore store = Modular.get<RegisterStore>();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FormBoxWidget(
          children: [
            RegisterFormWidget(
              store: store,
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                child: GestureDetector(
                    onTap: () => Modular.to.navigate("/"),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.blue),
                        text: "Já possui uma conta? Faça login!",
                      ),
                    )))
          ],
        )
      ],
    ));
  }
}
