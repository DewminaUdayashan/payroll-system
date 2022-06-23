import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/login/domain/usecases/login.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final Login _login;
  SessionBloc(this._login) : super(SessionInitial()) {
    on<SessionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
