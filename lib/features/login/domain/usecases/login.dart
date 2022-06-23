import 'package:payroll_system/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:payroll_system/core/usecases/usecase.dart';
import 'package:payroll_system/features/login/domain/entities/credentials.dart';
import 'package:payroll_system/features/login/domain/entities/system_user.dart';
import 'package:payroll_system/features/login/domain/repositories/login_repository.dart';

class Login extends UseCase<SystemUser, Credentials> {
  final LoginRepository _loginRepository;

  Login(this._loginRepository);

  @override
  Future<Either<Failure, SystemUser>> call(Credentials params) {
    return _loginRepository.login(params);
  }
}
