import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/interactor/stores/appointments_store.dart';
import 'package:tooth_ease_frontend/app/modules/shared/mask.dart';

class FilterModal extends StatelessWidget {
  final AppointmentsStore store;

  FilterModal({Key? key, required this.store}) : super(key: key);

  void exibirModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterModal(
          store: store,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(
              context); // This will pop the dialog when tapped outside
        },
        child: SingleChildScrollView(
            child: AlertDialog(
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
                    controller: store.nomeController,
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
                    onChanged: (value) {}),
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
                        hint: Text('Avaliação'),
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
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                store.getAppointmentsAll();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 128, 220, 243),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text("Filtrar consulta",
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        )));
  }
}
