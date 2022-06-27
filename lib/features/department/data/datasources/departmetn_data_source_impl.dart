import 'dart:convert';

import 'package:http/http.dart';
import 'package:payroll_system/features/department/data/models/department_model.dart';
import 'package:payroll_system/features/department/domain/entities/department.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api.dart';
import 'department_datasource.dart';

class DepartmentDataSourceImpl extends DepartmentDataSource {
  @override
  Future<List<DepartmentModel>> getDepartments({Department? filter}) async {
    final Response? response;
    if (filter != null) {
      response = await API.get(endPoint: 'departments/like/${filter.name}');
    } else {
      response = await API.get(endPoint: 'departments');
    }
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = decoded['data'];
      return data.map((e) => DepartmentModel.fromMap(e)).toList();
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
  Future<bool> deleteDepartment({required Department department}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> insertDepartment({required DepartmentModel department}) async {
    final response = await API.post(
        endPoint: 'departments/create', data: department.toMap());
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      if (response.statusCode == 401) {
        throw NotAuthorizedExecption();
      } else {
        throw ServerException(
            code: response.statusCode, message: decoded['data']);
      }
    }
  }

  @override
  Future<bool> updateDepartment({required DepartmentModel department}) async {
    final response = await API.patch(
        endPoint: 'departments/update', data: department.toMap());
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      if (response.statusCode == 401) {
        throw NotAuthorizedExecption();
      } else {
        throw ServerException(
            code: response.statusCode, message: decoded['data'].toString());
      }
    }
  }
}
