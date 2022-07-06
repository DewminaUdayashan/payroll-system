import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  Salary getBasicSalary({double? allowance, required double workDays}) {
    final dayPayment = (allowance ?? 0) / 30;
    if (workDays > state.daysToCalculate) {
      return Salary(
        basic: dayPayment * state.daysToCalculate,
        allowance: dayPayment * (workDays - state.daysToCalculate),
      );
    }
    return Salary(
      basic: dayPayment * workDays,
      allowance: 0,
    );
  }

  double epfForBasicSalary(double basic) {
    //get 8% precentage from basic
    final epf = basic * state.epfRate / 100;
    return epf;
  }

  double comContEPF(double basic) {
    //get 12% precentage from basic
    final epf = basic * state.comContEpfRate / 100;
    return epf;
  }

  double etf(double basic) {
    //get 3% precentage from basic
    final epf = basic * state.etfRate / 100;
    return epf;
  }
}

class Salary {
  final double basic;
  final double allowance;

  Salary({required this.basic, required this.allowance});
}
