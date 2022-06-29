import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:payroll_system/features/employees/presentation/blocs/gender_radio/gender_radio_cubit.dart';
import 'package:payroll_system/features/employees/presentation/employees_add/widgets/text_field_widget.dart';
import 'package:payroll_system/features/employees/shared/emp_enums.dart';

class EmployeesAddDialog extends StatefulWidget {
  const EmployeesAddDialog({this.isEditing = false, Key? key})
      : super(key: key);
  final bool isEditing;

  @override
  State<EmployeesAddDialog> createState() => _EmployeesAddDialogState();
}

class _EmployeesAddDialogState extends State<EmployeesAddDialog> {
  final TextEditingController firstNameController = TextEditingController();
  //last name
  final TextEditingController lastNameController = TextEditingController();
  //surename
  final TextEditingController sureNameController = TextEditingController();
  //nic
  final TextEditingController nicController = TextEditingController();
  //dob
  final TextEditingController dobController = TextEditingController();
  //mobile1
  final TextEditingController mobile1Controller = TextEditingController();
  //mobile2
  final TextEditingController mobile2Controller = TextEditingController();
  //email
  final TextEditingController emailController = TextEditingController();
  //accountnumber
  final TextEditingController accountNumberController = TextEditingController();
  //joined date
  final TextEditingController joinedDateController = TextEditingController();
  //epf number
  final TextEditingController epfNumberController = TextEditingController();
  //address1
  final TextEditingController address1Controller = TextEditingController();
  //address2
  final TextEditingController address2Controller = TextEditingController();
  //address3
  final TextEditingController address3Controller = TextEditingController();

  final FocusNode surenameFocusNode = FocusNode();
  final FocusNode dobFocusNode = FocusNode();
  final FocusNode genderMaleNode = FocusNode();
  final FocusNode genderFemaleNode = FocusNode();
  final FocusNode mobile1Node = FocusNode();
  final FocusNode epfNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  final addressLines = <String>[];

  @override
  void initState() {
    super.initState();
    surenameFocusNode.requestFocus();
  }

  @override
  void dispose() {
//dispose all controllers
    firstNameController.dispose();
    lastNameController.dispose();
    sureNameController.dispose();
    nicController.dispose();
    dobController.dispose();
    mobile1Controller.dispose();
    mobile2Controller.dispose();
    emailController.dispose();
    accountNumberController.dispose();
    joinedDateController.dispose();
    epfNumberController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    address3Controller.dispose();
    surenameFocusNode.dispose();
    //dispose all focus nodes
    surenameFocusNode.dispose();
    dobFocusNode.dispose();
    genderMaleNode.dispose();
    genderFemaleNode.dispose();
    mobile1Node.dispose();
    epfNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(35),
      titlePadding: const EdgeInsets.only(left: 35, top: 35),
      title: Text(
        widget.isEditing ? 'Update Employee' : 'Add Employee',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 15.h),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        label: 'Surename',
                        controller: sureNameController,
                        focusNode: surenameFocusNode,
                        validator: (String? str) {
                          if (str == null || str.trim().isEmpty) {
                            return 'Surename is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFieldWidget(
                        label: 'First Name',
                        controller: firstNameController,
                        validator: (String? str) {
                          if (str == null || str.trim().isEmpty) {
                            return 'First Name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFieldWidget(
                        label: 'Last Name',
                        controller: lastNameController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35.h),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        label: 'NIC',
                        controller: nicController,
                        onFieldSubmitted: (_) {
                          dobFocusNode.requestFocus();
                          _showDatePicker(context);
                        },
                        validator: (String? str) {
                          if (str == null || str.trim().isEmpty) {
                            return 'NIC is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFieldWidget(
                        label: 'DOB',
                        controller: dobController,
                        focusNode: dobFocusNode,
                        readOnly: true,
                        onTap: () => _showDatePicker(context),
                        validator: (String? str) {
                          if (str == null || str.trim().isEmpty) {
                            return 'DOB is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35.h),
                Row(
                  children: [
                    //mobile1
                    Expanded(
                      child: TextFieldWidget(
                        label: 'Mobile 1',
                        focusNode: mobile1Node,
                        controller: mobile1Controller,
                        maxLenght: 10,
                        textInputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9,]+')),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (String? str) {
                          if (str == null || str.trim().isEmpty) {
                            return 'Mobile 1 is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFieldWidget(
                        label: 'Mobile 2',
                        controller: mobile2Controller,
                        maxLenght: 10,
                        textInputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9,]+')),
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    //mobile1
                    Expanded(
                      child: TextFieldWidget(
                        label: 'Email Address',
                        controller: emailController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFieldWidget(
                        label: 'Account Number',
                        controller: accountNumberController,
                        textInputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9,]+')),
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35.h),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        label: 'Address Line 1',
                        controller: address1Controller,
                        validator: (String? str) {
                          if (str == null || str.trim().isEmpty) {
                            return 'Address Line 1 is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFieldWidget(
                        label: 'Address Line 2',
                        controller: address2Controller,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFieldWidget(
                        label: 'Address Line 3',
                        controller: address3Controller,
                        onFieldSubmitted: (_) {
                          _showDatePicker(context, joinedDate: true);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35.h),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        label: 'Joined Date',
                        controller: joinedDateController,
                        readOnly: true,
                        onTap: () => _showDatePicker(context, joinedDate: true),
                        validator: (String? str) {
                          if (str == null || str.trim().isEmpty) {
                            return 'Joined Date is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFieldWidget(
                        label: 'EPF Number',
                        controller: epfNumberController,
                        focusNode: epfNode,
                        textInputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9,]+')),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        onFieldSubmitted: (_) {
                          genderMaleNode.requestFocus();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35.h),
                BlocBuilder<GenderRadioCubit, GenderRadioState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Focus(
                          focusNode: genderMaleNode,
                          onKey: (FocusNode node, RawKeyEvent event) {
                            if (event.logicalKey == LogicalKeyboardKey.enter) {
                              if (context
                                          .read<GenderRadioCubit>()
                                          .state
                                          .gender ==
                                      Gender.notSelected ||
                                  context
                                          .read<GenderRadioCubit>()
                                          .state
                                          .gender ==
                                      Gender.male) {
                                genderFemaleNode.requestFocus();
                              }
                              return KeyEventResult.handled;
                            }
                            if (event.logicalKey == LogicalKeyboardKey.space) {
                              context
                                  .read<GenderRadioCubit>()
                                  .changeGender(Gender.male);
                              return KeyEventResult.handled;
                            }
                            return KeyEventResult.ignored;
                          },
                          child: Row(
                            children: [
                              Radio<Gender>(
                                value: Gender.male,
                                groupValue: state.gender,
                                mouseCursor: SystemMouseCursors.click,
                                onChanged: context
                                    .read<GenderRadioCubit>()
                                    .changeGender,
                              ),
                              const Text('Male'),
                            ],
                          ),
                        ),
                        SizedBox(width: 35.h),
                        Focus(
                          focusNode: genderFemaleNode,
                          onKey: (FocusNode node, RawKeyEvent event) {
                            if (event.logicalKey == LogicalKeyboardKey.enter) {
                              genderFemaleNode.requestFocus();
                              return KeyEventResult.handled;
                            }
                            if (event.logicalKey == LogicalKeyboardKey.space) {
                              context
                                  .read<GenderRadioCubit>()
                                  .changeGender(Gender.female);
                              return KeyEventResult.handled;
                            }
                            return KeyEventResult.ignored;
                          },
                          child: Row(
                            children: [
                              Radio<Gender>(
                                value: Gender.female,
                                groupValue: state.gender,
                                mouseCursor: SystemMouseCursors.click,
                                onChanged: context
                                    .read<GenderRadioCubit>()
                                    .changeGender,
                              ),
                              const Text('Female'),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 35.h),
              ],
            ),
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
                            context
                                .read<GenderRadioCubit>()
                                .changeGender(Gender.notSelected);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  });
            },
            child: const Text('Cancel')),
        TextButton(
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {}
          },
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            primary: Theme.of(context).colorScheme.onPrimary,
          ),
          child: const Text('Add Employee'),
        ),
      ],
    );
  }

  _showDatePicker(BuildContext context, {bool joinedDate = false}) {
    showDatePicker(
      context: context,
      helpText: 'Select Date of Birth',
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
      lastDate: DateTime.now(),
    ).then((DateTime? date) {
      if (date != null) {
        if (joinedDate) {
          joinedDateController.text = DateFormat.yMMMMd().format(date);
          epfNode.requestFocus();
        } else {
          dobController.text = DateFormat.yMMMMd().format(date);
          mobile1Node.requestFocus();
        }
      }
    });
  }
}
