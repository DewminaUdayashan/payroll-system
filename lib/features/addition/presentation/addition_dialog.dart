import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:payroll_system/core/shared/notification_helper.dart';
import 'package:payroll_system/features/addition/domain/addition.dart';
import 'package:payroll_system/features/addition/presentation/blocs/addition_cubit/addition_cubit.dart';
import 'package:payroll_system/features/addition/presentation/blocs/addition_type/addition_type_cubit.dart';
import 'package:payroll_system/features/addition/presentation/shared/addition_enums.dart';
import 'package:payroll_system/features/employees/domain/entities/employee.dart';
import 'package:payroll_system/features/employees/presentation/employees_add/widgets/text_field_widget.dart';

class AdditionDialog extends StatefulWidget {
  const AdditionDialog({Key? key, required this.employee}) : super(key: key);
  final Employee employee;

  @override
  State<AdditionDialog> createState() => _AdditionDialogState();
}

class _AdditionDialogState extends State<AdditionDialog> {
  final formKey = GlobalKey<FormState>();
  bool isMonthly = false;
  late final TextEditingController employeeName;
  final name = TextEditingController();
  final amount = TextEditingController();
  final start = TextEditingController();
  final end = TextEditingController();
  @override
  void initState() {
    super.initState();
    employeeName = TextEditingController.fromValue(TextEditingValue(
        text:
            '${widget.employee.surename} ${widget.employee.firstName} - ${widget.employee.nic}'));
  }

  @override
  void dispose() {
    employeeName.dispose();
    start.dispose();
    end.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set Addition/Deductions'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldWidget(
                label: 'Employee',
                controller: employeeName,
                readOnly: true,
              ),
              const SizedBox(height: 25),
              BlocBuilder<AdditionTypeCubit, AdditionTypeState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: RadioListTile<AdditionType?>(
                          value: AdditionType.addition,
                          groupValue: state.type,
                          title: Text(AdditionType.addition.name),
                          onChanged:
                              context.read<AdditionTypeCubit>().onTypeChanged,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<AdditionType?>(
                          value: AdditionType.deduction,
                          groupValue: state.type,
                          title: Text(AdditionType.deduction.name),
                          onChanged:
                              context.read<AdditionTypeCubit>().onTypeChanged,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      label: 'Addition Name',
                      controller: name,
                      validator: (String? str) {
                        if (str == null || str.trim().isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFieldWidget(
                      label: 'Start Date',
                      controller: start,
                      readOnly: true,
                      onTap: () => _showDatePicker(context),
                      validator: (String? str) {
                        if (str == null || str.trim().isEmpty) {
                          return 'Please select start date';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFieldWidget(
                      label: 'End Date',
                      controller: end,
                      onTap: () => _showDatePicker(context, isEnd: true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      label: 'Amount',
                      controller: amount,
                      validator: (String? str) {
                        if (str == null || str.trim().isEmpty) {
                          return 'Please enter a amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: Row(
                      children: [
                        Checkbox(
                            value: isMonthly,
                            onChanged: (bool? selected) {
                              if (selected != null) {
                                isMonthly = selected;
                                setState(() {});
                              }
                            }),
                        Text(
                          ' Monthly',
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text('This will discard all changes'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AdditionTypeCubit>().onTypeChanged(null);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                });
          },
          child: const Text('Discard'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              if (context.read<AdditionTypeCubit>().state.type == null) {
                NotificationHelper.error(
                  context: context,
                  title: 'Please select an addition type',
                );
              } else {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('Confirmation..!'),
                        content: Text(
                          'Are you sure you want to add this ${context.read<AdditionTypeCubit>().state.type?.name} to ${widget.employee.surename} ${widget.employee.firstName}?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<AdditionCubit>().addAddition(
                                  Addition(
                                    employeeId: widget.employee.id!,
                                    name: name.text,
                                    startDate: DateTime.parse(start.text),
                                    amount: double.parse(amount.text),
                                    isDeduction: context
                                        .read<AdditionTypeCubit>()
                                        .state
                                        .type!
                                        .isDeduction(),
                                    isActive: true,
                                    isMonthly: isMonthly,
                                  ),
                                  context);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    });
              }
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            primary: Colors.white,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future<void> _showDatePicker(BuildContext context,
      {bool isEnd = false}) async {
    final picked = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: (365 * 5))),
      context: context,
    );
    if (picked != null) {
      if (isEnd) {
        final startDateStr = start.text;
        if (startDateStr.isEmpty) {
          NotificationHelper.info(
              context: context,
              title: 'Start Date is empty',
              subtitle: 'Please select start date first');
          end.text = '';
          return;
        } else {
          final startDate = DateTime.parse(startDateStr);
          if (startDate.isBefore(picked)) {
            end.text = DateFormat("yyyy-MM-dd").format(picked);
            return;
          } else {
            NotificationHelper.info(
                context: context,
                title: 'Invalid date range selected..!',
                subtitle: 'End date should be after start date');
            end.text = '';
            return;
          }
        }
      }
      start.text = DateFormat("yyyy-MM-dd").format(picked);
    }
  }
}
