import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll_system/features/system/presentation/pages/side_panel/widgets/logo.dart';

import '../../shared/system_enums.dart';
import 'widgets/tab_button.dart';

class SidePanel extends StatelessWidget {
  const SidePanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Logo(),
            SizedBox(
              height: 45.h,
            ),
            ...SystemTab.values.map((panel) => TabButton(tab: panel)).toList(),
          ],
        ),
      ),
    );
  }
}
