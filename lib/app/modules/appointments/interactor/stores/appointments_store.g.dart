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

  late final _$_AppointmentsStoreBaseActionController =
      ActionController(name: '_AppointmentsStoreBase', context: context);

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
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
