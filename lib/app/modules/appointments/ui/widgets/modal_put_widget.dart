import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/interactor/stores/appointments_store.dart';
import 'package:tooth_ease_frontend/app/modules/shared/mask.dart';

class ConsultaModalPut extends StatelessWidget {
  final AppointmentsStore store;
  final int appointmentsId;

  ConsultaModalPut(
      {Key? key, required this.store, required this.appointmentsId})
      : super(key: key);

  void exibirModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConsultaModalPut(
          store: store,
          appointmentsId: appointmentsId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text("Adicionar anotação"),
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
              builder: (_) => Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: store.selectedScore,
                    hint: Text('Avalicação'),
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        store.setSelectedScore(newValue);
                      }
                    },
                    items: List.generate(11, (index) {
                      return DropdownMenuItem<int>(
                        value: index,
                        child: Text('$index'),
                      );
                    }),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Observer(
              builder: (_) => Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: store.selectedStatus,
                    hint: Text('Status'),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        store.setSelectedStatus(newValue);
                      }
                    },
                    items: [
                      DropdownMenuItem<String>(
                        value: 'pending',
                        child: Text('Pendente'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'completed',
                        child: Text('Completo'),
                      ),
                    ],
                  ),
                ),
              ),
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
          onPressed: () {
            Navigator.pop(context);
            store.clearController();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 128, 220, 243),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            "Cancelar",
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (store.formKey.currentState!.validate()) {
              store.putApointment(appointmentsId);
              Navigator.pop(context);
              store.clearController();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 128, 220, 243),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text("Atualizar", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
