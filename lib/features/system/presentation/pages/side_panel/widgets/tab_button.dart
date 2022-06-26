import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/system/presentation/blocs/system_tab/system_tab_cubit.dart';
import 'package:payroll_system/features/system/presentation/shared/system_enums.dart';

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
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () => context.read<SystemTabCubit>().onTabChanged(tab),
              hoverColor: Theme.of(context).colorScheme.primaryContainer,
              child: Ink(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: state.selectedTab == tab
                                ? Colors.black87
                                : Colors.grey),
                      )
                    ],
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
