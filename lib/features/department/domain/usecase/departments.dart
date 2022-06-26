import 'package:dartz/dartz.dart';
import 'package:payroll_system/core/error/failure.dart';
import 'package:payroll_system/core/usecases/usecase.dart';

import '../entities/department.dart';
import '../repositories/department_repository.dart';

class Departments extends UseCase<List<Department>, Department> {
  final DepartmentRepository _departmentRepository;

  Departments(this._departmentRepository);
  @override
  Future<Either<Failure, List<Department>>> call(Department params) {
    return _departmentRepository.getDepartments(filter: params);
  }
}
