// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diaphragmaticBreathings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DiaphragmaticBreathingsStore
    on _DiaphragmaticBreathingsStoreBase, Store {
  late final _$selectedDateAtom = Atom(
      name: '_DiaphragmaticBreathingsStoreBase.selectedDate', context: context);

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

  late final _$selectedTimeAtom = Atom(
      name: '_DiaphragmaticBreathingsStoreBase.selectedTime', context: context);

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

  late final _$stateAtom =
      Atom(name: '_DiaphragmaticBreathingsStoreBase.state', context: context);

  @override
  DiaphragmaticBreathingsState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(DiaphragmaticBreathingsState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$selectDateAndTimeAsyncAction = AsyncAction(
      '_DiaphragmaticBreathingsStoreBase.selectDateAndTime',
      context: context);

  @override
  Future<void> selectDateAndTime(BuildContext context) {
    return _$selectDateAndTimeAsyncAction
        .run(() => super.selectDateAndTime(context));
  }

  late final _$_DiaphragmaticBreathingsStoreBaseActionController =
      ActionController(
          name: '_DiaphragmaticBreathingsStoreBase', context: context);

  @override
  dynamic emit(DiaphragmaticBreathingsState newState) {
    final _$actionInfo = _$_DiaphragmaticBreathingsStoreBaseActionController
        .startAction(name: '_DiaphragmaticBreathingsStoreBase.emit');
    try {
      return super.emit(newState);
    } finally {
      _$_DiaphragmaticBreathingsStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDate: ${selectedDate},
selectedTime: ${selectedTime},
state: ${state}
    ''';
  }
}
