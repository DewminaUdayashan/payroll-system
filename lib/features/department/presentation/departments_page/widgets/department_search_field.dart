import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll_system/features/department/presentation/blocs/departments_cubit/departments_cubit.dart';
import 'package:payroll_system/features/department/presentation/blocs/designations_cubit/designations_cubit.dart';

class DepartmentSearchField extends StatelessWidget {
  const DepartmentSearchField({
    Key? key,
    this.isDesignationView = false,
  }) : super(key: key);
  final bool isDesignationView;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 60.h,
        width: MediaQuery.of(context).size.width / 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: !isDesignationView
                ? context.read<DepartmentsCubit>().searchDepartment
                : context.read<DesignationsCubit>().searchDesignation,
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            decoration: InputDecoration(
              labelText: isDesignationView
                  ? 'Search Designations'
                  : 'Search Departments',
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              suffixIcon: Icon(
                Icons.search_rounded,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
