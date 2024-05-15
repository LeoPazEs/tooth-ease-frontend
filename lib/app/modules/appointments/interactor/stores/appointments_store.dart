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

  @observable
  String? selectedStatus;

  @observable
  int? selectedScore;

  String? finalDate;

  @observable
  String filterDoctorName = '';

  @observable
  DateTime? filterDate;

  @observable
  String filterTime = '';

  @observable
  String? filterStatus;

  @observable
  int? filterScore;

  @observable
  ObservableList<AppointmentsEntity> filteredAppointments =
      ObservableList<AppointmentsEntity>();

  @action
  void setFilterDoctorName(String value) {
    filterDoctorName = value;
    applyFilters();
  }

  @action
  void setFilterDate(DateTime? date) {
    filterDate = date;
    applyFilters();
  }

  @action
  void setFilterStatus(String? status) {
    filterStatus = status;
    applyFilters();
  }

  @action
  void setFilterScore(int? score) {
    filterScore = score;
    applyFilters();
  }

  @action
  void applyFilters() {
    filteredAppointments = ObservableList.of(appointments.where((appointment) {
      bool matchesDoctor = appointment.doctor
          .toLowerCase()
          .contains(filterDoctorName.toLowerCase());
      bool matchesDate = filterDate == null ||
          DateFormat('dd/MM/yyyy HH:mm')
                  .format(DateTime.parse(appointment.date)) ==
              DateFormat('dd/MM/yyyy HH:mm')
                  .format(DateTime.parse(filterDate.toString()));
      bool matchesStatus =
          filterStatus == null || appointment.status == filterStatus;
      bool matchesScore =
          filterScore == null || appointment.score == filterScore;
      return matchesDoctor && matchesDate && matchesStatus && matchesScore;
    }));
  }

  @action
  void setSelectedScore(int value) => selectedScore = value;

  @action
  void setSelectedStatus(String value) => selectedStatus = value;

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
        setFilterDate(selectedDate);
        dataController.text =
            DateFormat('dd/MM/yyyy HH:mm').format(selectedDate);
      }
    }
  }

  @action
  void clearController() {
    nomeController.clear();

    dataController.clear();
    selectedScore = null;
    selectedStatus = null;
    filterDate = null;
    filterStatus = null;
    filterDoctorName = '';
    filterScore = null;
  }

  void preencherForm(AppointmentsEntity appointmentsEntity) {
    nomeController.text = appointmentsEntity.doctor;
    finalDate = appointmentsEntity.date;
    dataController.text =
        DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(finalDate!));
    selectedScore = appointmentsEntity.score;
    selectedStatus = appointmentsEntity.status;
  }

  @action
  emit(AppointmentsState newState) => state = newState;

  List<AppointmentsEntity> appointments = [];

  int id = Modular.args.data as int;

  Future getAppointmentsAll() async {
    emit(const LoadingAppointmentsState());
    AppointmentsState response =
        await appointmentsService.getAppointmentsAll(id);
    appointments =
        response is SuccessAppointmentsState ? response.appointments : [];
    applyFilters();
    emit(response);
  }

  Future postApointment() async {
    emit(const LoadingAppointmentsState());
    AppointmentsState response = await appointmentsService.createAppointment(
      id,
      nomeController.text,
      selectedDate.toString(),
    );
    handleResponse(response);
  }

  Future putApointment(int appointmentId) async {
    emit(const LoadingAppointmentsState());
    AppointmentsState response = await appointmentsService.putAppointmentsAll(
      id,
      appointmentId,
      nomeController.text,
      finalDate!,
      selectedStatus!,
      selectedScore!,
    );
    handleResponse(response);
  }

  Future deleteApointment(int appointmentId) async {
    emit(const LoadingAppointmentsState());
    AppointmentsState response =
        await appointmentsService.deleteAppointments(id, appointmentId);
    handleResponse(response);
  }

  @action
  void handleResponse(AppointmentsState response) {
    if (response is SuccessOtherAppointmentsState) {
      getAppointmentsAll();
    } else if (response is OtherErrorExceptionAppointmentsState) {
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
    } else if (response is SubmitErrorExceptionAppointmentsState) {
      if (response.error.date.isNotEmpty) {
        Fluttertoast.showToast(
          msg: response.error.date,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (response.error.name.isNotEmpty) {
        Fluttertoast.showToast(
          msg: response.error.date,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: response.error.detail,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      clearController();
      getAppointmentsAll();
    }
  }
}
