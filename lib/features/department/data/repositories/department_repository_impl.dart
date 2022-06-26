import 'package:dartz/dartz.dart';
import 'package:payroll_system/core/error/exceptions.dart';
import 'package:payroll_system/core/error/failure.dart';
import 'package:payroll_system/features/department/data/datasources/department_datasource.dart';
import 'package:payroll_system/features/department/data/models/department_model.dart';
import 'package:payroll_system/features/department/domain/repositories/department_repository.dart';

import '../../domain/entities/department.dart';

class DepartmentRepositoryImpl extends DepartmentRepository {
  DepartmentRepositoryImpl(this._departmentDataSource);
  final DepartmentDataSource _departmentDataSource;

  @override
  Future<Either<Failure, List<Department>>> getDepartments(
      {Department? filter}) async {
    try {
      return Right(await _departmentDataSource.getDepartments(filter: filter));
    } on FetchFailed catch (e) {
      return Left(FetchFaiure(code: e.code, message: e.message));
    } on ServerException catch (e) {
      return Left(ApiFailure(code: e.code, message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteDepartment(
      {required Department department}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Department>> insertDepartment(
      {required DepartmentModel department}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Department>> updateDepartment(
      {required DepartmentModel department}) {
    throw UnimplementedError();
  }
}
