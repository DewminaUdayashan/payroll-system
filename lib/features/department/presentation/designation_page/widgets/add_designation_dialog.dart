import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/department/data/models/designation_model.dart';
import 'package:payroll_system/features/department/presentation/blocs/departments_cubit/departments_cubit.dart';
import 'package:payroll_system/features/department/presentation/blocs/designations_cubit/designations_cubit.dart';

import '../../../../../core/shared/strings.dart';
import '../../../domain/entities/designation.dart';

class AddDesignationDialog extends StatefulWidget {
  const AddDesignationDialog({this.designation, Key? key}) : super(key: key);
  final Designation? designation;

  @override
  State<AddDesignationDialog> createState() => _AddDesignationDialogState();
}

class _AddDesignationDialogState extends State<AddDesignationDialog> {
  final _formKey = GlobalKey<FormState>();
  final designation = TextEditingController();
  final allowance = TextEditingController();
  final department = TextEditingController();
  final designationNode = FocusNode();
  final allowanceNode = FocusNode();

  @override
  void initState() {
    setupIfUpdate();
    designationNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    designation.dispose();
    allowance.dispose();
    designationNode.dispose();
    allowanceNode.dispose();
    super.dispose();
  }

  void setupIfUpdate() {
    if (widget.designation != null) {
      designation.text = widget.designation?.name ?? '';
      allowance.text = widget.designation?.allowance.toStringAsFixed(2) ?? '';
      department.text = context
          .read<DepartmentsCubit>()
          .getDepartmentNameById(widget.designation!.departmentId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(35),
      titlePadding: const EdgeInsets.only(left: 35, top: 35),
      title: Text(
        widget.designation != null ? updateDesignation : addDesignation,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: designation,
                    focusNode: designationNode,
                    decoration: const InputDecoration(
                      labelText: 'Designation',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (String? str) {
                      if (str == null || str.isEmpty) {
                        return 'What is the designation name?';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  EasyAutocomplete(
                    validator: context
                        .read<DepartmentsCubit>()
                        .validateSubmittedDepartment,
                    controller: department,
                    asyncSuggestions: (String? str) async {
                      final res =
                          await BlocProvider.of<DepartmentsCubit>(context)
                              .getSearchSuggetions(str);
                      if (res != null) return res.map((e) => e.name).toList();
                      return [];
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search Department',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    suggestionBuilder: (String? str) {
                      return ListTile(
                        title: Text(str ?? 'No department found'),
                        enableFeedback: true,
                        tileColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                      );
                    },
                    onSubmitted: (String? str) {
                      department.text = str ?? '';
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: allowance,
                    focusNode: allowanceNode,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}')),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Allowance',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (String? str) {
                      if (str == null || str.isEmpty) {
                        return 'How much is allowance?';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
            )),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.designation == null) {
                BlocProvider.of<DesignationsCubit>(context).addDesignation(
                  DesignationModel(
                    id: widget.designation?.id,
                    name: designation.text,
                    allowance: double.parse(allowance.text),
                    departmentId: context
                        .read<DepartmentsCubit>()
                        .getDepartmetId(department.text),
                  ),
                  context,
                );
              } else {
                BlocProvider.of<DesignationsCubit>(context).updateDepartmet(
                  DesignationModel(
                    id: widget.designation?.id,
                    name: designation.text,
                    allowance: double.parse(allowance.text),
                    departmentId: context
                        .read<DepartmentsCubit>()
                        .getDepartmetId(department.text),
                  ),
                  context,
                );
              }
            }
          },
          child: Text(
            widget.designation != null ? 'Update' : 'Add',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }
}
