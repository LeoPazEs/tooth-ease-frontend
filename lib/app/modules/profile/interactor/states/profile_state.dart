import '../../data/entities/profile_entities.dart';

abstract interface class ProfileState {}

class StartProfileState implements ProfileState {
  const StartProfileState();
}

class SuccessResponseProfileState implements ProfileState {
  const SuccessResponseProfileState();
}

class SuccessProfileState implements ProfileState {
  final List<ProfileEntity> profile;
  const SuccessProfileState({required this.profile});
}

class ErrorExceptionProfileState implements ProfileState {
  const ErrorExceptionProfileState();
}

class LoadingProfileState implements ProfileState {
  const LoadingProfileState();
}

class EmptyProfileState implements ProfileState {
  const EmptyProfileState();
}
