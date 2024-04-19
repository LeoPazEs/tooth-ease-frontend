import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/shared/token_auth.dart';

class AuthGuard extends RouteGuard {
  final ITokenAuthService tokenAuthService;

  AuthGuard({super.redirectTo, required this.tokenAuthService});

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    bool isAuthenticated = await tokenAuthService.isValid("refreshToken");

    if (isAuthenticated) {
      return true;
    } else {
      Modular.to.navigate("/login");
      return false;
    }
  }
}
