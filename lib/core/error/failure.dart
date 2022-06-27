import 'package:equatable/equatable.dart';

/// repos catch [exceptions] and transform them into [Failure]
abstract class Failure extends Equatable {}

//general failures
class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ApiFailure extends Failure {
  final int code;
  final String message;

  ApiFailure({required this.code, required this.message});
  @override
  List<Object?> get props => [code, message];
}

class AuthorizationFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class LoginFaiure extends Failure {
  final int code;
  final String message;

  LoginFaiure({required this.code, required this.message});
  @override
  List<Object?> get props => [code, message];
}

class FetchFaiure extends Failure {
  final int code;
  final String message;

  FetchFaiure({required this.code, required this.message});
  @override
  List<Object?> get props => [code, message];
}
