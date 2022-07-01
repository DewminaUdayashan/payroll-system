import 'package:flutter/material.dart';

const idFlex = 1;
const nameFlex = 3;
const departmentFlex = 1;
const contactFlex = 3;
const actionFlex = 2;

class EmployeeDataTitleBar extends StatelessWidget {
  const EmployeeDataTitleBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        ListTitle(
          name: 'ID',
          flex: idFlex,
        ),
        ListTitle(
          name: 'Name',
          flex: nameFlex,
        ),
        ListTitle(
          name: 'Department',
          flex: departmentFlex,
        ),
        ListTitle(
          name: 'Contact',
          flex: contactFlex,
        ),
        ListTitle(
          name: 'Actions',
          flex: actionFlex,
        ),
      ],
    );
  }
}

class ListTitle extends StatelessWidget {
  const ListTitle({
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
