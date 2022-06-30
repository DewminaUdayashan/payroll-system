import 'package:dartz/dartz.dart';
import 'package:payroll_system/core/error/failure.dart';
import 'package:payroll_system/features/employees/data/datasources/employee_data_source.dart';
import 'package:payroll_system/features/employees/data/models/employee_model.dart';
import 'package:payroll_system/features/employees/domain/entities/employee.dart';
import 'package:payroll_system/features/employees/domain/repositories/employee_repository.dart';

import '../../../../core/error/exceptions.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  EmployeeRepositoryImpl(this._dataSource);
  final EmployeeDataSource _dataSource;

  @override
  Future<Either<Failure, bool>> createEmployee(EmployeeModel employee) async {
    try {
      return Right(await _dataSource.createEmployee(employee));
    } on NotAuthorizedExecption {
      return Left(AuthorizationFailure());
    } catch (e, stack) {
      return Left(
          ApiFailure(code: 400, message: e.toString() + stack.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteEmployee(int id) {
    // TODO: implement deleteEmployee
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Employee>>> getEmployees(
      {EmployeeModel? filter}) async {
    try {
      return Right(await _dataSource.getEmployees(filter: filter));
    } on NotAuthorizedExecption {
      return Left(AuthorizationFailure());
    } catch (e, stack) {
      return Left(
          ApiFailure(code: 400, message: e.toString() + stack.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateEmployee(EmployeeModel employee) {
    // TODO: implement updateEmployee
    throw UnimplementedError();
  }
}
