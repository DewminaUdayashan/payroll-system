import 'package:payroll_system/features/login/domain/entities/credentials.dart';
import 'package:payroll_system/features/login/domain/entities/system_user.dart';

abstract class LoginDataSource {
  Future<SystemUser> login(Credentials credentials);
}
