import 'package:flutter/material.dart';

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
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.face_6,
              size: 50,
            ),
            Text(appointments.doctor),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: const Icon(
                      Icons.edit,
                      size: 30,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
