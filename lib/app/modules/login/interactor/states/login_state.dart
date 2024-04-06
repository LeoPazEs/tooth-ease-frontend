import '../../data/entities/auth_entities.dart';

abstract interface class LoginState {}

class StartLoginState implements LoginState {
  const StartLoginState();
}

class SuccessLoginState implements LoginState {
  final AuthEntity auth ;
  const SuccessLoginState({required this.auth});
}

class ErrorExceptionLoginState implements LoginState {
  const ErrorExceptionLoginState();
}

class LoadingLoginState implements LoginState {
  const LoadingLoginState();
}

class EmptyLoginState implements LoginState {
  const EmptyLoginState();
}