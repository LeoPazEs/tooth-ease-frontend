// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointments_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppointmentsStore on _AppointmentsStoreBase, Store {
  late final _$stateAtom =
      Atom(name: '_AppointmentsStoreBase.state', context: context);

  @override
  AppointmentsState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AppointmentsState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$selectedDateAtom =
      Atom(name: '_AppointmentsStoreBase.selectedDate', context: context);

  @override
  DateTime get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  late final _$selectedTimeAtom =
      Atom(name: '_AppointmentsStoreBase.selectedTime', context: context);

  @override
  TimeOfDay get selectedTime {
    _$selectedTimeAtom.reportRead();
    return super.selectedTime;
  }

  @override
  set selectedTime(TimeOfDay value) {
    _$selectedTimeAtom.reportWrite(value, super.selectedTime, () {
      super.selectedTime = value;
    });
  }

  late final _$selectedStatusAtom =
      Atom(name: '_AppointmentsStoreBase.selectedStatus', context: context);

  @override
  String? get selectedStatus {
    _$selectedStatusAtom.reportRead();
    return super.selectedStatus;
  }

  @override
  set selectedStatus(String? value) {
    _$selectedStatusAtom.reportWrite(value, super.selectedStatus, () {
      super.selectedStatus = value;
    });
  }

  late final _$selectedScoreAtom =
      Atom(name: '_AppointmentsStoreBase.selectedScore', context: context);

  @override
  String? get selectedScore {
    _$selectedScoreAtom.reportRead();
    return super.selectedScore;
  }

  @override
  set selectedScore(String? value) {
    _$selectedScoreAtom.reportWrite(value, super.selectedScore, () {
      super.selectedScore = value;
    });
  }

  late final _$selectDateAndTimeAsyncAction =
      AsyncAction('_AppointmentsStoreBase.selectDateAndTime', context: context);

  @override
  Future<void> selectDateAndTime(BuildContext context) {
    return _$selectDateAndTimeAsyncAction
        .run(() => super.selectDateAndTime(context));
  }

  late final _$_AppointmentsStoreBaseActionController =
      ActionController(name: '_AppointmentsStoreBase', context: context);

  @override
  void setSelectedScore(String value) {
    final _$actionInfo = _$_AppointmentsStoreBaseActionController.startAction(
        name: '_AppointmentsStoreBase.setSelectedScore');
    try {
      return super.setSelectedScore(value);
    } finally {
      _$_AppointmentsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedStatus(String value) {
    final _$actionInfo = _$_AppointmentsStoreBaseActionController.startAction(
        name: '_AppointmentsStoreBase.setSelectedStatus');
    try {
      return super.setSelectedStatus(value);
    } finally {
      _$_AppointmentsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearController() {
    final _$actionInfo = _$_AppointmentsStoreBaseActionController.startAction(
        name: '_AppointmentsStoreBase.clearController');
    try {
      return super.clearController();
    } finally {
      _$_AppointmentsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic emit(AppointmentsState newState) {
    final _$actionInfo = _$_AppointmentsStoreBaseActionController.startAction(
        name: '_AppointmentsStoreBase.emit');
    try {
      return super.emit(newState);
    } finally {
      _$_AppointmentsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleResponse(AppointmentsState response) {
    final _$actionInfo = _$_AppointmentsStoreBaseActionController.startAction(
        name: '_AppointmentsStoreBase.handleResponse');
    try {
      return super.handleResponse(response);
    } finally {
      _$_AppointmentsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
selectedDate: ${selectedDate},
selectedTime: ${selectedTime},
selectedStatus: ${selectedStatus},
selectedScore: ${selectedScore}
    ''';
  }
}
