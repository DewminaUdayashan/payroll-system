part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class SessionInitial extends SessionState {}

class SessionStarted extends SessionState {
  final SystemUser systemUser;

  const SessionStarted({required this.systemUser});

  @override
  List<Object> get props => [systemUser];
}
