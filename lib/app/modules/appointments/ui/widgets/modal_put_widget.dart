import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/data/entities/appointments_entity.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/interactor/stores/appointments_store.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/ui/widgets/confirm_alert_widget.dart';
import 'package:tooth_ease_frontend/app/modules/shared/mask.dart';

class ConsultaModalPut extends StatelessWidget {
  final AppointmentsStore store;
  final int appointmentsId;
  final AppointmentsEntity appointments;

  const ConsultaModalPut(
      {super.key,
      required this.store,
      required this.appointmentsId,
      required this.appointments});

  void exibirModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConsultaModalPut(
          store: store,
          appointmentsId: appointmentsId,
          appointments: appointments,
        );
      },
    );
  }

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
              builder: (_) => Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: store.selectedScore,
                    hint: const Text('Avalicação'),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        store.setSelectedScore(newValue);
                      }
                    },
                    items: List.generate(11, (index) {
                      return DropdownMenuItem<String>(
                        value: index.toString(),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: store.selectedStatus,
                    hint: const Text('Status'),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        store.setSelectedStatus(newValue);
                      }
                    },
                    items: const [
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (store.formKey.currentState!.validate()) {
                      store.putApointment(appointmentsId);
                      Navigator.pop(context);
                      store.clearController();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFADF5F1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text("Alterar",
                      style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmAlert(
                            store: store, appointments: appointments);
                      },
                    );
                    store.clearController();
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
          ],
        ),
      ),
    );
  }
}
