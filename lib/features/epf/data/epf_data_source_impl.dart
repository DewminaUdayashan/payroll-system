import 'dart:convert';

import 'package:payroll_system/core/network/api.dart';
import 'package:payroll_system/features/epf/data/epf_data_source.dart';
import 'package:payroll_system/features/epf/data/epf_model.dart';
import 'package:payroll_system/features/epf/domain/epf.dart';

import '../../../core/error/exceptions.dart';

class EPFDataSourceImpl extends EPFDataSource {
  @override
  Future<bool> addEPF(EPFModel epf) async {
    final response = await API.post(endPoint: 'epf/add', data: epf.toMap());
    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 400) {
      throw NotAuthorizedExecption();
    } else {
      throw ServerException(code: response.statusCode, message: response.body);
    }
  }

  @override
  Future<List<EPF>> getEPFs({EPFModel? filter}) async {
    final response = await API.get(endPoint: 'epf');
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = decoded['data'];
      return data.map((e) => EPFModel.fromMap(e)).toList();
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
  Future<bool> updateEPF(EPFModel epf) async {
    final response = await API.patch(endPoint: 'epf/update', data: epf.toMap());
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      throw NotAuthorizedExecption();
    } else {
      throw ServerException(code: response.statusCode, message: response.body);
    }
  }
}
