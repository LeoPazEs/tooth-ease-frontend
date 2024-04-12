abstract interface class ErrorRegister {
  String get detail;
  String get username;
  String get password;
  String get firstName;
  String get lastName;
}

class ErrorRegisterEntity implements ErrorRegister {
  final String _detail;
  final List<dynamic> _username;
  final List<dynamic> _password;
  final List<dynamic> _firstName;
  final List<dynamic> _lastName;

  ErrorRegisterEntity(
      {String? detail,
      List<dynamic>? username,
      List<dynamic>? password,
      List<dynamic>? firstName,
      List<dynamic>? lastName})
      : _detail = detail ?? "",
        _username = username ?? [],
        _password = password ?? [],
        _firstName = firstName ?? [],
        _lastName = lastName ?? [];

  @override
  String get detail => _detail;

  @override
  String get username => _username.join('. ');

  @override
  String get password => _password.join('. ');

  @override
  String get firstName => _firstName.join('. ');

  @override
  String get lastName => _lastName.join('. ');
}
