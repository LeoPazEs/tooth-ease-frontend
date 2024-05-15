import 'package:tooth_ease_frontend/app/modules/profile/ui/pages/profile_page.dart';
import 'package:tooth_ease_frontend/app/modules/profile/interactor/stores/profile_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProfileStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ProfilePage()),
  ];
}
