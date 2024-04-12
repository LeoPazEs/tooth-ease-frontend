// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterStore on _RegisterStoreBase, Store {
  late final _$stateAtom =
      Atom(name: '_RegisterStoreBase.state', context: context);

  @override
  RegisterState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(RegisterState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$registerAsyncAction =
      AsyncAction('_RegisterStoreBase.register', context: context);

  @override
  Future<dynamic> register(
      String username, String password, String firstName, String lastName) {
    return _$registerAsyncAction
        .run(() => super.register(username, password, firstName, lastName));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
