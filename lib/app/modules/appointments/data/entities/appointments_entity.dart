class AppointmentsEntity {
  int id;
  int kid;
  String doctor;
  String date;
  String status;
  int score;
  int diaphragmaticBreathingsMade;
  String createdAt;
  String updatedAt;

  AppointmentsEntity({
    required this.id,
    required this.kid,
    required this.doctor,
    required this.date,
    required this.status,
    required this.score,
    required this.diaphragmaticBreathingsMade,
    required this.createdAt,
    required this.updatedAt,
  });
}
