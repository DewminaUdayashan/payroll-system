part of 'addition_cubit.dart';

abstract class AdditionState extends Equatable {
  const AdditionState();

  @override
  List<Object> get props => [];
}

class AdditionsLoading extends AdditionState {}

class AdditionsError extends AdditionState {}

class AdditionsLoaded extends AdditionState {
  final List<Addition> additions;

  const AdditionsLoaded({required this.additions});

  @override
  List<Object> get props => [additions];
}
