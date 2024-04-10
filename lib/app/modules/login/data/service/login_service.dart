import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/entities/secure_storage_entities.dart';
import 'package:tooth_ease_frontend/env.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../interactor/states/login_state.dart';
import '../entities/user_credentials_entities.dart';
import '../entities/error_login_entities.dart';

abstract class ILoginService {
  Future<LoginState> login(UserCredentialsEntity userCredentials);
}

class LoginService implements ILoginService {
  final Dio dio;
  final ISecureStorage storage;

  LoginService({required this.dio, required this.storage});

  @override
  Future<LoginState> login(UserCredentialsEntity userCredentials) async {
    try {
      final response = await dio.post('$apiUrl/token/', data: {
        'username': userCredentials.username,
        'password': userCredentials.password,
      });
      if (response.statusCode == 200) {
        storage.write('token', response.data['access']);
        storage.write('refreshToken', response.data['refresh']);
        return const SuccessLoginState();
      }
      return ErrorExceptionLoginState(
          error: ErrorLoginEntity(detail: 'Um erro ocorreu, tente novamente.'));
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          ErrorLoginEntity error =
              ErrorLoginEntity(detail: e.response!.data['detail']);
          return ErrorExceptionLoginState(error: error);
        }
      }
      return ErrorExceptionLoginState(
          error: ErrorLoginEntity(detail: 'Um erro ocorreu, tente novamente.'));
    }
  }
}
