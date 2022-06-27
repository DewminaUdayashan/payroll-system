import '../../domain/entities/department.dart';
import '../models/department_model.dart';

abstract class DepartmentDataSource {
  Future<List<Department>> getDepartments({Department? filter});
  Future<bool> insertDepartment({required DepartmentModel department});
  Future<bool> updateDepartment({required DepartmentModel department});
  Future<bool> deleteDepartment({required Department department});
}
