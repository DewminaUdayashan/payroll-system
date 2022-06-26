import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/department/presentation/department.dart';
import 'package:payroll_system/features/system/presentation/shared/system_enums.dart';

part 'system_tab_state.dart';

class SystemTabCubit extends Cubit<SystemTabState> {
  SystemTabCubit()
      : super(const SystemTabState(selectedTab: SystemTab.dashboard));

  final panels = <Widget>[
    Container(),
    Container(),
    Container(),
    const Department(),
  ];

  void onTabChanged(SystemTab tab) => emit(SystemTabState(selectedTab: tab));
}
