// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payroll_generator_cubit.dart';

class PayrollGeneratorState extends Equatable {
  const PayrollGeneratorState({
    this.eligibleEmployee,
    this.additions,
    this.selectedIndex,
    this.deductions,
    this.payrollData,
  });
  final EligibleEmployee? eligibleEmployee;
  final List<Addition>? additions;
  final List<Addition>? deductions;
  final int? selectedIndex;
  final PayrollData? payrollData;

  @override
  List<Object?> get props => [
        eligibleEmployee,
        additions,
        selectedIndex,
        deductions,
        selectedIndex,
      ];

  @override
  bool get stringify => true;

  PayrollGeneratorState copyWith({
    EligibleEmployee? eligibleEmployee,
    List<Addition>? additions,
    List<Addition>? deductions,
    int? selectedIndex,
    PayrollData? payrollData,
  }) {
    return PayrollGeneratorState(
      eligibleEmployee: eligibleEmployee ?? this.eligibleEmployee,
      additions: additions ?? this.additions,
      deductions: deductions ?? this.deductions,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      payrollData: payrollData ?? this.payrollData,
    );
  }
}