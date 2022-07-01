import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/core/shared/notification_helper.dart';
import 'package:payroll_system/features/employees/data/models/employee_model.dart';
import 'package:payroll_system/features/employees/domain/entities/employee.dart';
import 'package:payroll_system/features/employees/domain/usecases/employees.dart';
import 'package:payroll_system/features/employees/shared/emp_enums.dart';

import '../../../../../core/error/failure.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  EmployeesCubit(this._employees) : super(EmployeesLoading());
  final Employees _employees;

  Future<void> loadEmployees({EmployeeModel? filter}) async {
    emit(EmployeesLoading());
    try {
      final results = await _employees(filter);
      results.fold(
        (failure) {
          if (failure is FetchFaiure) {
            emit(EmployeeError(message: failure.message));
          } else if (failure is ApiFailure) {
            emit(EmployeeError(message: failure.message));
          } else {
            emit(const EmployeeError(message: 'Something went wrong...'));
          }
        },
        (employeeRes) {
          emit(EmployeesLoaded(employees: employeeRes));
        },
      );
    } catch (e) {
      emit(EmployeeError(message: e.toString()));
    }
  }

  Future<void> addEMployee(EmployeeModel employee, BuildContext context) async {
    try {
      final results = await _employees.addEmployee(employee);
      results.fold(
        (failure) {
          if (failure is AuthorizationFailure) {
            NotificationHelper.error(
                context: context, subtitle: 'Authorization failed');
          } else if (failure is ApiFailure) {
            NotificationHelper.error(
                context: context, subtitle: failure.message);
          } else {
            NotificationHelper.error(context: context);
          }
        },
        (added) {
          loadEmployees();
          Navigator.pop(context);
          NotificationHelper.success(
              context: context, subtitle: 'Employee added');
        },
      );
    } catch (e) {
      NotificationHelper.error(context: context, subtitle: e.toString());
    }
  }

  String getContactDetails(Employee employee) {
    String contactDetails = '';
    contactDetails += employee.mobile1;
    if (employee.mobile2 != null) {
      contactDetails += ' / ${employee.mobile2!}';
    }
    if (employee.email != null) {
      contactDetails += '\n${employee.email!}';
    }
    return contactDetails;
  }

  String getFullName(Employee employee) {
    String fullName = '';
    fullName += '${employee.surename} ${employee.firstName}';
    if (employee.lastName != null) {
      fullName += ' ${employee.lastName!}';
    }
    return fullName;
  }

  void seachEmployee(String query) {
    loadEmployees(
      filter: EmployeeModel(
          designationId: 0,
          surename: query,
          firstName: query,
          nic: query,
          dateOfBirth: DateTime.now(),
          gender: Gender.male,
          mobile1: '',
          joinedDate: DateTime.now()),
    );
  }

  String getEmployeeNameNicByID(int employeeId) {
    String details = '';

    if (state is EmployeesLoaded) {
      final currentState = state as EmployeesLoaded;
      final employee = currentState.employees
          .firstWhere((element) => element.id == employeeId);
      details += employee.firstName;
      details += ' - ${employee.nic}';
    }
    return details;
  }

  String getEmployeeNameNicByEPFNo(int epfNo) {
    String details = '';
    if (state is EmployeesLoaded) {
      final currentState = state as EmployeesLoaded;
      final employee = currentState.employees
          .firstWhere((element) => element.epfNumber == epfNo);
      details += employee.firstName;
      details += ' - ${employee.nic}';
    }
    return details;
  }
}
