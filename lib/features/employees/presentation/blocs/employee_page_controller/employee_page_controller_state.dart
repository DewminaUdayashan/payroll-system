part of 'employee_page_controller_cubit.dart';

class EmployeePageControllerState extends Equatable {
  const EmployeePageControllerState(this.page,
      {this.isDetailView = false, this.isEdit = false});
  final int page;
  final bool isDetailView;
  final bool isEdit;
  @override
  List<Object> get props => [page, isDetailView, isEdit];
}
