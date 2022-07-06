import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:payroll_system/core/cubit/payroll_refresh/payroll_refresh_cubit.dart';
import 'package:payroll_system/core/shared/dialogs.dart';
import 'package:payroll_system/core/shared/notification_helper.dart';
import 'package:payroll_system/features/department/domain/entities/department.dart';
import 'package:payroll_system/features/department/presentation/blocs/departments_cubit/departments_cubit.dart';
import 'package:payroll_system/features/department/presentation/blocs/designations_cubit/designations_cubit.dart';
import 'package:payroll_system/features/employees/presentation/blocs/employees_cubit/employees_cubit.dart';
import 'package:payroll_system/features/employees/shared/emp_enums.dart';
import 'package:payroll_system/features/payroll/blocs/payroll_generator/payroll_generator_cubit.dart';
import 'package:payroll_system/features/payroll/payroll_employees/payroll_employees_cubit.dart';
import 'package:payroll_system/features/payroll/shared/pdf_helper.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'widgets/eligible_employee_item.dart';

class Payroll extends StatefulWidget {
  const Payroll({Key? key}) : super(key: key);

  @override
  State<Payroll> createState() => _PayrollState();
}

class _PayrollState extends State<Payroll> {
  late int selectedMonth;
  Department? selectedDepartment;

  @override
  void initState() {
    super.initState();
    selectedMonth = DateTime.now().month;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Generate Payroll',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                SizedBox(
                  width: 250.w,
                  child: Row(
                    children: [
                      Text(
                        'Department : ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                              fontSize: 15.sp,
                            ),
                      ),
                      const SizedBox(width: 5),
                      BlocBuilder<DepartmentsCubit, DepartmentsState>(
                        builder: (context, state) {
                          if (state is DepartmentsError) {
                            selectedDepartment = null;
                            return const Text('Error');
                          } else if (state is DepartmentsLoaded) {
                            final currentState = state;
                            final deparments = currentState.departments;
                            // deparments.add(const Department(name: 'Select'));
                            return DropdownButton<Department>(
                              value: selectedDepartment,
                              underline: const SizedBox.shrink(),
                              items: deparments
                                  .map((Department e) => DropdownMenuItem(
                                      value: e, child: Text(e.name)))
                                  .toList(),
                              onChanged: (Department? department) {
                                if (department != null) {
                                  context
                                      .read<PayrollEmployeesCubit>()
                                      .fetchEligibleEmployees(
                                        department,
                                        selectedMonth,
                                      );
                                  setState(() {
                                    selectedDepartment = department;
                                  });
                                }
                              },
                            );
                          }
                          selectedDepartment = null;

                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 50),
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Month : ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                              fontSize: 15.sp,
                            ),
                      ),
                      const SizedBox(width: 5),
                      DropdownButton<int>(
                        value: selectedMonth,
                        underline: const SizedBox.shrink(),
                        items: [
                          for (int i = 1; i <= 12; i++)
                            DropdownMenuItem(
                              value: i,
                              child: Text(
                                DateFormat('MMMM').format(
                                  DateTime(DateTime.now().month, i),
                                ),
                              ),
                            ),
                        ],
                        onChanged: (int? month) {
                          if (month != null) {
                            setState(() {
                              selectedMonth = month;
                            });
                          }
                          if (selectedDepartment != null) {
                            context
                                .read<PayrollEmployeesCubit>()
                                .fetchEligibleEmployees(
                                  selectedDepartment!,
                                  selectedMonth,
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: selectedDepartment == null
                        ? const SelectDepartmetWarning()
                        : SingleChildScrollView(
                            child: BlocBuilder<PayrollEmployeesCubit,
                                PayrollEmployeesState>(
                              builder: (context, state) {
                                if (state is PayrollEmployeesLoading ||
                                    state is PayrollEmployeesInitial) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (state is PayrollEmployeesError) {
                                  return Center(
                                    child: Text('Error : ${state.message}'),
                                  );
                                }
                                final currentState =
                                    state as PayrollEmployeesLoaded;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Eligible for payment'),
                                    const SizedBox(height: 8),
                                    SingleChildScrollView(
                                      child: Material(
                                        child: ListTile(
                                          selectedTileColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          selectedColor: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          selected: true,
                                          title: Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: const [
                                                    Expanded(
                                                      child: Text(
                                                        'Name',
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        'Epf',
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        'Designation',
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        'Total Days',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    if (currentState.employees.isEmpty)
                                      const Center(
                                        child: Text(
                                            'No employees eligible for get payment for current month..\nPlease mark attendance and check again'),
                                      )
                                    else
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            currentState.employees.length,
                                        itemBuilder: (context, index) {
                                          final emp =
                                              currentState.employees[index];
                                          return EligibleEmployeeItem(
                                            emp: emp,
                                            onTap: (bool? isExpanded) => context
                                                .read<PayrollGeneratorCubit>()
                                                .onEmployeeSelected(
                                                  isExpanded,
                                                  emp,
                                                ),
                                            index: index,
                                            payrollParentScreenContext: context,
                                          );
                                        },
                                      ),
                                    const SizedBox(height: 20),
                                  ],
                                );
                              },
                            ),
                          ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: selectedDepartment == null
                        ? const SelectDepartmetWarning()
                        : BlocBuilder<PayrollGeneratorCubit,
                            PayrollGeneratorState>(
                            builder: (context, state) {
                              if (state.eligibleEmployee == null) {
                                return const Center(
                                  child: Text(
                                    'Select Employee to generate payroll...',
                                  ),
                                );
                              }

                              final designation = context
                                  .read<DesignationsCubit>()
                                  .getDesignationById(context
                                      .read<EmployeesCubit>()
                                      .getDesignationIdForEmployeeId(
                                          state.eligibleEmployee?.id));
                              return Stack(
                                children: [
                                  BlocConsumer<PayrollRefreshCubit,
                                      PayrollRefreshState>(
                                    listener: (___, ____) => setState(() {}),
                                    builder: (__, _) {
                                      return FutureBuilder<File>(
                                        future: PdfHelper().generatePayrollPdf(
                                          eligibleEmployee:
                                              state.eligibleEmployee!,
                                          month: selectedMonth.toMonthName,
                                          payrollState: state,
                                          employeeDesignation: designation,
                                          materialContext: context,
                                        ),
                                        builder: (context, snapshots) {
                                          if (snapshots.hasData) {
                                            return SfPdfViewer.file(
                                                snapshots.data!);
                                          }
                                          if (snapshots.hasError) {
                                            return Center(
                                              child: Text(
                                                  'Error : ${snapshots.error}'),
                                            );
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    right: 20,
                                    child: FloatingActionButton.extended(
                                      onPressed: () => context
                                          .read<PayrollGeneratorCubit>()
                                          .finalizePayment(
                                            onStart: () =>
                                                showLoadingDialog(context),
                                            onDone: () {
                                              Navigator.pop(context);
                                              if (selectedDepartment != null) {
                                                context
                                                    .read<
                                                        PayrollEmployeesCubit>()
                                                    .fetchEligibleEmployees(
                                                      selectedDepartment!,
                                                      selectedMonth,
                                                    );
                                              }
                                              context
                                                  .read<PayrollRefreshCubit>()
                                                  .refresh();
                                            },
                                            successNotification: () {
                                              NotificationHelper.success(
                                                context: context,
                                                title: 'Payment Succeeded..!',
                                                subtitle:
                                                    'Payment for ${state.eligibleEmployee?.firstName} for ${selectedMonth.toMonthName} has been successfully generated..!',
                                              );
                                            },
                                          ),
                                      label: const Text(
                                        'Pay',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      icon: const Icon(Icons.payment_rounded,
                                          color: Colors.white),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class SelectDepartmetWarning extends StatelessWidget {
  const SelectDepartmetWarning({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.hourglass_empty_rounded,
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        Text('Select Department'),
      ],
    );
  }
}
