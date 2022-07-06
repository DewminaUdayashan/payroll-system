import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/core/network/api.dart';
import 'package:payroll_system/features/department/domain/entities/department.dart';
import 'package:payroll_system/features/payroll/entities/eligible_employee.dart';

part 'payroll_employees_state.dart';

class PayrollEmployeesCubit extends Cubit<PayrollEmployeesState> {
  PayrollEmployeesCubit() : super(PayrollEmployeesInitial());

  Future<void> fetchEligibleEmployees(Department department, int month) async {
    emit(PayrollEmployeesLoading());
    final response =
        await API.post(endPoint: 'employees/eligible_for_payment', data: {
      'departmentId': department.id,
      'month': month.toString(),
      'year': DateTime.now().year.toString(),
    });
    final data = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      final employees =
          (data as List).map((e) => EligibleEmployee.fromMap(e)).toList();
      emit(PayrollEmployeesLoaded(employees: employees));
    } else {
      emit(PayrollEmployeesError(response.body.toString()));
    }
  }
}
