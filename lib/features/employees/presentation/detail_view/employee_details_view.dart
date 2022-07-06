import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:payroll_system/features/addition/presentation/blocs/addition_cubit/addition_cubit.dart';
import 'package:payroll_system/features/employees/presentation/blocs/employee_page_controller/employee_page_controller_cubit.dart';
import 'package:payroll_system/features/employees/presentation/detail_view/widgets/general_details.dart';
import 'package:payroll_system/features/employees/presentation/widgets/employee_data_title_bar.dart';

class EmployeeDetailsView extends StatefulWidget {
  const EmployeeDetailsView({Key? key}) : super(key: key);

  @override
  State<EmployeeDetailsView> createState() => _EmployeeDetailsViewState();
}

class _EmployeeDetailsViewState extends State<EmployeeDetailsView> {
  @override
  void initState() {
    context.read<AdditionCubit>().getAdditions(
        context.read<EmployeePageControllerCubit>().employee.id!, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: () {
                    context.read<EmployeePageControllerCubit>().changePAge(0);
                  },
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${context.read<EmployeePageControllerCubit>().employee.surename} ${context.read<EmployeePageControllerCubit>().employee.firstName} - ${context.read<EmployeePageControllerCubit>().employee.nic}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Member Since : ${DateFormat('dd MMM yyyy').format(context.read<EmployeePageControllerCubit>().employee.joinedDate)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),
            const GeneralDetails(),
            const SizedBox(height: 25),
            Align(
              alignment: Alignment.center,
              child: Text(
                '- Additions -',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 25),
            BlocBuilder<AdditionCubit, AdditionState>(
              builder: (context, state) {
                if (state is AdditionsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AdditionsError) {
                  return const Center(
                    child: Text('Something went wrnong..!'),
                  );
                }
                final currentState = state as AdditionsLoaded;
                final additions = currentState.additions
                    .where((element) => !element.isDeduction)
                    .toList();
                final deductions = currentState.additions
                    .where((element) => element.isDeduction)
                    .toList();

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (deductions.isEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.no_accounts,
                              color: Colors.grey,
                            ),
                            Text('No any deduction set to the employee'),
                          ],
                        ),
                      )
                    ] else
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: const [
                                    ListTitle(
                                      flex: 1,
                                      name: 'Deduction',
                                      textAlign: TextAlign.center,
                                    ),
                                    ListTitle(
                                      flex: 1,
                                      name: 'Amount',
                                      textAlign: TextAlign.right,
                                    ),
                                    ListTitle(
                                      flex: 1,
                                      name: 'Monthly',
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: deductions.length,
                                itemBuilder: (context, index) {
                                  final addition = deductions[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(10),
                                        child: ListTile(
                                          tileColor: index.isEven
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer
                                              : null,
                                          onTap: () {},
                                          enabled: true,
                                          title: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                addition.name,
                                                textAlign: TextAlign.center,
                                              )),
                                              Expanded(
                                                  child: Text(
                                                addition.amount
                                                    .toStringAsFixed(2),
                                                textAlign: TextAlign.right,
                                              )),
                                              Expanded(
                                                  child: Text(
                                                addition.isMonthly.toString(),
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (additions.isEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.no_accounts,
                              color: Colors.grey,
                            ),
                            Text('No any addition set to the employee'),
                          ],
                        ),
                      )
                    ] else
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: const [
                                    ListTitle(
                                      flex: 1,
                                      name: 'Addition',
                                      textAlign: TextAlign.center,
                                    ),
                                    ListTitle(
                                      flex: 1,
                                      name: 'Amount',
                                      textAlign: TextAlign.right,
                                    ),
                                    ListTitle(
                                      flex: 1,
                                      name: 'Monthly',
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: additions.length,
                                itemBuilder: (context, index) {
                                  final addition = additions[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(10),
                                        child: ListTile(
                                          tileColor: index.isEven
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer
                                              : null,
                                          onTap: () {},
                                          enabled: true,
                                          title: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                addition.name,
                                                textAlign: TextAlign.center,
                                              )),
                                              Expanded(
                                                  child: Text(
                                                addition.amount
                                                    .toStringAsFixed(2),
                                                textAlign: TextAlign.right,
                                              )),
                                              Expanded(
                                                  child: Text(
                                                addition.isMonthly.toString(),
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
