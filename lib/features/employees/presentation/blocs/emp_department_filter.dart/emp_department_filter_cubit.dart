import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/department/domain/entities/department.dart';
import 'package:payroll_system/features/department/domain/entities/designation.dart';

part 'emp_department_filter_state.dart';

class EmpDepartmentFilterCubit extends Cubit<EmpDepartmentFilterState> {
  EmpDepartmentFilterCubit() : super(const EmpDepartmentFilterState());

  void onDepartmentChanged(Department? value) {
    emit(EmpDepartmentFilterState(department: value));
  }

  void onDesignationChanged(Designation? value) {
    emit(EmpDepartmentFilterState(
        department: state.department, designation: value));
  }

  bool validateSelections() {
    bool valid = true;
    if (state.department == null || (state.department?.name == 'Select')) {
      emit(state.copyWith(departmentNotSelected: true));
      valid = false;
    } else {
      emit(state.copyWith(departmentNotSelected: false));
    }
    if (state.designation == null || (state.designation?.name == 'Select')) {
      emit(state.copyWith(designationNotSelected: true));
      valid = false;
    } else {
      emit(state.copyWith(designationNotSelected: false));
    }
    return valid;
  }
}
