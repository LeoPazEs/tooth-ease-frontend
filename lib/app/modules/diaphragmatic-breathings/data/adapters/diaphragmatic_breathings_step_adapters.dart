import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/entities/diaphragmatic_breathings_step_entity.dart';

class DiaphragmaticBreathingsStepAdapters {
  DiaphragmaticBreathingsStepAdapters._();

  static DiaphragmaticBreathingsStepEntity fromJson(dynamic json) =>
      DiaphragmaticBreathingsStepEntity(
        step: json['step'].toString(),
        id: json['íd'].toString(),
        image: json['image'],
      );
}
