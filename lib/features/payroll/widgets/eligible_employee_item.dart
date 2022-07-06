import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/core/cubit/payroll_refresh/payroll_refresh_cubit.dart';
import 'package:payroll_system/features/department/presentation/blocs/designations_cubit/designations_cubit.dart';
import 'package:payroll_system/features/employees/presentation/blocs/employees_cubit/employees_cubit.dart';
import 'package:payroll_system/features/payroll/blocs/payroll_generator/payroll_generator_cubit.dart';

import '../entities/eligible_employee.dart';

class EligibleEmployeeItem extends StatefulWidget {
  const EligibleEmployeeItem({
    Key? key,
    required this.emp,
    this.onTap,
    required this.index,
    required this.payrollParentScreenContext,
  }) : super(key: key);

  final EligibleEmployee emp;
  final Function(bool? isExpanded)? onTap;
  final int index;
  final BuildContext payrollParentScreenContext;

  @override
  State<EligibleEmployeeItem> createState() => _EligibleEmployeeItemState();
}

class _EligibleEmployeeItemState extends State<EligibleEmployeeItem> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayrollGeneratorCubit, PayrollGeneratorState>(
      listener: (context, state) {
        setState(() {});
      },
      builder: (context, state) {
        return Material(
          color: widget.index.isEven
              ? Theme.of(context).colorScheme.primaryContainer
              : null,
          child: ExpansionPanelList(
            expansionCallback: (index, isExpanded) {
              context
                  .read<PayrollGeneratorCubit>()
                  .selectIndeX(index, isExpanded);
              widget.onTap?.call(true);
            },
            children: [
              ExpansionPanel(
                backgroundColor: state.eligibleEmployee == widget.emp
                    ? Theme.of(context).colorScheme.primaryContainer
                    : null,
                isExpanded: state.eligibleEmployee == widget.emp,
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) => Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                '${widget.emp.surename} ${widget.emp.firstName}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${widget.emp.epfNumber ?? '-'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                context
                                    .read<DesignationsCubit>()
                                    .getDesignationNameById(
                                      context
                                          .read<EmployeesCubit>()
                                          .getDesignationIdForEmployeeId(
                                            widget.emp.id,
                                          ),
                                    ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${widget.emp.totalDays}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Material(
                      color: Colors.white,
                      child: (state.additions?.isEmpty ?? true)
                          ? const Center(
                              child: Text('No additions for this employee'),
                            )
                          : Column(
                              children: [
                                const Divider(),
                                const Text('Additions'),
                                const Divider(),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.additions?.length ?? 0,
                                  itemBuilder: (context, index) =>
                                      SwitchListTile(
                                    value: state.additions![index]
                                            .selectedForPayroll &&
                                        state.additions![index].isMonthly,
                                    onChanged: (value) {
                                      context
                                          .read<PayrollGeneratorCubit>()
                                          .onAdditionToggle(index, value);
                                      setState(() {});
                                      context
                                          .read<PayrollRefreshCubit>()
                                          .refresh();
                                    },
                                    title: Text(
                                        state.additions?[index].name ?? ''),
                                    subtitle: Text(state
                                        .additions![index].amount
                                        .toString()),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 10),
                    Material(
                      color: Colors.white,
                      child: (state.deductions?.isEmpty ?? true)
                          ? const Center(
                              child: Text('No deductions for this employee'),
                            )
                          : Column(
                              children: [
                                const Divider(),
                                const Text('Deductions'),
                                const Divider(),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.deductions?.length ?? 0,
                                  itemBuilder: (context, index) =>
                                      SwitchListTile(
                                    value: state.deductions![index]
                                            .selectedForPayroll &&
                                        state.deductions![index].isMonthly,
                                    onChanged: (value) {
                                      context
                                          .read<PayrollGeneratorCubit>()
                                          .onDeductionToggle(index, value);
                                      setState(() {});
                                      context
                                          .read<PayrollRefreshCubit>()
                                          .refresh();
                                    },
                                    title: Text(
                                        state.deductions?[index].name ?? ''),
                                    subtitle: Text(state
                                        .deductions![index].amount
                                        .toString()),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
