import 'package:dartz/dartz.dart';
import 'package:payroll_system/features/department/data/models/designation_model.dart';
import 'package:payroll_system/features/department/domain/entities/designation.dart';

import '../../../../core/error/failure.dart';

abstract class DesignationRepository {
  Future<Either<Failure, List<Designation>>> getdesignations(
      {Designation? filter});

  Future<Either<Failure, bool>> insertdesignation(
      {required DesignationModel designation});

  Future<Either<Failure, bool>> updatedesignation(
      {required DesignationModel designation});
}
