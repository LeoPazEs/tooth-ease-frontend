import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/entities/kid_entities.dart';
import '../../data/services/kids_service.dart';
import '../states/kids_state.dart';

part 'kids_store.g.dart';

class KidsStore = _KidsStoreBase with _$KidsStore;

abstract class _KidsStoreBase with Store {
  final IKidsService kidsService;

  @observable
  KidsState state = const StartKidsState();

  @observable
  List<KidEntity> kids = [];

  _KidsStoreBase({required this.kidsService});

  @action
  Future getKids() async {
    state = const LoadingKidsState();
    KidsState response = await kidsService.getKids();

    if (response is SuccessKidsState) {
      kids = response.kids;
    } else if (response is ErrorExceptionKidsState) {
      Fluttertoast.showToast(
          msg: "Erro ao buscar os dados",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    state = response;
  }
}
