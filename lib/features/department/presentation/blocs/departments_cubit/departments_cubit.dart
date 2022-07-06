import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/core/error/failure.dart';
import 'package:payroll_system/core/shared/dialogs.dart';
import 'package:payroll_system/core/shared/notification_helper.dart';
import 'package:payroll_system/features/department/data/models/department_model.dart';
import 'package:payroll_system/features/department/domain/usecase/departments.dart';

import '../../../domain/entities/department.dart';

part 'departments_state.dart';

class DepartmentsCubit extends Cubit<DepartmentsState> {
  DepartmentsCubit(this._departments) : super(DepartmentsLoading());
  final Departments _departments;

  final List<Department> departmentsTmp = <Department>[];

  void getDepartments({
    Department? department,
  }) async {
    departmentsTmp.clear();
    emit(DepartmentsLoading());
    try {
      final departments = await _departments(department);
      departments.fold(
        (failure) {
          if (failure is FetchFaiure) {
            emit(DepartmentsError(message: failure.message));
          } else if (failure is ApiFailure) {
            emit(DepartmentsError(message: failure.message));
          } else {
            emit(const DepartmentsError(message: 'Something went wrong...'));
          }
        },
        (departmentsRes) {
          departmentsTmp.addAll(departmentsRes);
          emit(DepartmentsLoaded(departments: departmentsRes));
        },
      );
    } catch (e) {
      emit(DepartmentsError(message: e.toString()));
    }
  }

  void addDepartmet(DepartmentModel department, BuildContext context) {
    Navigator.pop(context);

    showLoadingDialog(context);
    _departments.insert(department).then(
          (result) => result.fold(
            (failure) {
              Navigator.pop(context);
              if (failure is FetchFaiure) {
                NotificationHelper.error(
                    context: context, subtitle: failure.message);
              } else if (failure is ApiFailure) {
                NotificationHelper.error(
                    context: context, subtitle: failure.message);
              } else {
                NotificationHelper.error(context: context);
              }
            },
            (inserted) {
              Navigator.pop(context);
              NotificationHelper.success(context: context);
              getDepartments();
            },
          ),
        );
  }

  void updateDepartmet(DepartmentModel department, BuildContext context) {
    Navigator.pop(context);
    showLoadingDialog(context);
    _departments.update(department).then(
          (result) => result.fold(
            (failure) {
              Navigator.pop(context);
              if (failure is FetchFaiure) {
                NotificationHelper.error(
                    context: context, subtitle: failure.message);
              } else if (failure is ApiFailure) {
                NotificationHelper.error(
                    context: context, subtitle: failure.message);
              } else {
                NotificationHelper.error(context: context);
              }
            },
            (inserted) {
              Navigator.pop(context);
              NotificationHelper.success(
                  context: context,
                  subtitle: 'Department updated successfully');
              getDepartments();
            },
          ),
        );
  }

  void searchDepartment(String? value) {
    if (value != null && value.length > 1) {
      getDepartments(department: DepartmentModel(name: value.trim()));
    } else {
      getDepartments();
    }
  }

  Future<List<Department>?> getSearchSuggetions(String? str) async {
    if (str != null) {
      try {
        final departments = await _departments(Department(name: str));
        return departments.fold(
          (failure) {
            //todo: handle error
            return null;
          },
          (departments) => departments,
        );
      } catch (e) {
        emit(DepartmentsError(message: e.toString()));
      }
      return null;
    }
    return null;
  }

  String? validateSubmittedDepartment(String? str) {
    if (str == null) return 'Please select a department..';
    if (!departmentsTmp.any((element) => element.name == str)) {
      return 'Please select a department..';
    }
    return null;
  }

  int getDepartmetId(String text) {
    return departmentsTmp.firstWhere((element) => element.name == text).id!;
  }

  String getDepartmentNameById(int? id) {
    try {
      return departmentsTmp.firstWhere((element) => element.id == id).name;
    } catch (e) {
      return 'UNKNOWN ERROR';
    }
  }

  Department? getDepartmentById(int? departmentId) {
    try {
      print(departmentsTmp.firstWhere((element) => element.id == departmentId));
      return departmentsTmp.firstWhere((element) => element.id == departmentId);
    } catch (e) {
      return null;
    }
  }
}
