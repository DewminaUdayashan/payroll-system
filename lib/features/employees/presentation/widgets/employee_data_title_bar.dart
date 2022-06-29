import 'package:flutter/material.dart';

const idFlex = 1;
const nameFlex = 3;
const departmentFlex = 2;
const contactFlex = 3;
const actionFlex = 2;

class EmployeeDataTitleBar extends StatelessWidget {
  const EmployeeDataTitleBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        EmployeeListTitle(
          name: 'ID',
          flex: idFlex,
        ),
        EmployeeListTitle(
          name: 'Name',
          flex: nameFlex,
        ),
        EmployeeListTitle(
          name: 'Department',
          flex: departmentFlex,
        ),
        EmployeeListTitle(
          name: 'Contact',
          flex: contactFlex,
        ),
        EmployeeListTitle(
          name: 'Actions',
          flex: actionFlex,
        ),
      ],
    );
  }
}

class EmployeeListTitle extends StatelessWidget {
  const EmployeeListTitle({
    required this.name,
    required this.flex,
    Key? key,
  }) : super(key: key);
  final String name;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
