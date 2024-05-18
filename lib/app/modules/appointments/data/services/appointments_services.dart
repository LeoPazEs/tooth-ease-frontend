import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/data/adapters/Appointments_adapters.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/data/entities/appointments_entity.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/data/entities/error_entities.dart';

import '../../../shared/env.dart';
import '../../interactor/state/appointments_state.dart';

abstract interface class IAppointmentsService {
  Future<AppointmentsState> getAppointmentsAll(
      int kidId, String date, String doctor, String score, String status);
  Future<AppointmentsState> createAppointment(
      int kidId, String doutor, String dataConsulta);
  Future<AppointmentsState> getAppointmentsById(int kidId, int appointmentId);
  Future<AppointmentsState> putAppointmentsAll(int kidId, int appointmentId,
      String doutor, String dataConsulta, String status, String score);
  Future<AppointmentsState> patchAppointments(int kidId, int appointmentId);
  Future<AppointmentsState> deleteAppointments(int kidId, int appointmentId);
}

class AppointmentsService implements IAppointmentsService {
  final Dio dio;

  AppointmentsService({required this.dio});
  @override
  Future<AppointmentsState> getAppointmentsAll(int kidId, String date,
      String doctor, String score, String status) async {
    try {
      final response = await dio.get(
          "$apiUrl/accounts/me/kids/$kidId/appointments/",
          queryParameters: {
            'date': date,
            'doctor': doctor,
            'score': score,
            'status': status,
          });
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
  Future<AppointmentsState> deleteAppointments(
      int kidId, int appointmentId) async {
    try {
      final response = await dio.delete(
          "$apiUrl/accounts/me/kids/$kidId/appointments/$appointmentId/");
      if (response.statusCode == 204) {
        return const SuccessOtherAppointmentsState();
      } else {
        return const OtherErrorExceptionAppointmentsState(
            error: "Não foi possivel deletar consulta!");
      }
    } catch (e) {
      print(e);
      return const OtherErrorExceptionAppointmentsState(
          error: "Não foi possivel deletar consulta!");
    }
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
  Future<AppointmentsState> putAppointmentsAll(int kidId, int appointmentId,
      String doutor, String dataConsulta, String status, String score) async {
    try {
      final response = await dio.put(
        "$apiUrl/accounts/me/kids/$kidId/appointments/$appointmentId/",
        data: {
          "kid": kidId,
          "doctor": doutor,
          "date": dataConsulta,
          "status": status,
          "score": score
        },
      );
      return (response.statusCode == 200)
          ? const SuccessOtherAppointmentsState()
          : const OtherErrorExceptionAppointmentsState(
              error: "Não foi possivel atualizar os dados!");
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 400) {
          return SubmitErrorExceptionAppointmentsState(
            error: ErrorCreateAppointmentsEntity(
              date: e.response!.data["date"],
              name: e.response!.data["doctor"],
              detail: e.response!.data["non_field_errors"][0],
            ),
          );
        }
        return const OtherErrorExceptionAppointmentsState(
            error: "Não foi possivel atualizar os dados!");
      }
      return const OtherErrorExceptionAppointmentsState(
          error: "Não foi possivel atualizar os dados!");
    }
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
          : const ErrorExceptionAppointmentsState();
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 400) {
          return SubmitErrorExceptionAppointmentsState(
            error: ErrorCreateAppointmentsEntity(
              date: e.response!.data["date"],
              name: e.response!.data["doctor"],
              detail: e.response!.data["non_field_errors"],
            ),
          );
        }
        return const OtherErrorExceptionAppointmentsState(
            error: "Erro ao cadastrar consulta!");
      }
      return const OtherErrorExceptionAppointmentsState(
          error: "Erro ao cadastrar consulta!");
    }
  }
}
