import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/app/modules/shared/secure_storage_service.dart';
import 'package:tooth_ease_frontend/env.dart';

abstract interface class ITokenAuthService {
  Future<bool> isValid(String key);
  Future refreshToken();
}

class TokenAuthService implements ITokenAuthService {
  late Dio dio;
  final ISecureStorageService storage;

  TokenAuthService({required this.storage}) {
    dio = Dio();
  }

  @override
  Future<bool> isValid(String key) async {
    try {
      String? token = await storage.read(key);
      if (token!.isNotEmpty) {
        var response =
            await dio.post("${apiUrl}token/verify/", data: {"token": token});
        return (response.statusCode == 200);
      } else {
        return false;
      }
    } catch (e) {
      print("Erro ao verificar a validade do token: $e");
      return false;
    }
  }

  @override
  Future refreshToken() async {
    try {
      String? token = await storage.read("refreshToken");
      if (token!.isNotEmpty) {
        var response =
            await dio.post("${apiUrl}token/refresh/", data: {"token": token});
        if (response.statusCode == 200) {
          await storage.delete("token");
          await storage.write("token", response.data["access"]);
        }
      }
    } catch (e) {
      print("Erro ao atualizar o token: $e");
    }
  }
}
