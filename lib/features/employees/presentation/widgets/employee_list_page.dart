import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/employees/presentation/blocs/employees_cubit/employees_cubit.dart';
import 'package:payroll_system/features/employees/presentation/widgets/employee_list_item.dart';
import 'package:payroll_system/features/employees/presentation/widgets/employees_title.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: EmployeesTitle(),
          floating: true,
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<EmployeesCubit, EmployeesState>(
            builder: (context, state) {
              if (state is EmployeesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is EmployeeError) {
                return Center(
                  child: Text(state.message),
                );
              }
              final currentState = state as EmployeesLoaded;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: currentState.employees.length,
                itemBuilder: (context, index) {
                  final employee = currentState.employees[index];
                  return EmployeeListItem(employee, index);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
