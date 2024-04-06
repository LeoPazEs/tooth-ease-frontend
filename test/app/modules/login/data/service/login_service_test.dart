import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/entities/user_credentials_entities.dart';
import 'package:tooth_ease_frontend/app/modules/login/data/service/login_service.dart';
import 'package:tooth_ease_frontend/app/modules/login/interactor/states/login_state.dart';

void main() {
  group('LoginService', () {
    late LoginService loginService;
    late UserCredentialsEntity userCredentials;
    late Dio dio;

    setUp(() {
      dio = Dio();
      loginService = LoginService(dio: dio);

    });

    test('should return true when login is successful', () async {
      userCredentials = UserCredentialsEntity(username: '', password: '');

      LoginState stateLogin = await loginService.login(userCredentials);
      expect(stateLogin, isA<SuccessLoginState>());

      if (stateLogin is SuccessLoginState) {
        expect(stateLogin.auth.token, isNotEmpty);
        expect(stateLogin.auth.refreshToken, isNotEmpty);
      }
      
    });

    test('should return false when login fails', () async {
      userCredentials = UserCredentialsEntity(username: '', password: '');

      LoginState stateLogin = await loginService.login(userCredentials);
      expect(stateLogin, isA<ErrorExceptionLoginState>());
    });
  });
}