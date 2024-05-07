import 'package:flutter/cupertino.dart';

class ErrorAppointmentsWidget extends StatelessWidget {
  const ErrorAppointmentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Erro ao Consultar as consultas"),
        ],
      ),
    );
  }
}
