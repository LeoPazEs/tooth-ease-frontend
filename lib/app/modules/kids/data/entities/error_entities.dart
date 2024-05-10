abstract interface class ErrorKid {
  String get detail;
  String get name;
  String get birthDate;
}

class ErrorCreateKidEntity implements ErrorKid {
  final String _detail;
  final List<dynamic> _name;
  final List<dynamic> _birthDate;

  ErrorCreateKidEntity({
    String? detail,
    List<dynamic>? name,
    List<dynamic>? birthDate,
  })  : _detail = detail ?? "",
        _name = name ?? [],
        _birthDate = birthDate ?? [];

  @override
  String get detail => _detail;

  @override
  String get name => _name.join('. ');

  @override
  String get birthDate => _birthDate.join('. ');
}
