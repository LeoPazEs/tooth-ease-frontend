// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on _ProfileStoreBase, Store {
  late final _$selectedDateAtom =
      Atom(name: '_ProfileStoreBase.selectedDate', context: context);

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

  late final _$stateAtom =
      Atom(name: '_ProfileStoreBase.state', context: context);

  @override
  ProfileState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ProfileState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$selectDateAsyncAction =
      AsyncAction('_ProfileStoreBase.selectDate', context: context);

  @override
  Future<void> selectDate(
      BuildContext context, TextEditingController dataController) {
    return _$selectDateAsyncAction
        .run(() => super.selectDate(context, dataController));
  }

  late final _$_ProfileStoreBaseActionController =
      ActionController(name: '_ProfileStoreBase', context: context);

  @override
  dynamic emit(ProfileState newState) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.emit');
    try {
      return super.emit(newState);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDate: ${selectedDate},
state: ${state}
    ''';
  }
}
