part of 'designations_cubit.dart';

abstract class DesignationsState extends Equatable {
  const DesignationsState();

  @override
  List<Object> get props => [];
}

class DesignationsLoading extends DesignationsState {}

class DesignationsLoaded extends DesignationsState {
  final List<Designation> designations;

  const DesignationsLoaded({required this.designations});

  @override
  List<Object> get props => [designations];
}

class DesignationsError extends DesignationsState {
  final String message;

  const DesignationsError({required this.message});

  @override
  List<Object> get props => [message];
}
