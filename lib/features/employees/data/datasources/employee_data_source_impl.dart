import 'dart:convert';

import 'package:http/http.dart';
import 'package:payroll_system/features/employees/data/datasources/employee_data_source.dart';
import 'package:payroll_system/features/employees/data/models/employee_model.dart';
import 'package:payroll_system/features/employees/domain/entities/employee.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api.dart';

class EmployeeDataSourceImpl extends EmployeeDataSource {
  @override
  Future<List<Employee>> getEmployees({EmployeeModel? filter}) async {
    final Response? response;
    if (filter != null) {
      response =
          await API.post(endPoint: 'employees/search', data: filter.toMap());
    } else {
      response = await API.get(endPoint: 'employees/1');
    }
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = decoded['data'];
      return data.map((e) => EmployeeModel.fromMap(e)).toList();
    } else {
      if (response.statusCode == 401) {
        throw FetchFailed(code: response.statusCode, message: decoded['data']);
      } else {
        throw ServerException(
            code: response.statusCode, message: decoded['data']);
      }
    }
  }

  @override
  Future<bool> createEmployee(EmployeeModel employee) async {
    final response =
        await API.post(endPoint: 'employees/create', data: employee.toMap());
    final decoded = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 400) {
      throw FetchFailed(code: response.statusCode, message: decoded.toString());
    } else {
      throw ServerException(
          code: response.statusCode, message: decoded.toString());
    }
  }

  @override
  Future<bool> deleteEmployee(int id) {
    // TODO: implement deleteEmployee
    throw UnimplementedError();
  }

  @override
  Future<bool> updateEmployee(EmployeeModel employee) {
    // TODO: implement updateEmployee
    throw UnimplementedError();
  }
}
