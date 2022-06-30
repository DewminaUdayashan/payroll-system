import 'dart:convert';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:payroll_system/core/shared/notification_helper.dart';
import 'package:payroll_system/features/department/domain/entities/department.dart';
import 'package:payroll_system/features/department/domain/entities/designation.dart';
import 'package:payroll_system/features/department/presentation/blocs/departments_cubit/departments_cubit.dart';
import 'package:payroll_system/features/department/presentation/blocs/designations_cubit/designations_cubit.dart';
import 'package:payroll_system/features/employees/data/models/employee_model.dart';
import 'package:payroll_system/features/employees/presentation/blocs/emp_department_filter.dart/emp_department_filter_cubit.dart';
import 'package:payroll_system/features/employees/presentation/blocs/gender_radio/gender_radio_cubit.dart';
import 'package:payroll_system/features/employees/presentation/blocs/image_picker/image_picker_cubit.dart';
import 'package:payroll_system/features/employees/presentation/employees_add/widgets/text_field_widget.dart';
import 'package:payroll_system/features/employees/shared/emp_enums.dart';

import '../blocs/employees_cubit/employees_cubit.dart';

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
                          } else if (str.length != 10) {
                            return 'Mobile number must be 10 digits';
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
                        validator: (String? str) {
                          if (str != null && str.isNotEmpty) {
                            //validate email address
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(str)) {
                              return 'Invalid email address';
                            }
                          }
                          return null;
                        },
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 4.5,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            label: 'Joined Date',
                            controller: joinedDateController,
                            readOnly: true,
                            onTap: () =>
                                _showDatePicker(context, joinedDate: true),
                            validator: (String? str) {
                              if (str == null || str.trim().isEmpty) {
                                return 'Joined Date is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        // const SizedBox(width: 10),
                        // Expanded(
                        //   child: TextFieldWidget(
                        //     label: 'EPF Number',
                        //     controller: epfNumberController,
                        //     focusNode: epfNode,
                        //     textInputFormatters: [
                        //       FilteringTextInputFormatter.allow(RegExp('[0-9,]+')),
                        //       LengthLimitingTextInputFormatter(10),
                        //     ],
                        //     onFieldSubmitted: (_) {
                        //       genderMaleNode.requestFocus();
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
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
                Row(
                  children: [
                    BlocBuilder<ImagePickerCubit, ImagePickerState>(
                      builder: (context, state) {
                        return DropTarget(
                          enable: true,
                          onDragDone:
                              context.read<ImagePickerCubit>().onDragDone,
                          child: InkWell(
                            onTap: () {
                              context.read<ImagePickerCubit>().pickImage();
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Container(
                                width: 200,
                                height: 200,
                                color: Colors.grey.withOpacity(.2),
                                padding: state.file != null
                                    ? null
                                    : const EdgeInsets.all(10),
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.image_rounded,
                                          size: 100,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          'Drag & drop image or click to select image',
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    if (state.file != null) ...[
                                      Positioned.fill(
                                        child: Image.file(
                                          state.file!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 30),
                    Column(
                      children: [
                        BlocBuilder<EmpDepartmentFilterCubit,
                            EmpDepartmentFilterState>(
                          builder: (context, state) {
                            return BlocBuilder<DepartmentsCubit,
                                DepartmentsState>(
                              builder: (context, depState) {
                                if (depState is DepartmentsLoading ||
                                    depState is DepartmentsError) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                const selectDepartmentTmp =
                                    Department(name: 'Select');
                                final depLoaded = depState as DepartmentsLoaded;
                                final departmentsToDropDown =
                                    List.from(depLoaded.departments)
                                        .cast<Department>();
                                departmentsToDropDown
                                    .remove(selectDepartmentTmp);
                                departmentsToDropDown.insert(
                                    0, selectDepartmentTmp);
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: state.departmentNotSelected
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Assign Department : ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black54,
                                              fontSize: 15.sp,
                                            ),
                                      ),
                                      const SizedBox(width: 10),
                                      DropdownButton<Department>(
                                        value: state.department ??
                                            selectDepartmentTmp,
                                        underline: const SizedBox.shrink(),
                                        items: departmentsToDropDown
                                            .map((e) => DropdownMenuItem(
                                                  value: e,
                                                  child: Text(e.name),
                                                ))
                                            .toList(),
                                        onChanged: context
                                            .read<EmpDepartmentFilterCubit>()
                                            .onDepartmentChanged,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        BlocBuilder<EmpDepartmentFilterCubit,
                            EmpDepartmentFilterState>(
                          builder: (context, state) {
                            if (state.department == null ||
                                state.department?.name == 'Select') {
                              return const SizedBox.shrink();
                            }
                            return BlocBuilder<DesignationsCubit,
                                DesignationsState>(
                              builder: (context, depState) {
                                if (depState is DesignationsLoading ||
                                    depState is DesignationsError) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                final selectDesignationTmp = Designation(
                                  name: 'Select',
                                  allowance: 0,
                                  departmentId: 0,
                                );

                                final desLoaded =
                                    depState as DesignationsLoaded;
                                final designationsToDropDown = List.from(
                                    desLoaded.designations.where((element) =>
                                        element.departmentId ==
                                        state.department
                                            ?.id)).cast<Designation>();

                                if (designationsToDropDown.isEmpty) {
                                  return const Text(
                                      'No Designations Found in this Department');
                                } else if (designationsToDropDown.length == 1) {
                                  if (designationsToDropDown.first.name ==
                                      'Select') {
                                    return const Text(
                                        'No Designations Found in this Department');
                                  }
                                }
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: state.designationNotSelected
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Assign Designation : ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black54,
                                              fontSize: 15.sp,
                                            ),
                                      ),
                                      const SizedBox(width: 10),
                                      DropdownButton<Designation>(
                                        value: state.designation ??
                                            selectDesignationTmp,
                                        underline: const SizedBox.shrink(),
                                        items: [
                                          if (designationsToDropDown.isEmpty)
                                            DropdownMenuItem(
                                              value: selectDesignationTmp,
                                              child: const Text('Select'),
                                            )
                                          else ...[
                                            ...designationsToDropDown
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(e.name),
                                                    ))
                                                .toList(),
                                            DropdownMenuItem(
                                              value: selectDesignationTmp,
                                              child: Text(
                                                  selectDesignationTmp.name),
                                            ),
                                          ]
                                        ],
                                        onChanged: context
                                            .read<EmpDepartmentFilterCubit>()
                                            .onDesignationChanged,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
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
            final departmentValidated =
                context.read<EmpDepartmentFilterCubit>().validateSelections();
            final formValidated = (formKey.currentState?.validate() ?? false);

            if (departmentValidated && formValidated) {
              final employee = EmployeeModel(
                designationId: context
                    .read<EmpDepartmentFilterCubit>()
                    .state
                    .designation!
                    .id!,
                surename: sureNameController.text,
                firstName: firstNameController.text,
                nic: nicController.text,
                dateOfBirth: DateTime.parse(dobController.text),
                gender: context.read<GenderRadioCubit>().state.gender,
                mobile1: mobile1Controller.text,
                mobile2: mobile2Controller.text,
                joinedDate: DateTime.parse(joinedDateController.text),
                accountNo: accountNumberController.text,
                addressLine1: address1Controller.text,
                addressLine2: address2Controller.text,
                addressLine3: address3Controller.text,
                email: emailController.text,
                epfNumber: epfNumberController.text,
                lastName: lastNameController.text,
                url: context.read<ImagePickerCubit>().state.file != null
                    ? base64Encode(context
                        .read<ImagePickerCubit>()
                        .state
                        .file!
                        .readAsBytesSync())
                    : null,
              );
              context.read<EmployeesCubit>().addEMployee(employee, context);
            } else {
              NotificationHelper.error(
                context: context,
                title: 'Why Empty.?',
                subtitle: 'Please fill all fields to continue..',
              );
            }
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
          joinedDateController.text = DateFormat("yyyy-MM-dd").format(date);
          epfNode.requestFocus();
        } else {
          dobController.text = DateFormat("yyyy-MM-dd").format(date);
          mobile1Node.requestFocus();
        }
      }
    });
  }
}
