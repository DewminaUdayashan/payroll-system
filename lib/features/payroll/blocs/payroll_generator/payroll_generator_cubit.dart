import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/core/network/api.dart';
import 'package:payroll_system/features/addition/domain/addition.dart';
import 'package:payroll_system/features/payroll/entities/eligible_employee.dart';
import 'package:payroll_system/features/payroll/entities/payroll_data.dart';

part 'payroll_generator_state.dart';

class PayrollGeneratorCubit extends Cubit<PayrollGeneratorState> {
  PayrollGeneratorCubit() : super(const PayrollGeneratorState());

  void onEmployeeSelected(bool? isExpanded, EligibleEmployee emp) {
    if (isExpanded != null && isExpanded) {
      emit(PayrollGeneratorState(eligibleEmployee: emp));
      getAdditionsForEmployee(emp);
    } else {
      emit(const PayrollGeneratorState());
    }
  }

  void selectIndeX(int index, bool isExpanded) {
    if (isExpanded) {
      emit(state.copyWith(selectedIndex: index));
    } else {
      emit(state.copyWith(selectedIndex: null));
    }
  }

  Future<void> getAdditionsForEmployee(EligibleEmployee emp) async {
    final response = await API.get(endPoint: 'additions/${emp.id}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List<dynamic> data = decoded['data'];
      final additions = data.map((e) => Addition.fromMap(e)).toList();
      emit(state.copyWith(
        additions: additions.where((element) => !element.isDeduction).toList(),
        deductions: additions.where((element) => element.isDeduction).toList(),
      ));
    }
  }

  void onDeductionToggle(int index, bool value) {
    final currentState = state;
    final deductionForChange = state.deductions?[index];
    deductionForChange?.selectedForPayroll = value;
    deductionForChange?.isMonthly = true;
    currentState.deductions?.removeAt(index);
    currentState.deductions?.insert(index, deductionForChange!);
    emit(const PayrollGeneratorState().copyWith(
      additions: currentState.additions,
      deductions: currentState.deductions,
      eligibleEmployee: currentState.eligibleEmployee,
      selectedIndex: currentState.selectedIndex,
    ));
  }

  void onAdditionToggle(int index, bool value) {
    final currentState = state;
    final additionForChange = state.additions?[index];
    additionForChange?.selectedForPayroll = value;
    additionForChange?.isMonthly = true;
    currentState.additions?.removeAt(index);
    currentState.additions?.insert(index, additionForChange!);
    emit(const PayrollGeneratorState().copyWith(
      additions: currentState.additions,
      deductions: currentState.deductions,
      eligibleEmployee: currentState.eligibleEmployee,
      selectedIndex: currentState.selectedIndex,
    ));
  }

  void setFinalData(PayrollData payrollData) {
    emit(state.copyWith(payrollData: payrollData));
  }
}
