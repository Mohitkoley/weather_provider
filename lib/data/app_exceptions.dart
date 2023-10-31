class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error During communication');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}

class TemporaryUnavailableException extends AppException {
  TemporaryUnavailableException([String? message])
      : super(message, 'Temporary Unavailable');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message, 'Unauthorised request');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid input');
}

class NoInternetException extends AppException {
  NoInternetException([String? message]) : super(message, 'No Internet');
}

class InternalServerException extends AppException {
  InternalServerException([String? message])
      : super(message, 'Internal Server Error');
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message]) : super(message, 'Not Authorized');
}
