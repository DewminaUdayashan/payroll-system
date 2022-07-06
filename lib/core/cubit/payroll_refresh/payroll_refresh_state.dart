part of 'payroll_refresh_cubit.dart';

class PayrollRefreshState extends Equatable {
  const PayrollRefreshState(this.index);
  final int index;
  @override
  List<Object> get props => [index];
}
