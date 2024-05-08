import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/data/adapters/Appointments_adapters.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/data/entities/appointments_entity.dart';

import '../../../shared/env.dart';
import '../../interactor/state/appointments_state.dart';

abstract interface class IAppointmentsService {
  Future<AppointmentsState> getAppointmentsAll(int kidId);
  Future<AppointmentsState> createAppointment(
      int kidId, String doutor, String dataConsulta);
  Future<AppointmentsState> getAppointmentsById(int kidId, int appointmentId);
  Future<AppointmentsState> putAppointmentsAll(int kidId, int appointmentId);
  Future<AppointmentsState> patchAppointments(int kidId, int appointmentId);
  Future<AppointmentsState> deleteAppointments(int kidId, int appointmentId);
}

class AppointmentsService implements IAppointmentsService {
  final Dio dio;

  AppointmentsService({required this.dio});

  @override
  Future<AppointmentsState> getAppointmentsAll(int kidId) async {
    try {
      final response =
          await dio.get("$apiUrl/accounts/me/kids/$kidId/appointments/");
      List<AppointmentsEntity> appointments = (response.data as List)
          .map((json) => AppointmentsAdapter.fromJson(json))
          .toList();
      if (response.statusCode == 200) {
        if (appointments.isEmpty) {
          return const EmptyAppointmentsState();
        }
        return SuccessAppointmentsState(appointments: appointments);
      } else {
        return const ErrorExceptionAppointmentsState();
      }
    } catch (e) {
      return const ErrorExceptionAppointmentsState();
    }
  }

  @override
  Future<AppointmentsState> deleteAppointments(int kidId, int appointmentId) {
    // TODO: implement deleteAppointments
    throw UnimplementedError();
  }

  @override
  Future<AppointmentsState> getAppointmentsById(int kidId, int appointmentId) {
    // TODO: implement getAppointmentsById
    throw UnimplementedError();
  }

  @override
  Future<AppointmentsState> patchAppointments(int kidId, int appointmentId) {
    // TODO: implement patchAppointments
    throw UnimplementedError();
  }

  @override
  Future<AppointmentsState> putAppointmentsAll(int kidId, int appointmentId) {
    // TODO: implement putAppointmentsAll
    throw UnimplementedError();
  }

  @override
  Future<AppointmentsState> createAppointment(
      int kidId, String doutor, String dataConsulta) async {
    try {
      final response = await dio.post(
        "$apiUrl/accounts/me/kids/${kidId.toString()}/appointments/",
        data: {
          "doctor": doutor.toString(),
          "date": dataConsulta.toString(),
          "status": "pending",
          "score": 0
        },
      );
      return (response.statusCode == 201)
          ? const SuccessOtherAppointmentsState()
          : const CreateErrorExceptionAppointmentsState(
              error: "Erro ao cadastrar consulta!");
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 400) {
          return CreateErrorExceptionAppointmentsState(
              error: e.response!.data["date"][0]);
        }
        return const CreateErrorExceptionAppointmentsState(
            error: "Erro ao cadastrar consulta!");
      }
      return const CreateErrorExceptionAppointmentsState(
          error: "Erro ao cadastrar consulta!");
    }
  }
}
