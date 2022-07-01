import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/employees/presentation/blocs/employees_cubit/employees_cubit.dart';
import 'package:payroll_system/features/employees/presentation/blocs/gender_radio/gender_radio_cubit.dart';

import '../../shared/emp_enums.dart';
import '../employees_add/employees_add_dialog.dart';

class EmployeesActionBar extends StatelessWidget {
  const EmployeesActionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            child: TextField(
              onChanged: context.read<EmployeesCubit>().seachEmployee,
              decoration: const InputDecoration(
                labelText: 'Search Employees',
                hintText: 'Search Employees',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 26),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: DropdownButton<EmployeeStatus>(
              value: EmployeeStatus.all,
              enableFeedback: true,
              underline: const SizedBox.shrink(),
              focusColor: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0),
              items: EmployeeStatus.values
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(status.name),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              context.read<GenderRadioCubit>().changeGender(Gender.notSelected);
              showDialog(
                context: context,
                builder: (_) => const EmployeesAddDialog(),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(.1),
              enableFeedback: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text('Add Employee'),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(.1),
              enableFeedback: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text('Import Employees'),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(.1),
              enableFeedback: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text('EPF'),
          ),
        ],
      ),
    );
  }
}
