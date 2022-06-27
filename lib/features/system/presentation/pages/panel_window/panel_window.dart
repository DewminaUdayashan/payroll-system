import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/system/presentation/blocs/system_tab/system_tab_cubit.dart';
import 'package:payroll_system/features/system/presentation/shared/system_enums.dart';

class PanelWindow extends StatefulWidget {
  const PanelWindow({
    Key? key,
  }) : super(key: key);

  @override
  State<PanelWindow> createState() => _PanelWindowState();
}

class _PanelWindowState extends State<PanelWindow> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<SystemTabCubit, SystemTabState>(
        listener: (context, state) {
          pageController.animateToPage(
            SystemTab.values.indexOf(state.selectedTab),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeIn,
          );
        },
        builder: (context, state) {
          return Container(
            color: Theme.of(context)
                .colorScheme
                .secondaryContainer
                .withOpacity(.1),
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              scrollDirection: Axis.vertical,
              itemCount: SystemTab.values.length,
              itemBuilder: (context, index) {
                return context.read<SystemTabCubit>().panels[index];
              },
            ),
          );
        },
      ),
    );
  }
}
