import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/department/presentation/blocs/designations_cubit/designations_cubit.dart';
import 'package:payroll_system/features/department/presentation/designation_page/widgets/designations_ist.dart';

import '../departments_page/widgets/departmet_title.dart';

class DesignationPage extends StatefulWidget {
  const DesignationPage({Key? key}) : super(key: key);

  @override
  State<DesignationPage> createState() => _DesignationPageState();
}

class _DesignationPageState extends State<DesignationPage> {
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
            delegate: DepartmentTitleBar(isDesignationView: true),
            floating: true,
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<DesignationsCubit, DesignationsState>(
              builder: (context, state) {
                if (state is DesignationsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is DesignationsError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                final currentState = state as DesignationsLoaded;
                return DesignationsList(currentState: currentState);
              },
            ),
          ),
        ],
      ),
    );
  }
}
