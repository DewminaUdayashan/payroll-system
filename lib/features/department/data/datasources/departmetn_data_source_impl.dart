import 'dart:convert';

import 'package:payroll_system/features/department/data/models/department_model.dart';
import 'package:payroll_system/features/department/domain/entities/department.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api.dart';
import 'department_datasource.dart';

class DepartmentDataSourceImpl extends DepartmentDataSource {
  @override
  Future<List<Department>> getDepartments({Department? filter}) async {
    if (filter != null) throw UnimplementedError();
    final response = await API.get(endPoint: 'departments');
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']
          .map((e) => DepartmentModel.fromMap(e))
          .toList()
          .right();
    } else {
      final decoded = jsonDecode(response.body);
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
  Future<Department> insertDepartment({required DepartmentModel department}) {
    throw UnimplementedError();
  }

  @override
  Future<Department> updateDepartment({required DepartmentModel department}) {
    throw UnimplementedError();
  }
}
