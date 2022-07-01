import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_page_controller_state.dart';

class EmployeePageControllerCubit extends Cubit<EmployeePageControllerState> {
  EmployeePageControllerCubit() : super(const EmployeePageControllerState(0));

  void changePAge(int page, {bool isDetailView = false}) {
    emit(EmployeePageControllerState(page, isDetailView: isDetailView));
  }
}
