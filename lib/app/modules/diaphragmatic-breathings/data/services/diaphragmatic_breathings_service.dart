import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/adapters/diaphragmatic_breathings_adapters.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/entities/diaphragmatic_breathings_entity.dart';
import 'package:tooth_ease_frontend/app/modules/shared/env.dart';

import '../../interactor/states/diaphragmatic_breathings_state.dart';

abstract interface class IDiaphragmaticBreathingsService {
  Future<DiaphragmaticBreathingsState> getDiaphragmaticBreathingsAll(
      String kidId, String appointmentId);
  Future<DiaphragmaticBreathingsState> postDiaphragmaticBreathings(
      String kidId, String appointmentId, String date);
  Future<DiaphragmaticBreathingsState> putDiaphragmaticBreathings(
      String kidId, String appointmentId, String date);
  Future<DiaphragmaticBreathingsState> getDiaphragmaticBreathingsById(
      String id, String kidId, String appointmentId);
  Future<DiaphragmaticBreathingsState> deleteDiaphragmaticBreathings(
      String kidId, String appointmentId);
  Future<DiaphragmaticBreathingsState> getStepDiaphragmaticBreathings();
}

class DiaphragmaticBreathingsService
    implements IDiaphragmaticBreathingsService {
  final Dio dio;

  DiaphragmaticBreathingsService({required this.dio});

  @override
  Future<DiaphragmaticBreathingsState> deleteDiaphragmaticBreathings(
      String kidId, String appointmentId) {
    // TODO: implement deleteDiaphragmaticBreathings
    throw UnimplementedError();
  }

  @override
  Future<DiaphragmaticBreathingsState> getDiaphragmaticBreathingsAll(
      String kidId, String appointmentId) async {
    try {
      var response = await dio.get(
          '$apiUrl/accounts/me/kids/$kidId/appointments/$appointmentId/diaphragmatic-breathing/');
      List<DiaphragmaticBreathingsEntity> diaphragmaticBreathings =
          (response.data as List)
              .map((json) => DiaphragmaticBreathingsAdapters.fromJson(json))
              .toList();
      if (response.statusCode == 200) {
        return SuccessDiaphragmaticBreathingsState(
            diaphragmaticBreathings: diaphragmaticBreathings);
      }
      return const ErrorExceptionDiaphragmaticBreathingsState();
    } catch (e) {
      print(e);
      return const ErrorExceptionDiaphragmaticBreathingsState();
    }
  }

  @override
  Future<DiaphragmaticBreathingsState> getDiaphragmaticBreathingsById(
      String id, String kidId, String appointmentId) {
    // TODO: implement getDiaphragmaticBreathingsById
    throw UnimplementedError();
  }

  @override
  Future<DiaphragmaticBreathingsState> getStepDiaphragmaticBreathings() {
    // TODO: implement getStepDiaphragmaticBreathings
    throw UnimplementedError();
  }

  @override
  Future<DiaphragmaticBreathingsState> postDiaphragmaticBreathings(
      String kidId, String appointmentId, String date) {
    // TODO: implement postDiaphragmaticBreathings
    throw UnimplementedError();
  }

  @override
  Future<DiaphragmaticBreathingsState> putDiaphragmaticBreathings(
      String kidId, String appointmentId, String date) {
    // TODO: implement putDiaphragmaticBreathings
    throw UnimplementedError();
  }
}
