import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/core/shared/notification_helper.dart';
import 'package:payroll_system/features/addition/domain/addition.dart';
import 'package:payroll_system/features/addition/domain/addition_repository.dart';

part 'addition_state.dart';

class AdditionCubit extends Cubit<AdditionState> {
  AdditionCubit(this._repository) : super(AdditionsLoading());
  final AdditionRepository _repository;
  Future<void> addAddition(Addition addition, BuildContext context) async {
    final response = await _repository.addAddition(addition);
    response.fold((l) {
      NotificationHelper.error(
        context: context,
        title: 'Something went wrong..!',
        subtitle: l.toString(),
      );
    }, (r) {
      Navigator.pop(context);
      Navigator.pop(context);
      NotificationHelper.success(context: context, title: 'Addition Added');
    });
  }

  Future<void> getAdditions(int employeeId, BuildContext context) async {
    final response = await _repository.getAdditions(employeeId);
    response.fold((l) {
      NotificationHelper.error(
        context: context,
        title: 'Something went wrong..!',
        subtitle: l.toString(),
      );
      emit(AdditionsError());
    }, (r) {
      emit(AdditionsLoaded(additions: r));
    });
  }
}
