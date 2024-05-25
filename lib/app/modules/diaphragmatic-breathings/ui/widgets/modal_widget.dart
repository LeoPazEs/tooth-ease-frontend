import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/interactor/stores/diaphragmaticBreathings_store.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/ui/widgets/confirm_alert_widget.dart';
import 'package:tooth_ease_frontend/app/modules/shared/mask.dart';

import '../../data/entities/diaphragmatic_breathings_entity.dart';

class EditModal extends StatelessWidget {
  final DiaphragmaticBreathingsStore store;
  final DiaphragmaticBreathingsEntity diaphragmaticBreathing;

  EditModal(
      {Key? key, required this.store, required this.diaphragmaticBreathing})
      : super(key: key);

  void exibirModal(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) => EditModal(
          store: store, diaphragmaticBreathing: diaphragmaticBreathing));

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      title: Image.asset(
        "assets/images/pulmoes.png",
        height: 50,
      ),
      content: Form(
        key: store.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Observer(
              builder: (_) => TextFormField(
                inputFormatters: [Mask().maskData],
                readOnly: true,
                onTap: () async {
                  await store.selectDateAndTime(context);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.01,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: "Data",
                  hintText: "Clique para selecionar...",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      await store.selectDateAndTime(context);
                    },
                  ),
                ),
                controller: store.dataController,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (store.formKey.currentState!.validate()) {
                  Modular.to.pop();
                  await store
                      .editDiaphragmaticBreathing(diaphragmaticBreathing.id);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFADF5F1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child:
                  const Text("Alterar", style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmAlert(
                      store: store,
                      diaphragmaticBreathing: diaphragmaticBreathing,
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: const Text(
                "Excluir",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
