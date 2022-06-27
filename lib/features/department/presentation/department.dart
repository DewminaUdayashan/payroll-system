import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/department/presentation/blocs/department_page_controller_cubit/department_page_controller_cubit.dart';
import 'package:payroll_system/features/department/presentation/designation_page/designation_page.dart';

import 'departments_page/departments_page.dart';
import 'departments_page/widgets/add_department_dialog.dart';

class Department extends StatefulWidget {
  const Department({Key? key}) : super(key: key);

  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: BlocListener<DepartmentPageControllerCubit,
          DepartmentPageControllerState>(
        listener: (context, state) {
          if (state is DepartmentPage) {
            pageController.animateToPage(0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeIn);
          } else {
            pageController.animateToPage(1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeIn);
          }
        },
        child: Stack(
          children: [
            PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              itemCount: 2,
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton.extended(
                onPressed: () => showDialog(
                    context: context,
                    builder: (_) => const AddDepartmentDialog()),
                label: Text(
                  'Add New',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                icon: Icon(
                  Icons.add_rounded,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const pages = [
  DepartmentsPage(),
  DesignationPage(),
];
