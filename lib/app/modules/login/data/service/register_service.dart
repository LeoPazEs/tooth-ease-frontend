import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/env.dart';

import '../../interactor/states/register_state.dart';
import '../../data/entities/error_register_entities.dart';
import '../entities/user_register_entity.dart';

abstract class IRegisterService {
  Future<RegisterState> register(UserRegisterEntity register);
}

class RegisterService implements IRegisterService {
  final Dio dio;

  RegisterService({required this.dio});

  @override
  Future<RegisterState> register(UserRegisterEntity userRegister) async {
    try {
      final response = await dio.post('$apiUrl/accounts/', data: {
        'username': userRegister.username,
        'password': userRegister.password,
        'first_name': userRegister.firstName,
        'last_name': userRegister.lastName
      });
      if (response.statusCode == 200) {
        return const SuccessRegisterState();
      }
      return ErrorExceptionRegisterState(
          error:
              ErrorRegisterEntity(detail: 'Um erro ocorreu, tente novamente.'));
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 400) {
          ErrorRegisterEntity error = ErrorRegisterEntity(
              detail: e.response!.data["detail"],
              username: e.response!.data["username"],
              password: e.response!.data["password"],
              firstName: e.response!.data["first_name"],
              lastName: e.response!.data["last_name"]);

          return ErrorExceptionRegisterState(error: error);
        }
      }
      return ErrorExceptionRegisterState(
          error:
              ErrorRegisterEntity(detail: 'Um erro ocorreu, tente novamente.'));
    }
  }
}
