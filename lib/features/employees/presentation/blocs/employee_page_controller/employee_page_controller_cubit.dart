import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'employee_page_controller_state.dart';

class EmployeePageControllerCubit extends Cubit<EmployeePageControllerState> {
  EmployeePageControllerCubit() : super(EmployeePageControllerInitial());
}
