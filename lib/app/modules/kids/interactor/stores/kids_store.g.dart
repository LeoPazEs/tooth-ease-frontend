// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kids_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$KidsStore on _KidsStoreBase, Store {
  late final _$stateAtom = Atom(name: '_KidsStoreBase.state', context: context);

  @override
  KidsState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(KidsState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$selectedDateAtom =
      Atom(name: '_KidsStoreBase.selectedDate', context: context);

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

  late final _$selectDateAsyncAction =
      AsyncAction('_KidsStoreBase.selectDate', context: context);

  @override
  Future<void> selectDate(BuildContext context) {
    return _$selectDateAsyncAction.run(() => super.selectDate(context));
  }

  late final _$_KidsStoreBaseActionController =
      ActionController(name: '_KidsStoreBase', context: context);

  @override
  dynamic emit(KidsState newState) {
    final _$actionInfo = _$_KidsStoreBaseActionController.startAction(
        name: '_KidsStoreBase.emit');
    try {
      return super.emit(newState);
    } finally {
      _$_KidsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
selectedDate: ${selectedDate}
    ''';
  }
}
