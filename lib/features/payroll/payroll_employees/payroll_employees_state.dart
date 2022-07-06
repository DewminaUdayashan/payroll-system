part of 'payroll_employees_cubit.dart';

abstract class PayrollEmployeesState extends Equatable {
  const PayrollEmployeesState();

  @override
  List<Object> get props => [];
}

class PayrollEmployeesInitial extends PayrollEmployeesState {}

class PayrollEmployeesLoading extends PayrollEmployeesState {}

class PayrollEmployeesError extends PayrollEmployeesState {
  final String message;

  const PayrollEmployeesError(this.message);
}

class PayrollEmployeesLoaded extends PayrollEmployeesState {
  final List<EligibleEmployee> employees;

  const PayrollEmployeesLoaded({required this.employees});

  @override
  List<Object> get props => [employees];
}
