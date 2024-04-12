import '../../data/entities/error_register_entities.dart';

abstract interface class RegisterState {}

class StartRegisterState implements RegisterState {
  const StartRegisterState();
}

class SuccessRegisterState implements RegisterState {
  const SuccessRegisterState();
}

class ErrorExceptionRegisterState implements RegisterState {
  final ErrorRegister error;

  const ErrorExceptionRegisterState({required this.error});
}

class LoadingRegisterState implements RegisterState {
  const LoadingRegisterState();
}

class EmptyRegisterState implements RegisterState {
  const EmptyRegisterState();
}
