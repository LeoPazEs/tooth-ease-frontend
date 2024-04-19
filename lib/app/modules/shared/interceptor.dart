import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/app/modules/shared/secure_storage_service.dart';
import 'package:tooth_ease_frontend/app/modules/shared/token_auth.dart';

class ApiInterceptor extends Interceptor {
  final ISecureStorageService storage;
  final ITokenAuthService tokenAuthService;

  ApiInterceptor({required this.tokenAuthService, required this.storage});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      if (await tokenAuthService.isValid("token") == false) {
        await tokenAuthService.refreshToken();
      }
      options.headers["Authorization"] =
          "Bearer ${await storage.read("token")}";
      handler.next(options);
    } catch (e) {
      print("Erro durante a interceptação da solicitação: $e");
    }
  }
}
