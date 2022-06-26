import 'package:flutter/material.dart';
import 'package:payroll_system/features/system/presentation/pages/panel_window/panel_window.dart';
import 'package:payroll_system/features/system/presentation/pages/panel_window/widgets/notification_panel.dart';
import 'package:payroll_system/features/system/presentation/pages/side_panel/side_panel.dart';
import 'package:payroll_system/features/system/presentation/pages/side_panel/widgets/title_bar.dart';

class System extends StatelessWidget {
  const System({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TitleBar(
        child: Row(
          children: [
            const SidePanel(),
            Expanded(
              flex: 9,
              child: Column(
                children: const [
                  NotificationBar(),
                  PanelWindow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
