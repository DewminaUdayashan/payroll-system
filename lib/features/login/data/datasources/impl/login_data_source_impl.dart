import 'dart:convert';
import 'dart:html';

import 'package:payroll_system/core/shared/api.dart';
import 'package:payroll_system/features/login/data/models/system_user_model.dart';
import 'package:payroll_system/features/login/domain/entities/credentials.dart';
import '../../../../../core/error/exceptions.dart';
import '../login_data_source.dart';
import 'package:http/http.dart' as http;

class LoginDataSourceImpl implements LoginDataSource {
  @override
  Future<SystemUserModel> login(Credentials credentials) async {
    final http.Response response = await http
        .post(Uri.parse('$authServer/login'), body: credentials.toJson());
    if (response.statusCode == 200) {
      return SystemUserModel.fromMap(jsonDecode(response.body));
    } else {
      throw ServerException(code: response.statusCode, message: response.body);
    }
  }
}
