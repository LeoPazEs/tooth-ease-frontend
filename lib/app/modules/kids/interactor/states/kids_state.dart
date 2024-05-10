import 'package:tooth_ease_frontend/app/modules/kids/data/entities/error_entities.dart';

import '../../data/entities/kid_entities.dart';

abstract interface class KidsState {}

class StartKidsState implements KidsState {
  const StartKidsState();
}

class SuccessResponseKidsState implements KidsState {
  const SuccessResponseKidsState();
}

class SuccessGetKidsState implements KidsState {
  final KidEntity kid;
  const SuccessGetKidsState({required this.kid});
}

class SuccessKidsState implements KidsState {
  final List<CompleteKidEntity> kids;
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

class ErrorCreateKidState implements KidsState {
  final ErrorCreateKidEntity error;
  const ErrorCreateKidState({required this.error});
}
