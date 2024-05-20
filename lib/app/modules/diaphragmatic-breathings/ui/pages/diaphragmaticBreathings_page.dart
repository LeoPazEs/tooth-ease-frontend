import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/interactor/states/diaphragmatic_breathings_state.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/interactor/stores/diaphragmaticBreathings_store.dart';
import 'package:flutter/material.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/ui/widgets/bottom_navigation_widget.dart';

class DiaphragmaticBreathingsPage extends StatefulWidget {
  final String title;
  const DiaphragmaticBreathingsPage(
      {Key? key, this.title = 'DiaphragmaticBreathingsPage'})
      : super(key: key);
  @override
  DiaphragmaticBreathingsPageState createState() =>
      DiaphragmaticBreathingsPageState();
}

class DiaphragmaticBreathingsPageState
    extends State<DiaphragmaticBreathingsPage> {
  final DiaphragmaticBreathingsStore store = Modular.get();

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
      body: Stack(
        children: [
          Observer(
            builder: (_) {
              return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) => Card());
            },
          )
        ],
      ),
    );
  }
}
