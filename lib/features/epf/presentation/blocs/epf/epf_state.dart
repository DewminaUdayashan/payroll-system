part of 'epf_cubit.dart';

abstract class EpfState extends Equatable {
  const EpfState();

  @override
  List<Object?> get props => [];
}

class EpfLoading extends EpfState {
  @override
  List<Object?> get props => [];
}

class EpfError extends EpfState {
  final String? message;
  final int? code;

  const EpfError({this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

class EpfLoaded extends EpfState {
  const EpfLoaded(this.epfs);
  final List<EPF> epfs;

  @override
  List<Object?> get props => [epfs];
}
