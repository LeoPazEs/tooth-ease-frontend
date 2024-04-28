import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController dataController = TextEditingController();

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

  Future postApointment(
      String doutor, String data, String status, int score) async {
    emit(const LoadingAppointmentsState());
    AppointmentsState response = await appointmentsService.createAppointment(
        id, doutor, data, status, score);
    if (response is SuccessOtherAppointmentsState) {
      getAppointmentsAll();
    } else if (response is ErrorExceptionAppointmentsState) {
      Fluttertoast.showToast(
        msg: "Erro ao adicionar consulta",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  exibirModal(context) => showDialog(
        context: context,
        builder: (Context) {
          return AlertDialog(
            title: const Text("Adicionar anotação"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: nomeController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      labelText: "Doutor", hintText: "Digite o nome..."),
                ),
                TextFormField(
                  controller: dataController,
                  decoration: const InputDecoration(
                      labelText: "Data da consulta",
                      hintText: "Digite a data..."),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Salvar"))
            ],
          );
        },
      );
}
