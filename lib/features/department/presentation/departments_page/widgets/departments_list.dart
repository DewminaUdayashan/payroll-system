import 'package:flutter/material.dart';

import '../../blocs/departments_cubit/departments_cubit.dart';
import 'add_department_dialog.dart';

class DepartmentsList extends StatelessWidget {
  const DepartmentsList({
    Key? key,
    required this.currentState,
  }) : super(key: key);

  final DepartmentsLoaded currentState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: currentState.departments.length,
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
                      child: Text(currentState.departments[index].name),
                    ),
                    const Expanded(
                      child: Text(
                        '0',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        '0.0LKR',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => AddDepartmentDialog(
                                    department: currentState.departments[index],
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
                subtitle:
                    Text(currentState.departments[index].description ?? ''),
              ),
            );
          },
        )
      ],
    );
  }
}
