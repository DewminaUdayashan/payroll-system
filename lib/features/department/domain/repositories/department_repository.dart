import 'package:dartz/dartz.dart';
import 'package:payroll_system/features/department/data/models/department_model.dart';

import '../../../../core/error/failure.dart';
import '../entities/department.dart';

abstract class DepartmentRepository {
  Future<Either<Failure, List<Department>>> getDepartments(
      {Department? filter});

  Future<Either<Failure, bool>> insertDepartment(
      {required DepartmentModel department});

  Future<Either<Failure, bool>> updateDepartment(
      {required DepartmentModel department});

  Future<Either<Failure, bool>> deleteDepartment(
      {required Department department});
}
