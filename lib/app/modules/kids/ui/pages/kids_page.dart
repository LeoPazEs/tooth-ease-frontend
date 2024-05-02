import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/kids/interactor/stores/kids_store.dart';
import 'package:flutter/material.dart';
import 'package:tooth_ease_frontend/app/modules/kids/ui/widgets/app_bar_widget.dart';
import 'package:tooth_ease_frontend/app/modules/kids/ui/widgets/bottom_navigation_widget.dart';

import '../../interactor/states/kids_state.dart';
import '../widgets/background_widget.dart';
import '../widgets/kids_widget.dart';
import '../widgets/loading_wiget.dart';

class KidsPage extends StatefulWidget {
  final String title;
  const KidsPage({super.key, this.title = 'Crianças'});
  @override
  KidsPageState createState() => KidsPageState();
}

class KidsPageState extends State<KidsPage> {
  final KidsStore store = Modular.get<KidsStore>();

  @override
  void initState() {
    store.configure();
    store.getKids();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationWidget(store: store),
        appBar: AppBarWidget(title: widget.title),
        resizeToAvoidBottomInset: false,
        body: Observer(
          builder: (context) {
            return (store.state is LoadingKidsState)
                ? Stack(children: [
                    const BackgroundWidget(),
                    KidsWidget(store: store),
                    const Loading()
                  ])
                : Stack(children: [
                    const BackgroundWidget(),
                    KidsWidget(store: store)
                  ]);
          },
        ));
  }
}
