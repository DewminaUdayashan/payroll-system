import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/employees/shared/emp_enums.dart';

part 'gender_radio_state.dart';

class GenderRadioCubit extends Cubit<GenderRadioState> {
  GenderRadioCubit() : super(const GenderRadioState());

  void changeGender(Gender? gender) {
    if (gender == null) {
      return;
    }
    emit(GenderRadioState(gender: gender));
  }
}
