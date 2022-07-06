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
      final List<dynamic> addresses = decoded['addresses'];
      return data.map((e) {
        final model = EmployeeModel.fromMap(e);
        final addressLines = addresses
            .where((element) => element['employee_id'] == model.id)
            .toList()
            .reversed
            .toList();
        for (int i = 0; i < addressLines.length; i++) {
          switch (i) {
            case 0:
              model.addressLine1 = addressLines[i]['address_line'];
              break;
            case 1:
              model.addressLine2 = addressLines[i]['address_line'];
              break;
            case 2:
              model.addressLine3 = addressLines[i]['address_line'];
              break;
            default:
              break;
          }
        }
        return model;
      }).toList();
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
  Future<bool> updateEmployee(EmployeeModel employee) async {
    final response = await API.post(
        endPoint: 'employees/update', data: employee.toMapUpdate());
    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      throw FetchFailed(code: response.statusCode, message: decoded.toString());
    } else {
      throw ServerException(
          code: response.statusCode, message: decoded.toString());
    }
  }
}
