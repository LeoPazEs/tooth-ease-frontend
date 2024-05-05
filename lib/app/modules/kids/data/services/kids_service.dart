import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/app/modules/shared/secure_storage_service.dart';
import 'package:tooth_ease_frontend/app/modules/shared/env.dart';

import '../../interactor/states/kids_state.dart';
import '../entities/kid_entities.dart';

abstract class IKidsService {
  Future<KidsState> getKids();
}

class KidsService implements IKidsService {
  final Dio dio;
  final ISecureStorageService storage;

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
