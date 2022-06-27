import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll_system/features/department/presentation/blocs/departments_cubit/departments_cubit.dart';
import 'package:payroll_system/features/department/presentation/blocs/designations_cubit/designations_cubit.dart';
import 'package:payroll_system/features/system/presentation/blocs/system_tab/system_tab_cubit.dart';
import 'package:payroll_system/features/system/presentation/shared/system_enums.dart';

import '../../../../../department/presentation/blocs/department_page_controller_cubit/department_page_controller_cubit.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    Key? key,
    required this.tab,
  }) : super(key: key);
  final SystemTab tab;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemTabCubit, SystemTabState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () {
                    context.read<SystemTabCubit>().onTabChanged(tab);

                    /// initially, the department loads first page on its `PageView`.
                    /// we animate page only if it is alredy navigated to the second page

                    if (tab == SystemTab.departments) {
                      /// fetch when the tab is clicked
                      context.read<DepartmentsCubit>().getDepartments();
                      context
                          .read<DepartmentPageControllerCubit>()
                          .animatePage(0);
                    }
                  },
                  hoverColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Ink(
                    color: state.selectedTab == tab
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Icon(
                                tab.icon,
                                color: state.selectedTab == tab
                                    ? Colors.black87
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                tab.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: state.selectedTab == tab
                                            ? Colors.black87
                                            : Colors.grey),
                              )
                            ],
                          ),
                          if (state.selectedTab == SystemTab.departments &&
                              tab == SystemTab.departments) ...[
                            const Divider(),
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  onTap: () {
                                    context
                                        .read<DesignationsCubit>()
                                        .getDesignations();
                                    context
                                        .read<SystemTabCubit>()
                                        .onSecondaryTabChanged(
                                          SecondaryTab.designation,
                                        );
                                    context
                                        .read<DepartmentPageControllerCubit>()
                                        .animatePage(1);
                                  },
                                  hoverColor:
                                      Theme.of(context).colorScheme.secondary,
                                  child: Ink(
                                    color: state.selectedSecondaryTab ==
                                            SecondaryTab.designation
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Icon(
                                            SecondaryTab.designation.icon,
                                            size: 13.sp,
                                            color: state.selectedSecondaryTab ==
                                                    SecondaryTab.designation
                                                ? Colors.black87
                                                : Colors.black54,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            SecondaryTab.designation.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color:
                                                      state.selectedSecondaryTab ==
                                                              SecondaryTab
                                                                  .designation
                                                          ? Colors.black87
                                                          : Colors.black54,
                                                  fontSize: 13.sp,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
