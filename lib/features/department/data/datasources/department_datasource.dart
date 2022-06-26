import '../../domain/entities/department.dart';
import '../models/department_model.dart';

abstract class DepartmentDataSource {
  Future<List<Department>> getDepartments({Department? filter});
  Future<Department> insertDepartment({required DepartmentModel department});
  Future<Department> updateDepartment({required DepartmentModel department});
  Future<bool> deleteDepartment({required Department department});
}
