import 'package:flutter/material.dart';

const idFlex = 1;
const nameFlex = 3;
const departmentFlex = 1;
const contactFlex = 3;
const actionFlex = 1;

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
    this.textAlign = TextAlign.center,
    Key? key,
  }) : super(key: key);
  final String name;
  final int flex;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        name,
        textAlign: textAlign,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
