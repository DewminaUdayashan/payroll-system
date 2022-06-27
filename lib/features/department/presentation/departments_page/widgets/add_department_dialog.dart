import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/department/domain/entities/department.dart';
import 'package:payroll_system/features/department/presentation/blocs/departments_cubit/departments_cubit.dart';

import '../../../../../core/shared/strings.dart';
import '../../../data/models/department_model.dart';

class AddDepartmentDialog extends StatefulWidget {
  const AddDepartmentDialog({this.department, Key? key}) : super(key: key);
  final Department? department;

  @override
  State<AddDepartmentDialog> createState() => _AddDepartmentDialogState();
}

class _AddDepartmentDialogState extends State<AddDepartmentDialog> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final description = TextEditingController();
  final nameNode = FocusNode();

  @override
  void initState() {
    setupIfUpdate();
    nameNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    super.dispose();
  }

  /// if dialog was shown for update existing `Department`,
  /// we receive [Department] model class from the prevoius UI.
  /// so, we can know the dialog was called for `update` if the
  /// instance is not null. if it is not null we set the
  /// existing values to the `TextEditingControllers`
  void setupIfUpdate() {
    if (widget.department != null) {
      name.text = widget.department?.name ?? '';
      description.text = widget.department?.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(35),
      titlePadding: const EdgeInsets.only(left: 35, top: 35),
      title: Text(
        widget.department != null ? updateDepartment : addDepartment,
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
                    controller: name,
                    focusNode: nameNode,
                    decoration: const InputDecoration(
                      labelText: 'Department Name',
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
                        return 'What is the department name?';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: description,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: '(Optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLength: 100,
                    maxLines: 12,
                    minLines: 4,
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
              if (widget.department != null) {
                context.read<DepartmentsCubit>().updateDepartmet(
                      DepartmentModel(
                        id: widget.department!.id,
                        name: name.text,
                        description: description.text,
                      ),
                      context,
                    );
              } else {
                context.read<DepartmentsCubit>().addDepartmet(
                      DepartmentModel(
                        name: name.text,
                        description: description.text,
                      ),
                      context,
                    );
              }
            }
          },
          child: Text(
            widget.department != null ? 'Update' : 'Add',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }
}
