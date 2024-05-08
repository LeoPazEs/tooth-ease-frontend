import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/kids/data/entities/kid_entities.dart';
import 'package:tooth_ease_frontend/app/modules/kids/interactor/stores/kids_store.dart';

class ConfirmDeleteWidget extends StatefulWidget {
  final CompleteKidEntity kid;
  final KidsStore store = Modular.get<KidsStore>();

  ConfirmDeleteWidget({
    super.key,
    required this.kid,
  });

  @override
  State<ConfirmDeleteWidget> createState() => _ConfirmDeleteWidgetState();
}

class _ConfirmDeleteWidgetState extends State<ConfirmDeleteWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      const Text("Realmente deseja excluir ?"),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
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
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () async {
              if (!mounted) {
                return;
              }
              Navigator.pop(context);
              await widget.store.deleteKid(widget.kid.id);
            },
            child: const Text('Excluir'),
          ),
        )
      ])
    ]);
  }
}
