import 'package:flutter/material.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/data/entities/appointments_entity.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/interactor/stores/appointments_store.dart';

class ConfirmAlert extends StatelessWidget {
  const ConfirmAlert({
    super.key,
    required this.store,
    required this.appointments,
  });

  final AppointmentsStore store;
  final AppointmentsEntity appointments;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/images/tooth.png",
          height: 50,
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
                  await store.deleteApointment(appointments.id);
                },
                child: const Text('Excluir'),
              ),
            )
          ])
        ]));
  }
}
