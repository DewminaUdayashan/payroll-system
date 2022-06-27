class ServerException implements Exception {
  final int code;
  final String message;

  ServerException({required this.code, required this.message});
}

class CacheException implements Exception {}

class NotAuthorizedExecption implements Exception {}

class LoginFailed implements Exception {
  final int code;
  final String message;

  LoginFailed({required this.code, required this.message});
}

class FetchFailed implements Exception {
  final int code;
  final String message;

  FetchFailed({required this.code, required this.message});
}
