import '../../data/entities/kid_entities.dart';

abstract interface class KidsState {}

class StartKidsState implements KidsState {
  const StartKidsState();
}

class SuccessKidsState implements KidsState {
  final List<KidEntity> kids;
  const SuccessKidsState({required this.kids});
}

class ErrorExceptionKidsState implements KidsState {
  const ErrorExceptionKidsState();
}

class LoadingKidsState implements KidsState {
  const LoadingKidsState();
}

class EmptyKidsState implements KidsState {
  const EmptyKidsState();
}
