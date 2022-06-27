import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'department_page_controller_state.dart';

class DepartmentPageControllerCubit
    extends Cubit<DepartmentPageControllerState> {
  DepartmentPageControllerCubit() : super(DepartmentPage());

  void animatePage(int index) {
    if (index == 0) {
      emit(DepartmentPage());
    } else {
      emit(DepartmentDesignationPage());
    }
  }
}
