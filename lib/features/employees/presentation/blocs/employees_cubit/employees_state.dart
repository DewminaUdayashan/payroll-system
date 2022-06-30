part of 'employees_cubit.dart';

abstract class EmployeesState extends Equatable {
  const EmployeesState();

  @override
  List<Object?> get props => [];
}

class EmployeesLoading extends EmployeesState {}

class EmployeesLoaded extends EmployeesState {
  final List<Employee> employees;

  const EmployeesLoaded({required this.employees});
  @override
  List<Object> get props => [employees];
}

class EmployeeError extends EmployeesState {
  final String? code;
  final String message;

  const EmployeeError({this.code, required this.message});

  @override
  List<Object?> get props => [code, message];
}
