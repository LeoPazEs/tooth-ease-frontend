import 'package:flutter/cupertino.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Essa criança não possui nenhuma consulta agendada"),
        ],
      ),
    );
  }
}
