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

  late final _$kidsAtom = Atom(name: '_KidsStoreBase.kids', context: context);

  @override
  List<KidEntity> get kids {
    _$kidsAtom.reportRead();
    return super.kids;
  }

  @override
  set kids(List<KidEntity> value) {
    _$kidsAtom.reportWrite(value, super.kids, () {
      super.kids = value;
    });
  }

  late final _$getKidsAsyncAction =
      AsyncAction('_KidsStoreBase.getKids', context: context);

  @override
  Future<dynamic> getKids() {
    return _$getKidsAsyncAction.run(() => super.getKids());
  }

  @override
  String toString() {
    return '''
state: ${state},
kids: ${kids}
    ''';
  }
}
