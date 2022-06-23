part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  const SessionState();
  
  @override
  List<Object> get props => [];
}

class SessionInitial extends SessionState {}
