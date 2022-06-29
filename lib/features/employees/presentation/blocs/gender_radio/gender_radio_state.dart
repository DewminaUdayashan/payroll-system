part of 'gender_radio_cubit.dart';

class GenderRadioState extends Equatable {
  const GenderRadioState({this.gender = Gender.notSelected});
  final Gender gender;
  @override
  List<Object> get props => [gender];
}
