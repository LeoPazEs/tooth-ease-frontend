import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tooth_ease_frontend/env.dart';

import '../../interactor/states/kids_state.dart';
import '../entities/kid_entities.dart';

import '../entities/secure_storage_entities.dart';

abstract class IKidsService {
  Future<KidsState> getKids();
}

class KidsService implements IKidsService {
  final Dio dio;
  final ISecureStorage storage;

  KidsService({required this.dio, required this.storage});

  @override
  Future<KidsState> getKids() async {
    try {
      final response = await dio.get('$apiUrl/accounts/me/kids/',
          options: Options(headers: {
            'Authorization': "Bearer ${await storage.read("token")}"
          }));
      if (response.statusCode == 200) {
        List<KidEntity> kids = (response.data as List)
            .map((kid) => KidEntity.fromJson(kid))
            .toList();
        return SuccessKidsState(kids: kids);
      }
      return const ErrorExceptionKidsState();
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          return const ErrorExceptionKidsState();
        }
      }
      return const ErrorExceptionKidsState();
    }
  }
}
