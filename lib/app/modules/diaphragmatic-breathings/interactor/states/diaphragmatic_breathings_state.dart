import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/entities/diaphragmatic_breathings_entity.dart';

import '../../data/entities/diaphragmatic_breathings_step_entity.dart';

abstract interface class DiaphragmaticBreathingsState {}

class StartDiaphragmaticBreathingsState
    implements DiaphragmaticBreathingsState {
  const StartDiaphragmaticBreathingsState();
}

class SuccessDiaphragmaticBreathingsState
    implements DiaphragmaticBreathingsState {
  final List<DiaphragmaticBreathingsEntity> diaphragmaticBreathings;
  const SuccessDiaphragmaticBreathingsState(
      {required this.diaphragmaticBreathings});
}

class SuccessDiaphragmaticBreathingsStepState
    implements DiaphragmaticBreathingsState {
  final List<DiaphragmaticBreathingsStepEntity> diaphragmaticBreathings;
  const SuccessDiaphragmaticBreathingsStepState(
      {required this.diaphragmaticBreathings});
}

class SuccessOtherDiaphragmaticBreathingsState
    implements DiaphragmaticBreathingsState {
  const SuccessOtherDiaphragmaticBreathingsState();
}

class ErrorExceptionDiaphragmaticBreathingsState
    implements DiaphragmaticBreathingsState {
  const ErrorExceptionDiaphragmaticBreathingsState();
}

class OtherErrorExceptionDiaphragmaticBreathingsState
    implements DiaphragmaticBreathingsState {
  final String error;
  const OtherErrorExceptionDiaphragmaticBreathingsState({required this.error});
}

class LoadingDiaphragmaticBreathingsState
    implements DiaphragmaticBreathingsState {
  const LoadingDiaphragmaticBreathingsState();
}

class EmptyDiaphragmaticBreathingsState
    implements DiaphragmaticBreathingsState {
  const EmptyDiaphragmaticBreathingsState();
}
