abstract interface class ErrorLogin {
  String get detail;
}

class ErrorLoginEntity implements ErrorLogin {
  final String _detail;

  ErrorLoginEntity({required String detail}) : _detail = detail;

  @override
  String get detail => _detail;
}
