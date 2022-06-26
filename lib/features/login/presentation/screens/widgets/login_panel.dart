import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/login/domain/entities/credentials.dart';

import '../../../../../core/shared/border_radiuses.dart';
import '../../../../../core/shared/paddings.dart';
import '../../../../../core/shared/strings.dart';
import '../../blocs/bloc/session_bloc.dart';

class LoginPanel extends StatefulWidget {
  const LoginPanel({Key? key}) : super(key: key);

  @override
  State<LoginPanel> createState() => _LoginPanelState();
}

class _LoginPanelState extends State<LoginPanel> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController(text: 'admin');
  final password = TextEditingController(text: 'admin');

  @override
  void dispose() {
    name.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              login,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              loginDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Divider(),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                      hintText: 'Enter user name',
                      label: Text(
                        'User Name',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      contentPadding: loginTFPadding,
                    ),
                    validator: (String? str) {
                      if (str == null || str.isEmpty) {
                        return 'Please enter user name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      hintText: 'Enter password',
                      label: Text(
                        'Password',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      contentPadding: loginTFPadding,
                    ),
                    validator: (String? str) {
                      if (str == null || str.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Divider(),
            Center(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: hundredBoarderRadius,
                  splashColor: Colors.blueAccent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      context.read<SessionBloc>().add(
                            TryToLogin(
                              credentials: Credentials(
                                name: name.text,
                                password: String.fromCharCodes(
                                    password.text.codeUnits),
                              ),
                              context: context,
                            ),
                          );
                    }
                  },
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: hundredBoarderRadius,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      login,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  needLoginSupport,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  '  $clickHere',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
