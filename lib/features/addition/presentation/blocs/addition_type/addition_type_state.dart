part of 'addition_type_cubit.dart';

class AdditionTypeState extends Equatable {
  const AdditionTypeState({this.type});
  final AdditionType? type;

  @override
  List<Object?> get props => [type];
}
