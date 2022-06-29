import 'package:flutter/material.dart';

import '../../shared/emp_enums.dart';

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
            child: const TextField(
              decoration: InputDecoration(
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
            onPressed: () {},
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
        ],
      ),
    );
  }
}
