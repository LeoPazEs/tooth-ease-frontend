import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tooth_ease_frontend/app/modules/shared/interceptor.dart';
import 'package:tooth_ease_frontend/app/modules/shared/secure_storage_service.dart';

import '../../data/entities/kid_entities.dart';
import '../../data/services/kids_service.dart';
import '../states/kids_state.dart';

part 'kids_store.g.dart';

class KidsStore = _KidsStoreBase with _$KidsStore;

abstract class _KidsStoreBase with Store {
  final IKidsService kidsService;
  final SecureStorageService storage;

  @observable
  KidsState state = const StartKidsState();

  List<KidEntity> kids = [];

  _KidsStoreBase({required this.storage, required this.kidsService});

  @action
  emit(KidsState newState) => state = newState;

  Future getKids() async {
    emit(const LoadingKidsState());
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
    emit(response);
  }

  void configure() {
    final dio = Modular.get<Dio>();
    dio.interceptors.add(
      Modular.get<ApiInterceptor>(),
    );
  }

  Future logOut() async {
    await storage.deleteAll();
    Modular.to.navigate("/login");
  }
}
