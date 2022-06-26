import 'dart:convert';

import 'package:payroll_system/core/network/api.dart';
import 'package:payroll_system/features/login/data/models/system_user_model.dart';
import 'package:payroll_system/features/login/domain/entities/credentials.dart';

import '../../../../../core/error/exceptions.dart';
import '../login_data_source.dart';

class LoginDataSourceImpl implements LoginDataSource {
  @override
  Future<SystemUserModel> login(Credentials credentials) async {
    final response = await API.post(
        endPoint: 'authentication/login', data: credentials.toMap());
    if (response.statusCode == 200) {
      return SystemUserModel.fromMap(jsonDecode(response.body)['data']);
    } else {
      final decoded = jsonDecode(response.body);
      if (response.statusCode == 401) {
        throw LoginFailed(code: response.statusCode, message: decoded['data']);
      } else {
        throw ServerException(
            code: response.statusCode, message: decoded['data']);
      }
    }
  }
}
