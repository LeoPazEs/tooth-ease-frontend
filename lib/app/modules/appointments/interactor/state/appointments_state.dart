import 'package:tooth_ease_frontend/app/modules/appointments/data/entities/appointments_entity.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/data/entities/error_entities.dart';

abstract interface class AppointmentsState {}

class StartAppointmentsState implements AppointmentsState {
  const StartAppointmentsState();
}

class SuccessAppointmentsState implements AppointmentsState {
  final List<AppointmentsEntity> appointments;
  const SuccessAppointmentsState({required this.appointments});
}

class SuccessOtherAppointmentsState implements AppointmentsState {
  const SuccessOtherAppointmentsState();
}

class ErrorExceptionAppointmentsState implements AppointmentsState {
  const ErrorExceptionAppointmentsState();
}

class OtherErrorExceptionAppointmentsState implements AppointmentsState {
  final String error;
  const OtherErrorExceptionAppointmentsState({required this.error});
}

class SubmitErrorExceptionAppointmentsState implements AppointmentsState {
  final ErrorAppointments error;
  const SubmitErrorExceptionAppointmentsState({required this.error});
}

class LoadingAppointmentsState implements AppointmentsState {
  const LoadingAppointmentsState();
}

class EmptyAppointmentsState implements AppointmentsState {
  const EmptyAppointmentsState();
}
