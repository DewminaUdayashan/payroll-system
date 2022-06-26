part of 'system_tab_cubit.dart';

class SystemTabState extends Equatable {
  const SystemTabState({required this.selectedTab});
  final SystemTab selectedTab;
  @override
  List<Object> get props => [selectedTab];
}
