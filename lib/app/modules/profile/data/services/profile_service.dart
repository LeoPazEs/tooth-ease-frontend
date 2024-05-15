import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/app/modules/shared/secure_storage_service.dart';
import 'package:tooth_ease_frontend/app/modules/shared/env.dart';

import '../../interactor/states/profile_state.dart';

abstract class IProfileService {
  Future<ProfileState> getProfile();
}

class ProfileService implements IProfileService {
  final Dio dio;
  final ISecureStorageService storage;
  final url = '$apiUrl/accounts/me/profiles/';

  ProfileService({required this.dio, required this.storage});

  @override
  Future<ProfileState> getProfile() async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return SuccessProfileState(profile: profile);
      }
      return const ErrorExceptionProfileState();
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          return const ErrorExceptionProfileState();
        }
      }
      return const ErrorExceptionProfileState();
    }
  }
}
