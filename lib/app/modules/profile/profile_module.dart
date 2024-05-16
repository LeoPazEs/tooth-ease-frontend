import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/app/modules/profile/data/services/profile_service.dart';
import 'package:tooth_ease_frontend/app/modules/profile/ui/pages/profile_page.dart';
import 'package:tooth_ease_frontend/app/modules/profile/interactor/stores/profile_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../shared/secure_storage_service.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProfileService(
        dio: i.get<Dio>(), storage: i.get<SecureStorageService>())),
    Bind.lazySingleton(
        (i) => ProfileStore(storage: i.get<SecureStorageService>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ProfilePage()),
  ];
}
