import 'package:flutter/material.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/interactor/stores/diaphragmatic_breathings_steps_store.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/ui/widgets/botao_circular.dart';

class BarraInferior extends StatelessWidget {
  const BarraInferior({
    super.key,
    required this.store,
  });

  final DiaphragmaticBreathingsStepsStore store;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BotaoCircular(
                metodo: () => store.cancelarRespiracao(),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                texto: "",
                color: const Color.fromARGB(123, 255, 31, 31)),
            const SizedBox(
              width: 80,
            ),
            BotaoCircular(
                metodo: () => store.postDiaphragmaticBreathings(),
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                texto: "",
                color: const Color.fromARGB(167, 55, 255, 36))
          ],
        ),
      ],
    );
  }
}
