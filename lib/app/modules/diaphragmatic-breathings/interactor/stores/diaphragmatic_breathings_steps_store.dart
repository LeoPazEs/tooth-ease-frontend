import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/services/audio_players_service.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/services/diaphragmatic_breathings_service.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/interactor/states/diaphragmatic_breathings_state.dart';

import '../../data/entities/diaphragmatic_breathings_step_entity.dart';

part 'diaphragmatic_breathings_steps_store.g.dart';

class DiaphragmaticBreathingsStepsStore = _DiaphragmaticBreathingsStepsStoreBase
    with _$DiaphragmaticBreathingsStepsStore;

abstract class _DiaphragmaticBreathingsStepsStoreBase with Store {
  final DiaphragmaticBreathingsService diaphragmaticBreathingsService;
  final IAudioPlayerService audioPlayerService;

  _DiaphragmaticBreathingsStepsStoreBase(
      {required this.audioPlayerService,
      required this.diaphragmaticBreathingsService});

  final PageController pageController = PageController();

  List<DiaphragmaticBreathingsStepEntity> diaphragmaticBreathings = [];

  @observable
  DiaphragmaticBreathingsState state =
      const StartDiaphragmaticBreathingsState();

  String kidId = Modular.args.data[1].toString();
  String appointmentId = Modular.args.data[0].toString();

  @action
  emit(DiaphragmaticBreathingsState newState) => state = newState;

  playAudio() async {
    await audioPlayerService
        .playAudio("https://www.youtube.com/watch?v=pWjmpSD-ph0");
  }

  getDiaphragmaticBreathingsSteps() async {
    emit(const LoadingDiaphragmaticBreathingsState());
    DiaphragmaticBreathingsState response =
        await diaphragmaticBreathingsService.getStepDiaphragmaticBreathings();
    (response is SuccessDiaphragmaticBreathingsStepState)
        ? diaphragmaticBreathings = response.diaphragmaticBreathings
        : diaphragmaticBreathings = [];
    emit(response);
  }

  verifyPage() {
    if (diaphragmaticBreathings.length == pageController.page?.round()) {
      postDiaphragmaticBreathings();
    } else {
      Fluttertoast.showToast(
          msg: "Existem passos que não foram concluidos!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  postDiaphragmaticBreathings() async {
    emit(const LoadingDiaphragmaticBreathingsState());
    DiaphragmaticBreathingsState response = await diaphragmaticBreathingsService
        .postDiaphragmaticBreathings(kidId, appointmentId);
    if (response is SuccessDiaphragmaticBreathingsStepState) {
      Fluttertoast.showToast(
          msg: "Respiração salva!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (response is ErrorExceptionDiaphragmaticBreathingsState) {
      Fluttertoast.showToast(
          msg: "Erro ao salvar a respiração!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    Modular.to.pop();
    Modular.to.pop();
    Modular.to.pushNamed("/diaphragmatic_Breathings/",
        arguments: [appointmentId, kidId]);
  }

  cancelarRespiracao() {
    Modular.to.pop();
  }
}
