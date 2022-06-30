import '../../domain/entities/employee.dart';
import '../models/employee_model.dart';

abstract class EmployeeDataSource {
  Future<List<Employee>> getEmployees({EmployeeModel? filter});
  Future<bool> createEmployee(EmployeeModel employee);
  Future<bool> updateEmployee(EmployeeModel employee);
  Future<bool> deleteEmployee(int id);
}
