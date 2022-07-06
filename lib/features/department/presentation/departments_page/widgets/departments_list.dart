import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:payroll_system/core/network/api.dart';

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
            final department = currentState.departments[index];

            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ListTile(
                tileColor: index.isEven
                    ? Theme.of(context).colorScheme.primaryContainer
                    : null,
                mouseCursor: MouseCursor.defer,
                hoverColor: Theme.of(context).colorScheme.secondaryContainer,
                enableFeedback: true,
                onTap: () {},
                title: Row(
                  children: [
                    Expanded(
                      child: Text(department.name),
                    ),
                    const Expanded(
                      child: Text(
                        '0',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    AVGText(department.id!),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AddDepartmentDialog(
                              department: department,
                            ),
                          );
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
                subtitle: Text(
                  department.description ?? '',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

class AVGText extends StatefulWidget {
  const AVGText(this.departmentId, {Key? key}) : super(key: key);
  final int departmentId;

  @override
  State<AVGText> createState() => _AVGTextState();
}

class _AVGTextState extends State<AVGText> {
  String avg = '-';

  @override
  void initState() {
    super.initState();
    getAverageAllowanceForDepartment(widget.departmentId);
  }

  Future<void> getAverageAllowanceForDepartment(int departmentId) async {
    final response = await API.get(endPoint: 'departments/avg/$departmentId');
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body)['data'] as List<dynamic>;
      if (list.isNotEmpty) {
        avg = '${list.first['AVG_ALLOWANCE']}LKR';
      }
    } else {
      avg = '-';
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        avg,
        textAlign: TextAlign.center,
      ),
    );
  }
}
