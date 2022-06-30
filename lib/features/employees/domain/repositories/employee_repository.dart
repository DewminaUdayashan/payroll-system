import 'package:dartz/dartz.dart';
import 'package:payroll_system/features/employees/data/models/employee_model.dart';

import '../../../../core/error/failure.dart';
import '../entities/employee.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<Employee>>> getEmployees({EmployeeModel? filter});
  Future<Either<Failure, bool>> createEmployee(EmployeeModel employee);
  Future<Either<Failure, bool>> updateEmployee(EmployeeModel employee);
  Future<Either<Failure, bool>> deleteEmployee(int id);
}
