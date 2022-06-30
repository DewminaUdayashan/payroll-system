import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll_system/features/department/presentation/blocs/designations_cubit/designations_cubit.dart';
import 'package:payroll_system/features/employees/presentation/blocs/employees_cubit/employees_cubit.dart';
import 'package:payroll_system/features/employees/presentation/widgets/employees_title.dart';

import 'employee_data_title_bar.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: EmployeesTitle(),
          floating: true,
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<EmployeesCubit, EmployeesState>(
            builder: (context, state) {
              if (state is EmployeesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is EmployeeError) {
                return Center(
                  child: Text(state.message),
                );
              }
              final currentState = state as EmployeesLoaded;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: currentState.employees.length,
                itemBuilder: (context, index) {
                  final employee = currentState.employees[index];
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ListTile(
                      enableFeedback: true,
                      tileColor: index.isEven
                          ? Theme.of(context).colorScheme.primaryContainer
                          : null,
                      onTap: () {},
                      title: Row(
                        children: [
                          Expanded(
                            flex: idFlex,
                            child: Text(
                              employee.id.toString(),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: nameFlex,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  child: SizedBox(
                                    width: 55.w,
                                    height: 55.w,
                                    child: Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMF7rNYRqdBhKmsTiW0pes2TrBJnzv7zqbjMp9W9J4cX4XK8jSeUmHBgHrgIt9AmANjxk&usqp=CAU',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  context
                                      .read<EmployeesCubit>()
                                      .getFullName(employee),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: departmentFlex,
                            child: Text(
                              context
                                  .read<DesignationsCubit>()
                                  .getDesignationNameById(
                                      employee.designationId),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: contactFlex,
                            child: Text(
                              context
                                  .read<EmployeesCubit>()
                                  .getContactDetails(employee),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: actionFlex,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add_box_rounded),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
