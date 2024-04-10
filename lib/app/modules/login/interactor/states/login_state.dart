import '../../data/entities/error_login_entities.dart';

abstract interface class LoginState {}

class StartLoginState implements LoginState {
  const StartLoginState();
}

class SuccessLoginState implements LoginState {
  const SuccessLoginState();
}

class ErrorExceptionLoginState implements LoginState {
  final ErrorLogin error;

  const ErrorExceptionLoginState({required this.error});
}

class LoadingLoginState implements LoginState {
  const LoadingLoginState();
}

class EmptyLoginState implements LoginState {
  const EmptyLoginState();
}
