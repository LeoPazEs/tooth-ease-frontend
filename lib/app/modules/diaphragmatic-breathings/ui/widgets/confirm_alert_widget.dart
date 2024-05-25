import 'package:flutter/material.dart';

import '../../data/entities/diaphragmatic_breathings_entity.dart';
import '../../interactor/stores/diaphragmaticBreathings_store.dart';

class ConfirmAlert extends StatelessWidget {
  const ConfirmAlert({
    super.key,
    required this.store,
    required this.diaphragmaticBreathing,
  });

  final DiaphragmaticBreathingsStore store;
  final DiaphragmaticBreathingsEntity diaphragmaticBreathing;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/images/pulmoes.png",
          scale: 5,
        ),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text("Realmente deseja excluir?"),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFADF5F1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                )),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  await store
                      .deleteDiaphragmaticBreathing(diaphragmaticBreathing.id);
                },
                child: const Text('Excluir'),
              ),
            )
          ])
        ]));
  }
}
