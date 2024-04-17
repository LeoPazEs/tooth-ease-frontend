import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tooth_ease_frontend/app/modules/kids/data/services/kids_service.dart';
import 'package:tooth_ease_frontend/app/modules/kids/ui/pages/kids_page.dart';
import 'package:tooth_ease_frontend/app/modules/kids/interactor/stores/kids_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/entities/secure_storage_entities.dart';

class KidsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => KidsStore(kidsService: i.get<KidsService>())),
    Bind.lazySingleton((i) => Dio()),
    Bind.lazySingleton((i) => SecureStorage(const FlutterSecureStorage())),
    Bind.lazySingleton((i) =>
        KidsService(dio: i.get<Dio>(), storage: i.get<ISecureStorage>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const KidsPage()),
  ];
}
