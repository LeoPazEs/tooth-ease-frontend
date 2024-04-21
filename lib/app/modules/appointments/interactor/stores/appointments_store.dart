import 'dart:ffi';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/data/entities/appointments_entity.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/data/services/appointments_services.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/interactor/state/appointments_state.dart';

part 'appointments_store.g.dart';

class AppointmentsStore = _AppointmentsStoreBase with _$AppointmentsStore;

abstract class _AppointmentsStoreBase with Store {
  final AppointmentsService appointmentsService;

  _AppointmentsStoreBase({required this.appointmentsService});

  @observable
  AppointmentsState state = const StartAppointmentsState();

  @action
  emit(AppointmentsState newState) => state = newState;

  List<AppointmentsEntity> appointments = [];

  int id = Modular.args.data as int;

  Future getAppointmentsAll() async {
    emit(const LoadingAppointmentsState());
    AppointmentsState response =
        await appointmentsService.getAppointmentsAll(id);
    (response is SuccessAppointmentsState)
        ? appointments = response.appointments
        : appointments = [];
    emit(response);
  }
}
