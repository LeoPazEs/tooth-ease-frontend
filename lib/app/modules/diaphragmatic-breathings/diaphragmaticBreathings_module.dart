import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/services/diaphragmatic_breathings_service.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/ui/pages/diaphragmaticBreathings_page.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/interactor/stores/diaphragmaticBreathings_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DiaphragmaticBreathingsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
        (i) => DiaphragmaticBreathingsService(dio: i.get<Dio>())),
    Bind.lazySingleton((i) => DiaphragmaticBreathingsStore(
        diaphragmaticBreathingsService:
            i.get<DiaphragmaticBreathingsService>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const DiaphragmaticBreathingsPage()),
  ];
}
