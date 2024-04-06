import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/entities/auth_entities.dart';
import 'package:tooth_ease_frontend/env.dart';

import '../../interactor/states/login_state.dart';
import '../entities/user_credentials_entities.dart';

abstract class ILoginService {
  Future<LoginState> login(UserCredentialsEntity userCredentials);
}

class LoginService implements ILoginService {
  final Dio dio;
  late AuthEntity auth;

  LoginService({required this.dio});

  @override
  Future<LoginState> login(UserCredentialsEntity userCredentials) async {
    try {
      final response = await dio.post('$apiUrl/token/', data: {
        'username': userCredentials.username,
        'password': userCredentials.password,
        
      });
      if (response.statusCode == 200) {
        auth = AuthEntity(token: response.data['access'], refreshToken: response.data['refresh']);
        return SuccessLoginState(auth: auth);
      }
      throw Exception('Failed to login: ${response.statusCode} : ${response.data}');
      
    } catch (e) {
      debugPrint('Error: $e');
      return ErrorExceptionLoginState();
    }
  }
}