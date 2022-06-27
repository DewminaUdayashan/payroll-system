import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/credentials.dart';
import '../entities/system_user.dart';

abstract class LoginRepository {
  Future<Either<Failure, SystemUser>> login(Credentials credentials);
}
