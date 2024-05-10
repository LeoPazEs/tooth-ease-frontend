import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/interactor/stores/appointments_store.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/ui/widgets/modal_put_widget.dart';

import '../../data/entities/appointments_entity.dart';

class AppointmentsCardWidget extends StatelessWidget {
  final AppointmentsEntity appointments;
  final AppointmentsStore store;

  const AppointmentsCardWidget({
    super.key,
    required this.appointments,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/tooth.png",
                    scale: 15,
                  ),
                  Text(
                    appointments.doctor,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.03),
                        child: GestureDetector(
                          child: const Icon(
                            Icons.edit,
                            size: 25,
                          ),
                          onTap: () {
                            store.preencherForm(appointments);
                            ConsultaModalPut(
                              store: store,
                              appointmentsId: appointments.id,
                            ).exibirModal(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.03),
                        child: GestureDetector(
                          child: const Icon(
                            Icons.delete,
                            size: 25,
                          ),
                          onTap: () {
                            store.deleteApointment(appointments.id);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Status: ${appointments.status}"),
                  Text("Nota: ${appointments.score}")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Data: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.parse(appointments.date))}"),
                  Text(
                      "Respirações: ${appointments.diaphragmaticBreathingsMade}")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
