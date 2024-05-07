import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/app/modules/kids/data/services/kids_service.dart';
import 'package:tooth_ease_frontend/app/modules/kids/ui/pages/kids_page.dart';
import 'package:tooth_ease_frontend/app/modules/shared/secure_storage_service.dart';
import 'package:tooth_ease_frontend/app/modules/kids/interactor/stores/kids_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class KidsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => KidsStore(
        kidsService: i.get<KidsService>(),
        storage: i.get<SecureStorageService>())),
    Bind.lazySingleton(
      (i) => KidsService(
        dio: i.get<Dio>(),
        storage: i.get<ISecureStorageService>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const KidsPage()),
  ];
}
