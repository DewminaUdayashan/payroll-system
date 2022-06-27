import 'package:dartz/dartz.dart';
import 'package:payroll_system/core/error/failure.dart';
import 'package:payroll_system/core/usecases/usecase.dart';
import 'package:payroll_system/features/department/data/models/department_model.dart';

import '../entities/department.dart';
import '../repositories/department_repository.dart';

class Departments extends UseCase<List<Department>, Department> {
  final DepartmentRepository _departmentRepository;

  Departments(this._departmentRepository);
  @override
  Future<Either<Failure, List<Department>>> call(Department? params) {
    return _departmentRepository.getDepartments(filter: params);
  }

  //insert department
  Future<Either<Failure, bool>> insert(DepartmentModel department) async {
    return await _departmentRepository.insertDepartment(department: department);
  }

  Future<Either<Failure, bool>> update(DepartmentModel department) async {
    return await _departmentRepository.updateDepartment(department: department);
  }
}
