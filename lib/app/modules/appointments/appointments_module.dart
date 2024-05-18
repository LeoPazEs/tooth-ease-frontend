import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/data/services/appointments_services.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/ui/pages/appointments_page.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/interactor/stores/appointments_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../shared/secure_storage_service.dart';

class AppointmentsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AppointmentsService(dio: i.get<Dio>())),
    Bind.lazySingleton((i) => AppointmentsStore(
          appointmentsService: i.get<AppointmentsService>(),
          storage: i.get<SecureStorageService>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AppointmentsPage()),
  ];
}
