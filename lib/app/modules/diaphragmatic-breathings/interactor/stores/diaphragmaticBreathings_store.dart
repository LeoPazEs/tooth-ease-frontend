import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/services/diaphragmatic_breathings_service.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/interactor/states/diaphragmatic_breathings_state.dart';

import '../../../shared/secure_storage_service.dart';
import '../../data/entities/diaphragmatic_breathings_entity.dart';

part 'diaphragmaticBreathings_store.g.dart';

class DiaphragmaticBreathingsStore = _DiaphragmaticBreathingsStoreBase
    with _$DiaphragmaticBreathingsStore;

abstract class _DiaphragmaticBreathingsStoreBase with Store {
  final DiaphragmaticBreathingsService diaphragmaticBreathingsService;
  final SecureStorageService storage;

  _DiaphragmaticBreathingsStoreBase(
      {required this.diaphragmaticBreathingsService, required this.storage});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController dataController = TextEditingController();

  @observable
  DateTime selectedDate = DateTime.now();

  @observable
  TimeOfDay selectedTime = TimeOfDay.now();

  String? finalDate;

  @observable
  DiaphragmaticBreathingsState state =
      const StartDiaphragmaticBreathingsState();

  List<DiaphragmaticBreathingsEntity> diaphragmaticBreathings = [];

  String kidId = Modular.args.data[1].toString();
  String appointmentId = Modular.args.data[0].toString();

  @action
  emit(DiaphragmaticBreathingsState newState) => state = newState;

  @action
  Future<void> selectDateAndTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        initialTime: selectedTime,
        context: context,
      );

      if (pickedTime != null) {
        selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        finalDate = selectedDate.toString();
        dataController.text =
            DateFormat('dd/MM/yyyy HH:mm').format(selectedDate);
      }
    }
  }

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

  editDiaphragmaticBreathing(String diaphragmaticBreathingId) async {
    emit(const LoadingDiaphragmaticBreathingsState());
    DateTime parsedDate =
        DateFormat("dd/MM/yyyy HH:mm").parse(dataController.text);

    DiaphragmaticBreathingsState response =
        await diaphragmaticBreathingsService.putDiaphragmaticBreathings(
      kidId.toString(),
      appointmentId.toString(),
      diaphragmaticBreathingId,
      DateFormat('yyyy-MM-dd\'T\'HH:mm:ss.000\'Z\'').format(parsedDate),
    );
    if (response is SuccessDiaphragmaticBreathingsState) {
      getDiaphragmaticBreathings();
      Fluttertoast.showToast(
          msg: "Respiração editada com sucesso",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Erro ao editar a respiração",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    emit(response);
  }

  deleteDiaphragmaticBreathing(String diaphragmaticBreathingId) async {
    emit(const LoadingDiaphragmaticBreathingsState());

    DiaphragmaticBreathingsState response =
        await diaphragmaticBreathingsService.deleteDiaphragmaticBreathings(
            kidId.toString(),
            appointmentId.toString(),
            diaphragmaticBreathingId);
    if (response is SuccessDiaphragmaticBreathingsState) {
      getDiaphragmaticBreathings();
      Fluttertoast.showToast(
          msg: "Respiração excluída com sucesso",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Erro ao excluir a respiração",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    emit(response);
  }

  void preencherForm(DiaphragmaticBreathingsEntity appointmentsEntity) {
    dataController.text = DateFormat('dd/MM/yyyy HH:mm')
        .format(DateTime.parse(appointmentsEntity.date));
  }

  Future logOut() async {
    await storage.deleteAll();
    Modular.to.navigate("/login");
  }
}
