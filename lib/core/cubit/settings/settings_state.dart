part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.daysToCalculate = 25,
    this.epfRate = 8,
    this.comContEpfRate = 12,
    this.etfRate = 3,
  });
  final int daysToCalculate;
  final int epfRate;
  final int comContEpfRate;
  final int etfRate;

  @override
  List<Object> get props => [
        daysToCalculate,
        epfRate,
        comContEpfRate,
        etfRate,
      ];
}
