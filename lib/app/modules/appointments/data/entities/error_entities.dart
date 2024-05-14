abstract interface class ErrorAppointments {
  String get detail;
  String get name;
  String get date;
}

class ErrorCreateAppointmentsEntity implements ErrorAppointments {
  final String _detail;
  final List<dynamic> _name;
  final List<dynamic> _date;

  ErrorCreateAppointmentsEntity({
    String? detail,
    List<dynamic>? name,
    List<dynamic>? date,
  })  : _detail = detail ?? "",
        _name = name ?? [],
        _date = date ?? [];

  @override
  String get detail => _detail;

  @override
  String get name => _name.join('. ');

  @override
  String get date => _date.join('. ');
}
