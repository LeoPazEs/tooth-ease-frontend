import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @observable
  DateTime selectedDate = DateTime.now();

  @observable
  TimeOfDay selectedTime = TimeOfDay.now();

  DateTime? finalDate;

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
        context: context,
        initialTime: selectedTime,
      );

      if (pickedTime != null) {
        selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        finalDate = selectedDate;
        dataController.text =
            DateFormat('dd/MM/yyyy HH:mm').format(selectedDate);
      }
    }
  }

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

  Future postApointment() async {
    emit(const LoadingAppointmentsState());
    AppointmentsState response = await appointmentsService.createAppointment(
      id,
      nomeController.text.toString(),
      finalDate.toString(),
    );
    if (response is SuccessOtherAppointmentsState) {
      getAppointmentsAll();
    } else if (response is CreateErrorExceptionAppointmentsState) {
      Fluttertoast.showToast(
        msg: response.error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      getAppointmentsAll();
    }
  }
}
