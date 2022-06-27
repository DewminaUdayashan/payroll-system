import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'department_search_field.dart';

class DepartmentTitleBar extends SliverPersistentHeaderDelegate {
  DepartmentTitleBar({this.isDesignationView = false});
  final bool isDesignationView;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 100.h,
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          DepartmentSearchField(isDesignationView: isDesignationView),
          Row(
            children: [
              DepartmentTitle(
                  title: isDesignationView ? 'Designation' : 'Department'),
              DepartmentTitle(
                  title: isDesignationView ? 'Department' : 'Employees'),
              DepartmentTitle(
                  title: isDesignationView ? 'Allowance' : 'Avarage Salary'),
              DepartmentTitle(title: isDesignationView ? 'Actions' : 'Actions'),
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 100.h;

  @override
  double get minExtent => 100.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class DepartmentTitle extends StatelessWidget {
  const DepartmentTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSecondary),
      ),
    );
  }
}
