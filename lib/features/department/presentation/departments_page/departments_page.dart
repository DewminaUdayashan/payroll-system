import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/department/presentation/departments_page/widgets/departments_list.dart';
import 'package:payroll_system/features/department/presentation/departments_page/widgets/departmet_title.dart';

import '../blocs/departments_cubit/departments_cubit.dart';

class DepartmentsPage extends StatefulWidget {
  const DepartmentsPage({Key? key}) : super(key: key);

  @override
  State<DepartmentsPage> createState() => _DepartmentsPageState();
}

class _DepartmentsPageState extends State<DepartmentsPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPersistentHeader(
            delegate: DepartmentTitleBar(),
            floating: true,
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<DepartmentsCubit, DepartmentsState>(
              builder: (context, state) {
                if (state is DepartmentsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is DepartmentsError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                final currentState = state as DepartmentsLoaded;
                return DepartmentsList(currentState: currentState);
              },
            ),
          )
        ],
      ),
    );
  }
}
