import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  Map<String, String> counter = {};

  Future<void> increment() async {
    counter = await FlutterSecureStorage().readAll();
  }
}
