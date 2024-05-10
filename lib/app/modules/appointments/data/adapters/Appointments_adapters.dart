import '../entities/appointments_entity.dart';

class AppointmentsAdapter {
  AppointmentsAdapter._();

  static AppointmentsEntity fromJson(dynamic json) => AppointmentsEntity(
        id: json['id'],
        kid: json['kid'],
        doctor: json['doctor'],
        date: json['date'],
        status: json['status'],
        score: json['score'],
        diaphragmaticBreathingsMade: json['diaphragmatic_breathings_made'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );
}
