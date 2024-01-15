class CustomException implements Exception {
  final String? _message;
  final String? _prefix;

  CustomException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class DetailsNotFoundException extends CustomException {
  DetailsNotFoundException([String? message]) : super(message, "Not Found: ");
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message, "Error During Communication: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}
