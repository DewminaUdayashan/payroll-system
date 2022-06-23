import 'package:dartz/dartz.dart';
import 'package:payroll_system/features/login/data/models/system_user_model.dart';

import '../../../../core/error/failure.dart';
import '../entities/credentials.dart';
import '../entities/system_user.dart';

abstract class LoginRepository {
  Future<Either<Failure, SystemUser>> login(Credentials credentials);
}
