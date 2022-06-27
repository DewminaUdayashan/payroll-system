// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'system_tab_cubit.dart';

class SystemTabState extends Equatable {
  const SystemTabState({required this.selectedTab, this.selectedSecondaryTab});
  final SystemTab selectedTab;
  final SecondaryTab? selectedSecondaryTab;
  @override
  List<Object?> get props => [selectedTab, selectedSecondaryTab];

  SystemTabState copyWith({
    SystemTab? selectedTab,
    SecondaryTab? selectedSecondaryTab,
  }) {
    return SystemTabState(
      selectedTab: selectedTab ?? this.selectedTab,
      selectedSecondaryTab: selectedSecondaryTab ?? this.selectedSecondaryTab,
    );
  }
}
