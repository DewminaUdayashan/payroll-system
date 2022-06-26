import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/core/error/failure.dart';
import 'package:payroll_system/core/network/api.dart';
import 'package:payroll_system/core/shared/dialogs.dart';
import 'package:payroll_system/features/login/domain/entities/system_user.dart';
import 'package:payroll_system/features/login/domain/usecases/login.dart';
import 'package:payroll_system/features/login/presentation/shared/snacks.dart';

import '../../../domain/entities/credentials.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final Login _login;
  SessionBloc(this._login) : super(SessionInitial()) {
    on<SessionEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
      SessionEvent event, Emitter<SessionState> emit) async {
    if (event is TryToLogin) {
      await _tryLogin(event, emit);
    }
  }

  Future<void> _tryLogin(TryToLogin event, Emitter<SessionState> emit) async {
    ///show loading
    showLoadingDialog(event.context);
    await _login(event.credentials).then((result) {
      result.fold((failure) {
        /// close loading
        Navigator.pop(event.context);

        /// if error occured, we will recieve a [Failure] object
        /// if it was a wrong credentials, we will recieve a [LoginFaiure] object
        if (failure is LoginFaiure) {
          showLoginFailedSnack(event.context, failure.message);
        } else if (failure is ApiFailure) {
          /// if it was a other error, we will recieve a [ApiFailure] object
          showLoginFailedSnack(event.context, failure.message);
        } else {
          showLoginFailedSnack(event.context, failure.toString());
        }
      }, (systemUser) {
        /// if it was a success, we will recieve a [SystemUser] object
        /// we will set the token to the API
        /// we will set the [SystemUser] object to the [SessionState] object
        /// and emit it to the bloc
        API.bearerToken = systemUser.token ?? '';

        /// [Login] UI will listen for this emit and it will navigate
        /// the user to the dashboard page
        emit(SessionStarted(systemUser: systemUser));
      });
    });
  }
}
