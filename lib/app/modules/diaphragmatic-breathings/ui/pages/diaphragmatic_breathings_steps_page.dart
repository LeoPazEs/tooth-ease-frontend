import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/ui/widgets/background_widget.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/interactor/states/diaphragmatic_breathings_state.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/interactor/stores/diaphragmatic_breathings_steps_store.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/ui/widgets/loading_wiget.dart';
import '../widgets/barra_inferior.dart';
import '../widgets/image_step_widget.dart';

class DiaphragmaticBreathingsStepsPage extends StatefulWidget {
  final String title;
  const DiaphragmaticBreathingsStepsPage(
      {super.key, this.title = 'DiaphragmaticBreathingsStepsPage'});
  @override
  DiaphragmaticBreathingsStepsPageState createState() =>
      DiaphragmaticBreathingsStepsPageState();
}

class DiaphragmaticBreathingsStepsPageState
    extends State<DiaphragmaticBreathingsStepsPage> {
  DiaphragmaticBreathingsStepsStore store =
      Modular.get<DiaphragmaticBreathingsStepsStore>();

  @override
  void initState() {
    store.getDiaphragmaticBreathingsSteps();
    store.playAudio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        if (store.state is SuccessDiaphragmaticBreathingsStepState) {
          return Stack(
            children: [
              PageView.builder(
                itemCount: store.diaphragmaticBreathings.length,
                controller: store.pageController,
                itemBuilder: (BuildContext context, int index) {
                  return ImageStep(
                    image: store.diaphragmaticBreathings[index].image,
                  );
                },
              ),
              BarraInferior(store: store),
            ],
          );
        } else if (store.state is ErrorExceptionDiaphragmaticBreathingsState) {
          return const Stack(
            children: [
              BackgroundWidget(),
              Center(
                child: Text("Erro"),
              )
            ],
          );
        } else if (store.state is LoadingDiaphragmaticBreathingsState) {
          return const Stack(
            children: [BackgroundWidget(), Loading()],
          );
        } else {
          return const Stack(
            children: [
              BackgroundWidget(),
              Center(
                child: Text("Nenhum tutorial cadastrado!"),
              )
            ],
          );
        }
      }),
    );
  }
}
