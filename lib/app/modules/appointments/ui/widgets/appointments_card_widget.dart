import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/entities/appointments_entity.dart';

class AppointmentsCardWidget extends StatelessWidget {
  final AppointmentsEntity appointments;

  const AppointmentsCardWidget({
    super.key,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.03),
                      child: const Icon(
                        Icons.edit,
                        size: 30,
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
                Text("Respirações: ${appointments.diaphragmaticBreathingsMade}")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
