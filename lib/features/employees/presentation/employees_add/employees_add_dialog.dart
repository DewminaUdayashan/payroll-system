import 'package:flutter/material.dart';

class EmployeesAddDialog extends StatelessWidget {
  const EmployeesAddDialog({this.isEditing = false, Key? key})
      : super(key: key);
  final bool isEditing;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(35),
      titlePadding: const EdgeInsets.only(left: 35, top: 35),
      title: Text(
        isEditing ? 'Update Employee' : 'Add Employee',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Employee ID',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
