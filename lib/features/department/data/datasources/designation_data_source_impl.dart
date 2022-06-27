import 'dart:convert';

import 'package:http/http.dart';
import 'package:payroll_system/features/department/data/datasources/designation_data_source.dart';
import 'package:payroll_system/features/department/data/models/designation_model.dart';
import 'package:payroll_system/features/department/domain/entities/designation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api.dart';

class DesignationDatasourceImpl extends DesignationDataSource {
  @override
  Future<List<Designation>> getDesignations({Designation? filter}) async {
    final Response? response;
    if (filter != null) {
      response = await API.get(endPoint: 'designations/like/${filter.name}');
    } else {
      response = await API.get(endPoint: 'designations');
    }
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = decoded['data'];
      return data.map((e) => DesignationModel.fromMap(e)).toList();
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
  Future<bool> deleteDesignation({required Designation designation}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> insertDesignation(
      {required DesignationModel designation}) async {
    final response = await API.post(
        endPoint: 'designations/create', data: designation.toMap());
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 201) {
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

  @override
  Future<bool> updateDesignation(
      {required DesignationModel designation}) async {
    final response = await API.patch(
        endPoint: 'designations/update', data: designation.toMap());
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
