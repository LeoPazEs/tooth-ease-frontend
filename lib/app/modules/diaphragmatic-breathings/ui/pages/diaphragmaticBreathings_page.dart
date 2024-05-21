import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/ui/widgets/background_widget.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/ui/widgets/modal_widget.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/interactor/states/diaphragmatic_breathings_state.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/interactor/stores/diaphragmaticBreathings_store.dart';
import 'package:flutter/material.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/ui/widgets/bottom_navigation_widget.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/ui/widgets/diaphragmatic_breathings_card.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/ui/widgets/loading_wiget.dart';

class DiaphragmaticBreathingsPage extends StatefulWidget {
  final String title;
  const DiaphragmaticBreathingsPage({super.key, this.title = 'Respirações'});
  @override
  DiaphragmaticBreathingsPageState createState() =>
      DiaphragmaticBreathingsPageState();
}

class DiaphragmaticBreathingsPageState
    extends State<DiaphragmaticBreathingsPage> {
  final DiaphragmaticBreathingsStore store = Modular.get();

  @override
  void initState() {
    store.getDiaphragmaticBreathings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationWidget(store: store),
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add_rounded, size: 35), onPressed: () {}),
        ],
      ),
      body: Observer(builder: (context) {
        if (store.state is SuccessDiaphragmaticBreathingsState) {
          return Stack(
            children: [
              const BackgroundWidget(),
              Observer(
                builder: (_) {
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: store.diaphragmaticBreathings.length,
                    itemBuilder: (BuildContext context, int index) =>
                        DiaphragmaticBreathingsCardWidget(
                      diaphragmaticBreathings:
                          store.diaphragmaticBreathings[index],
                      store: store,
                    ),
                  );
                },
              )
            ],
          );
        } else if (store.state is LoadingDiaphragmaticBreathingsState) {
          return const Stack(
            children: [
              BackgroundWidget(),
              Loading(),
            ],
          );
        } else if (store.state is EmptyDiaphragmaticBreathingsState) {
          return const Stack(
            children: [
              BackgroundWidget(),
              Center(
                child: Text("Não possui nenhuma respiração"),
              ),
            ],
          );
        } else {
          return const Stack(
            children: [
              BackgroundWidget(),
              Center(
                child: Text("Erro"),
              ),
            ],
          );
        }
      }),
    );
  }
}
