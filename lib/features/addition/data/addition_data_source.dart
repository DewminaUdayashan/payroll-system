import 'dart:convert';

import 'package:payroll_system/core/error/failure.dart';
import 'package:payroll_system/core/network/api.dart';
import 'package:payroll_system/features/addition/domain/addition.dart';

class AdditionDataSource {
  Future<bool> addAddition(Addition addition) async {
    try {
      final response =
          await API.post(endPoint: 'additions/add', data: addition.toMap());
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 4001) {
        throw AuthorizationFailure();
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ApiFailure(code: 0, message: e.toString());
    }
  }

  Future<List<Addition>> getAddditions(int employeeID) async {
    // try {
    final response = await API.get(endPoint: 'additions/$employeeID');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List<dynamic> data = decoded['data'];
      return data.map((e) => Addition.fromMap(e)).toList();
    } else if (response.statusCode == 4001) {
      throw AuthorizationFailure();
    } else {
      throw ServerFailure();
    }
    // } catch (e) {
    //     throw ApiFailure(code: 0, message: e.toString());
    // }
  }
}
