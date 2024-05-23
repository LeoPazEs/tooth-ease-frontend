import 'package:audioplayers/audioplayers.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/services/audio_players_service.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/interactor/stores/diaphragmatic_breathings_steps_store.dart';
import 'package:dio/dio.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/services/diaphragmatic_breathings_service.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/ui/pages/diaphragmaticBreathings_page.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/interactor/stores/diaphragmaticBreathings_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/ui/pages/diaphragmatic_breathings_steps_page.dart';
import '../shared/secure_storage_service.dart';

class DiaphragmaticBreathingsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AudioPlayerService(player: AudioPlayer())),
    Bind.lazySingleton(
      (i) => DiaphragmaticBreathingsStepsStore(
        diaphragmaticBreathingsService: i.get<DiaphragmaticBreathingsService>(),
        audioPlayerService: i.get<AudioPlayerService>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => DiaphragmaticBreathingsService(
        dio: i.get<Dio>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => DiaphragmaticBreathingsStore(
        diaphragmaticBreathingsService: i.get<DiaphragmaticBreathingsService>(),
        storage: i.get<SecureStorageService>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const DiaphragmaticBreathingsPage()),
    ChildRoute('/steps/',
        child: (_, args) => const DiaphragmaticBreathingsStepsPage()),
  ];
}
