import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll_system/features/department/presentation/blocs/departments_cubit/departments_cubit.dart';

class DepartmentSearchField extends StatelessWidget {
  const DepartmentSearchField({
    Key? key,
  }) : super(key: key);

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
            onChanged: context.read<DepartmentsCubit>().searchDepartment,
            decoration: const InputDecoration(
              hintText: 'Search Department',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              suffixIcon: Icon(
                Icons.search_rounded,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
