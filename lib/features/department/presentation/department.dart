import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/department/presentation/blocs/departments_cubit/departments_cubit.dart';
import 'package:payroll_system/features/department/presentation/widgets/add_department_dialog.dart';
import 'package:payroll_system/features/department/presentation/widgets/departments_list.dart';
import 'package:payroll_system/features/department/presentation/widgets/departmet_title.dart';

class Department extends StatefulWidget {
  const Department({Key? key}) : super(key: key);

  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController();

  @override
  void dispose() {
    scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          PageView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverPersistentHeader(
                        delegate: DepartmentTitleBar(),
                        floating: true,
                      ),
                      SliverToBoxAdapter(
                        child: BlocBuilder<DepartmentsCubit, DepartmentsState>(
                          builder: (context, state) {
                            if (state is DepartmentsLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (state is DepartmentsError) {
                              return Center(
                                child: Text(state.message),
                              );
                            }
                            final currentState = state as DepartmentsLoaded;
                            return DepartmentsList(currentState: currentState);
                          },
                        ),
                      )
                    ],
                  ),
                );
              }),
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
    );
  }
}
