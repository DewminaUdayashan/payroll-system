import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/addition/presentation/shared/addition_enums.dart';

part 'addition_type_state.dart';

class AdditionTypeCubit extends Cubit<AdditionTypeState> {
  AdditionTypeCubit() : super(const AdditionTypeState());

  void onTypeChanged(AdditionType? type) => emit(AdditionTypeState(type: type));
}
