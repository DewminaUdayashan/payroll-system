import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/employees/domain/entities/employee.dart';

part 'employee_page_controller_state.dart';

class EmployeePageControllerCubit extends Cubit<EmployeePageControllerState> {
  EmployeePageControllerCubit() : super(const EmployeePageControllerState(0));

  late Employee employee;

  set currentEmployee(Employee currentEmployee) => employee = currentEmployee;

  void changePAge(int page, {bool isDetailView = false, bool isEdit = false}) {
    emit(EmployeePageControllerState(page,
        isDetailView: isDetailView, isEdit: isEdit));
  }
}
