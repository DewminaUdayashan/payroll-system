import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll_system/features/employees/presentation/widgets/employee_data_title_bar.dart';

const epfNoFlex = 1;
const epfNameFlex = 3;
const epfAmountFlex = 2;
const epfDateFlex = 2;

class EpfTitleBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16),
      child: Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              ListTitle(
                name: 'EPF Number',
                textAlign: TextAlign.center,
                flex: epfNoFlex,
              ),
              ListTitle(
                name: 'Employee',
                textAlign: TextAlign.center,
                flex: epfNameFlex,
              ),
              ListTitle(
                name: 'Total in Account',
                textAlign: TextAlign.center,
                flex: epfAmountFlex,
              ),
              ListTitle(
                name: 'Last Update',
                textAlign: TextAlign.center,
                flex: epfDateFlex,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 70.h;

  @override
  double get minExtent => 70.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
