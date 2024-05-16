import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tooth_ease_frontend/app/modules/profile/data/entities/profile_entities.dart';
import 'package:tooth_ease_frontend/app/modules/shared/secure_storage_service.dart';
import 'package:tooth_ease_frontend/app/modules/shared/env.dart';

import '../../interactor/states/profile_state.dart';
import '../adapters/profile_adapter.dart';

abstract class IProfileService {
  Future<ProfileState> getProfile();
  Future<ProfileState> patchProfile(PatchProfileEntity profileEntity);
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
        UserEntity user = UserAdapter.fromJson(response.data["user"]);
        ProfileEntity profile = ProfileAdapter.fromJson(response.data, user);
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

  @override
  Future<ProfileState> patchProfile(PatchProfileEntity profileEntity) async {
    try {
      var response =
          await dio.patch(url, data: ProfileAdapter.toJson(profileEntity));
      if (response.statusCode == 200) {
        return const SuccessResponseProfileState();
      } else {
        return const ErrorExceptionProfileState();
      }
    } catch (e) {
      if (e is DioError) {
        debugPrint(e.response!.statusCode.toString());
        return const ErrorExceptionProfileState();
      }
      return const ErrorExceptionProfileState();
    }
  }
}
