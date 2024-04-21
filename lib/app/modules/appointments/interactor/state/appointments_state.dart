import 'package:tooth_ease_frontend/app/modules/appointments/data/entities/appointments_entity.dart';

abstract interface class AppointmentsState {}

class StartAppointmentsState implements AppointmentsState {
  const StartAppointmentsState();
}

class SuccessAppointmentsState implements AppointmentsState {
  final List<AppointmentsEntity> appointments;
  const SuccessAppointmentsState({required this.appointments});
}

class ErrorExceptionAppointmentsState implements AppointmentsState {
  const ErrorExceptionAppointmentsState();
}

class LoadingAppointmentsState implements AppointmentsState {
  const LoadingAppointmentsState();
}

class EmptyAppointmentsState implements AppointmentsState {
  const EmptyAppointmentsState();
}
