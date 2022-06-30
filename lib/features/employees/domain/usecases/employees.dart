import 'package:dartz/dartz.dart';
import 'package:payroll_system/core/error/failure.dart';
import 'package:payroll_system/core/usecases/usecase.dart';
import 'package:payroll_system/features/employees/data/models/employee_model.dart';
import 'package:payroll_system/features/employees/domain/entities/employee.dart';
import 'package:payroll_system/features/employees/domain/repositories/employee_repository.dart';

class Employees extends UseCase<List<Employee>, EmployeeModel> {
  Employees(this._repository);
  final EmployeeRepository _repository;

  @override
  Future<Either<Failure, List<Employee>>> call(EmployeeModel? params) {
    return _repository.getEmployees(filter: params);
  }

  Future<Either<Failure, bool>> addEmployee(EmployeeModel employee) {
    return _repository.createEmployee(employee);
  }
}
