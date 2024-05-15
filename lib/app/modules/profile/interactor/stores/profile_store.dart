import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tooth_ease_frontend/app/modules/shared/interceptor.dart';
import 'package:tooth_ease_frontend/app/modules/shared/secure_storage_service.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  final SecureStorageService storage;

  _ProfileStoreBase({required this.storage});

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
