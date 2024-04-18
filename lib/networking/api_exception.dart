class ApiException implements Exception {
  final _message;

  ApiException([this._message]);

  @override
  String toString() {
    return '$_message';
  }
}

class FetchDataException extends ApiException {
  FetchDataException([String? super.message]);
}

class BadRequestException extends ApiException {
  BadRequestException([String? super.message]);
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([String? super.message]);
}

class InvalidInputException extends ApiException {
  InvalidInputException([String? super.message]);
}

class AuthenticationException extends ApiException {
  AuthenticationException([String? super.message]);
}
