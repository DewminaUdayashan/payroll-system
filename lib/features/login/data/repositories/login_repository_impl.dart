import 'package:payroll_system/core/error/exceptions.dart';
import 'package:payroll_system/features/login/data/datasources/login_data_source.dart';
import 'package:payroll_system/features/login/domain/entities/credentials.dart';

import 'package:payroll_system/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/entities/system_user.dart';
import '../../domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDataSource _loginDataSource;

  LoginRepositoryImpl(this._loginDataSource);
  @override
  Future<Either<Failure, SystemUser>> login(Credentials credentials) async {
    try {
      return Right(await _loginDataSource.login(credentials));
    } on LoginFailed catch (e) {
      return Left(LoginFaiure(code: e.code, message: e.message));
    } on ServerException catch (e) {
      return Left(ApiFailure(code: e.code, message: e.message));
    }
  }
}
