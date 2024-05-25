import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/data/entities/diaphragmatic_breathings_entity.dart';

class DiaphragmaticBreathingsAdapters {
  DiaphragmaticBreathingsAdapters._();

  static DiaphragmaticBreathingsEntity fromJson(dynamic json) =>
      DiaphragmaticBreathingsEntity(
        date: json['date'].toString(),
        id: json['id'].toString(),
        idAppointment: json['appointment'].toString(),
      );
}
