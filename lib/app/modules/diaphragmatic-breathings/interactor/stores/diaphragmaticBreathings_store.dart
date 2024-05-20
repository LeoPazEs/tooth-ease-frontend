import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/services/diaphragmatic_breathings_service.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/interactor/states/diaphragmatic_breathings_state.dart';

import '../../data/entities/diaphragmatic_breathings_entity.dart';

part 'diaphragmaticBreathings_store.g.dart';

class DiaphragmaticBreathingsStore = _DiaphragmaticBreathingsStoreBase
    with _$DiaphragmaticBreathingsStore;

abstract class _DiaphragmaticBreathingsStoreBase with Store {
  final DiaphragmaticBreathingsService diaphragmaticBreathingsService;
  _DiaphragmaticBreathingsStoreBase(
      {required this.diaphragmaticBreathingsService});

  @observable
  DiaphragmaticBreathingsState state = const StartDiaphragmaticBreathingsState();

  List<DiaphragmaticBreathingsEntity> diaphragmaticBreathings = [];

  String kidId = Modular.args.data[1].toString();
  String appointmentId = Modular.args.data[0].toString();

  @action
  emit(DiaphragmaticBreathingsState newState) => state = newState;

  getDiaphragmaticBreathings() async {
    emit(const LoadingDiaphragmaticBreathingsState());
    DiaphragmaticBreathingsState response =
        await diaphragmaticBreathingsService.getDiaphragmaticBreathingsAll(
            kidId.toString(), appointmentId.toString());
    (response is SuccessDiaphragmaticBreathingsState)
        ? diaphragmaticBreathings = response.diaphragmaticBreathings
        : diaphragmaticBreathings = [];
    emit(response);
  }
}
