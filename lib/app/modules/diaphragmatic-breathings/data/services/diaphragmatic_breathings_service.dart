import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/adapters/diaphragmatic_breathings_adapters.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/adapters/diaphragmatic_breathings_step_adapters.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/entities/diaphragmatic_breathings_entity.dart';
import 'package:tooth_ease_frontend/app/modules/shared/env.dart';

import '../../interactor/states/diaphragmatic_breathings_state.dart';
import '../entities/diaphragmatic_breathings_step_entity.dart';

abstract interface class IDiaphragmaticBreathingsService {
  Future<DiaphragmaticBreathingsState> getDiaphragmaticBreathingsAll(
      String kidId, String appointmentId);
  Future<DiaphragmaticBreathingsState> postDiaphragmaticBreathings(
      String kidId, String appointmentId);
  Future<DiaphragmaticBreathingsState> putDiaphragmaticBreathings(String kidId,
      String appointmentId, String diaphragmaticBreathingId, String date);
  Future<DiaphragmaticBreathingsState> getDiaphragmaticBreathingsById(
      String id, String kidId, String appointmentId);
  Future<DiaphragmaticBreathingsState> deleteDiaphragmaticBreathings(
    String kidId,
    String appointmentId,
    String diaphragmaticBreathingId,
  );
  Future<DiaphragmaticBreathingsState> getStepDiaphragmaticBreathings();
}

class DiaphragmaticBreathingsService
    implements IDiaphragmaticBreathingsService {
  final Dio dio;

  DiaphragmaticBreathingsService({required this.dio});

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
        if (diaphragmaticBreathings.isNotEmpty) {
          return SuccessDiaphragmaticBreathingsState(
              diaphragmaticBreathings: diaphragmaticBreathings);
        }
        return const EmptyDiaphragmaticBreathingsState();
      }
      return const ErrorExceptionDiaphragmaticBreathingsState();
    } catch (e) {
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
  Future<DiaphragmaticBreathingsState> getStepDiaphragmaticBreathings() async {
    try {
      var response = await dio.get('$apiUrl/tutorial-diaphragmatic-breathing/');
      List<DiaphragmaticBreathingsStepEntity> diaphragmaticBreathings =
          (response.data as List)
              .map((json) => DiaphragmaticBreathingsStepAdapters.fromJson(json))
              .toList();
      if (response.statusCode == 200) {
        return SuccessDiaphragmaticBreathingsStepState(
          diaphragmaticBreathings: diaphragmaticBreathings,
        );
      } else {
        return const ErrorExceptionDiaphragmaticBreathingsState();
      }
    } catch (e) {
      return const ErrorExceptionDiaphragmaticBreathingsState();
    }
  }

  @override
  Future<DiaphragmaticBreathingsState> postDiaphragmaticBreathings(
      String kidId, String appointmentId) async {
    try {
      var response = await dio.post(
        '$apiUrl/accounts/me/kids/$kidId/appointments/$appointmentId/diaphragmatic-breathing/',
        data: {
          'date': DateFormat('yyyy-MM-dd\'T\'HH:mm:ss.000\'Z\'')
              .format(DateTime.now())
        },
      );
      if (response.statusCode == 201) {
        return const SuccessDiaphragmaticBreathingsStepState(
            diaphragmaticBreathings: []);
      }
      return const ErrorExceptionDiaphragmaticBreathingsState();
    } catch (e) {
      if (e is DioError) {
        debugPrint(e.response!.data.toString());
      }
      return const ErrorExceptionDiaphragmaticBreathingsState();
    }
  }

  @override
  Future<DiaphragmaticBreathingsState> putDiaphragmaticBreathings(
      String kidId,
      String appointmentId,
      String diaphragmaticBreathingId,
      String date) async {
    try {
      var response = await dio.put(
        '$apiUrl/accounts/me/kids/$kidId/appointments/$appointmentId/diaphragmatic-breathing/$diaphragmaticBreathingId/',
        data: {'date': date, 'appointment': appointmentId},
      );
      if (response.statusCode == 200) {
        return const SuccessDiaphragmaticBreathingsState(
            diaphragmaticBreathings: []);
      }
      return const ErrorExceptionDiaphragmaticBreathingsState();
    } catch (e) {
      if (e is DioError) {
        debugPrint(e.response!.data.toString());
      }
      return const ErrorExceptionDiaphragmaticBreathingsState();
    }
  }

  @override
  Future<DiaphragmaticBreathingsState> deleteDiaphragmaticBreathings(
    String kidId,
    String appointmentId,
    String diaphragmaticBreathingId,
  ) async {
    try {
      var response = await dio.delete(
        '$apiUrl/accounts/me/kids/$kidId/appointments/$appointmentId/diaphragmatic-breathing/$diaphragmaticBreathingId/',
      );
      if (response.statusCode == 204) {
        return const SuccessDiaphragmaticBreathingsState(
            diaphragmaticBreathings: []);
      }
      return const ErrorExceptionDiaphragmaticBreathingsState();
    } catch (e) {
      if (e is DioError) {
        debugPrint(e.response!.data.toString());
      }
      return const ErrorExceptionDiaphragmaticBreathingsState();
    }
  }
}
