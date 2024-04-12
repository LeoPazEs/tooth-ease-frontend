import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import '../../interactor/states/register_state.dart';
import '../../interactor/stores/register_store.dart';
import '../widgets/background_widget.dart';
import '../widgets/loading_wiget.dart';
import '../widgets/register_widget.dart';

class RegisterPage extends StatefulWidget {
  final String title;
  const RegisterPage({super.key, this.title = 'RegisterPage'});
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final RegisterStore store = Modular.get<RegisterStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Observer(
          builder: (context) {
            return (store.state is LoadingRegisterState)
                ? Stack(children: [
                    const BackgroundWidget(),
                    RegisterWidget(store: store),
                    const Loading()
                  ])
                : Stack(children: [
                    const BackgroundWidget(),
                    RegisterWidget(store: store)
                  ]);
          },
        ));
  }
}
