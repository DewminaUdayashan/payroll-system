import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:payroll_system/core/shared/app_router.dart';
import '../blocs/bloc/session_bloc.dart';
import 'widgets/login_panel.dart';

import '../../../../core/shared/assets_paths.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-1, 0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  ));

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionBloc, SessionState>(
      listener: (context, state) {
        if (state is SessionStarted) {
          Navigator.of(context).pushReplacementNamed(Routes.system.name);
        }
      },
      child: Scaffold(
          body: Row(
        children: [
          SlideTransition(
            position: _offsetAnimation,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height,
              child: const LoginPanel(),
            ),
          ),
          Expanded(child: Lottie.asset(welcomeGif)),
        ],
      )),
    );
  }
}
