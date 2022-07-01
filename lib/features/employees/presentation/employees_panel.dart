import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/employees/presentation/blocs/employee_page_controller/employee_page_controller_cubit.dart';
import 'package:payroll_system/features/employees/presentation/widgets/employee_list_page.dart';
import 'package:payroll_system/features/epf/presentation/epf_page.dart';

class EmployeesPanel extends StatefulWidget {
  const EmployeesPanel({Key? key}) : super(key: key);

  @override
  State<EmployeesPanel> createState() => _EmployeesPanelState();
}

class _EmployeesPanelState extends State<EmployeesPanel> {
  final pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeePageControllerCubit,
        EmployeePageControllerState>(
      listener: (context, state) {
        if (state.page == 0) {
          pageController.animateToPage(0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn);
        } else {
          pageController.animateToPage(1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn);
        }
      },
      builder: (context, state) {
        return PageView.builder(
            controller: pageController,
            itemCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index == 0) {
                return const EmployeeListPage();
              } else {
                return EPFPage(isDetailView: state.isDetailView);
              }
            });
      },
    );
  }
}
