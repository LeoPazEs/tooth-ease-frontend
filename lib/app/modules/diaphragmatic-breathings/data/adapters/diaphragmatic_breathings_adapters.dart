import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/entities/diaphragmatic_breathings_entity.dart';

class DiaphragmaticBreathingsAdapters {
  DiaphragmaticBreathingsAdapters._();

  static DiaphragmaticBreathingsEntity fromJson(dynamic json) =>
      DiaphragmaticBreathingsEntity(
        date: json['date'],
        id: json['id'],
        idAppointment: json['appointment'],
      );
}
