import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
      if (await storage.hasToken()) {
        var response = await dio.post("${apiUrl}token/verify/",
            data: {"token": await storage.read(key)});
        return (response.statusCode == 200);
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future refreshToken() async {
    try {
      if (await storage.hasToken()) {
        var response = await dio.post("${apiUrl}token/refresh/",
            data: {"refresh": await storage.read("refreshToken")});
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
