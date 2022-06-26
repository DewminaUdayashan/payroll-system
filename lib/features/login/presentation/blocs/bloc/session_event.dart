part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

class TryToLogin extends SessionEvent {
  final Credentials credentials;
  final BuildContext context;

  const TryToLogin({required this.credentials, required this.context});

  @override
  List<Object> get props => [credentials];
}
