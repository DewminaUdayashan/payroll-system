import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/department/presentation/blocs/departments_cubit/departments_cubit.dart';
import 'package:payroll_system/features/department/presentation/blocs/designations_cubit/designations_cubit.dart';
import 'package:payroll_system/features/department/presentation/designation_page/widgets/add_designation_dialog.dart';

class DesignationsList extends StatelessWidget {
  const DesignationsList({
    Key? key,
    required this.currentState,
  }) : super(key: key);

  final DesignationsLoaded currentState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: currentState.designations.length,
          itemBuilder: (context, index) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ListTile(
                mouseCursor: MouseCursor.defer,
                hoverColor: Theme.of(context).colorScheme.secondaryContainer,
                enableFeedback: true,
                autofocus: true,
                onTap: () {},
                title: Row(
                  children: [
                    Expanded(
                      child: Text(currentState.designations[index].name),
                    ),
                    Expanded(
                      child: Text(
                        context.read<DepartmentsCubit>().getDepartmentNameById(
                            currentState.designations[index].departmentId),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        currentState.designations[index].allowance
                            .toStringAsFixed(2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => AddDesignationDialog(
                                    designation:
                                        currentState.designations[index],
                                  ));
                        },
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
