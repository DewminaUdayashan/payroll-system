import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payroll_refresh_state.dart';

class PayrollRefreshCubit extends Cubit<PayrollRefreshState> {
  PayrollRefreshCubit() : super(const PayrollRefreshState(0));

  void refresh() => emit(PayrollRefreshState((state.index + 1)));
}
