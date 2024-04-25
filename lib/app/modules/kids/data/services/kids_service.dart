import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/app/modules/kids/data/adapters/kid_adapter.dart';
import 'package:tooth_ease_frontend/app/modules/shared/secure_storage_service.dart';
import 'package:tooth_ease_frontend/env.dart';

import '../../interactor/states/kids_state.dart';
import '../entities/kid_entities.dart';

abstract class IKidsService {
  Future<KidsState> getKids();
  Future<KidsState> createKid(KidEntity kidEntity);
  Future<KidsState> getKidById(int id);
  Future<KidsState> putKidAll(int id, KidEntity kidEntity);
  Future<KidsState> putKid(int id, KidEntity kidEntity);
  Future<KidsState> deleteKid(int id);
}

class KidsService implements IKidsService {
  final Dio dio;
  final ISecureStorageService storage;
  final url = '$apiUrl/accounts/me/kids/';

  KidsService({required this.dio, required this.storage});

  @override
  Future<KidsState> getKids() async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        List<KidEntity> kids = (response.data as List)
            .map((kid) => KidAdapter.fromJson(kid))
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

  @override
  Future<KidsState> createKid(KidEntity kidEntity) async {
    try {
      var response = await dio.post(url, data: KidAdapter.toJson(kidEntity));
      if (response.statusCode == 200) {
        return const SuccessResponseKidsState();
      } else {
        return const ErrorExceptionKidsState();
      }
    } catch (e) {
      return const ErrorExceptionKidsState();
    }
  }

  @override
  Future<KidsState> deleteKid(int id) async {
    try {
      var response = await dio.delete("$url/$id/");
      if (response.statusCode == 200) {
        return const SuccessResponseKidsState();
      } else {
        return const ErrorExceptionKidsState();
      }
    } catch (e) {
      return const ErrorExceptionKidsState();
    }
  }

  @override
  Future<KidsState> getKidById(int id) async {
    try {
      var response = await dio.get("$url/$id/");
      if (response.statusCode == 200) {
        KidEntity kid = KidAdapter.fromJson(response.data);
        return SuccessGetKidsState(kid: kid);
      } else {
        return const ErrorExceptionKidsState();
      }
    } catch (e) {
      return const ErrorExceptionKidsState();
    }
  }

  @override
  Future<KidsState> putKid(int id, KidEntity kidEntity) async {
    try {
      var response = await dio.post(url, data: KidAdapter.toJson(kidEntity));
      if (response.statusCode == 200) {
        return const SuccessResponseKidsState();
      } else {
        return const ErrorExceptionKidsState();
      }
    } catch (e) {
      return const ErrorExceptionKidsState();
    }
  }

  @override
  Future<KidsState> putKidAll(int id, KidEntity kidEntity) async {
    try {
      var response = await dio.post(url, data: KidAdapter.toJson(kidEntity));
      if (response.statusCode == 200) {
        return const SuccessResponseKidsState();
      } else {
        return const ErrorExceptionKidsState();
      }
    } catch (e) {
      return const ErrorExceptionKidsState();
    }
  }
}
