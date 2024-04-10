import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:tooth_ease_frontend/app/modules/login/interactor/states/login_state.dart';
import 'package:tooth_ease_frontend/app/modules/login/ui/widgets/login_widget.dart';
import '../widgets/background_widget.dart';
import '../../interactor/stores/login_store.dart';
import '../widgets/loading_wiget.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({super.key, this.title = 'LoginPage'});
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final LoginStore store = Modular.get<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Observer(
          builder: (context) {
            return (store.state is LoadingLoginState)
                ? Stack(children: [
                    const BackgroundWidget(),
                    LoginWidget(store: store),
                    const Loading()
                  ])
                : Stack(children: [
                    const BackgroundWidget(),
                    LoginWidget(store: store)
                  ]);
          },
        ));
  }
}
