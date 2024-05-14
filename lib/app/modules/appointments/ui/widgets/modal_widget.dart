import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/interactor/stores/appointments_store.dart';
import 'package:tooth_ease_frontend/app/modules/shared/mask.dart';

class ConsultaModal extends StatelessWidget {
  final AppointmentsStore store;

  ConsultaModal({Key? key, required this.store}) : super(key: key);

  void exibirModal(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) => ConsultaModal(store: store));

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      title: Image.asset(
        "assets/images/tooth.png",
        height: 50,
      ),
      content: Form(
        key: store.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Doutor',
                contentPadding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.01,
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (usuario) => usuario == null || usuario.isEmpty
                  ? 'Por favor, insira um nome'
                  : null,
              controller: store.nomeController,
            ),
            const SizedBox(
              height: 10,
            ),
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
                  labelText: "Data da consulta",
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
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 128, 220, 243),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              "Cancelar",
              style: TextStyle(color: Colors.black),
            )),
        ElevatedButton(
          onPressed: () {
            store.postApointment();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 128, 220, 243),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text("Salvar", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
