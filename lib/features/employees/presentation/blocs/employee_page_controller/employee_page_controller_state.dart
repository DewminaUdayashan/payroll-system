part of 'employee_page_controller_cubit.dart';

class EmployeePageControllerState extends Equatable {
  const EmployeePageControllerState(this.page, {this.isDetailView = false});
  final int page;
  final bool isDetailView;
  @override
  List<Object> get props => [page, isDetailView];
}
