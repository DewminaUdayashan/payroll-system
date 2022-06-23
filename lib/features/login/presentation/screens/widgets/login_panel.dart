import 'package:flutter/material.dart';

import '../../../../../core/shared/border_radiuses.dart';
import '../../../../../core/shared/paddings.dart';
import '../../../../../core/shared/strings.dart';

class LoginPanel extends StatelessWidget {
  const LoginPanel({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final name = TextEditingController();
    final password = TextEditingController();
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
              style: Theme.of(context).textTheme.displaySmall,
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
            Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 4,
              color: Colors.white,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: 'Enter user name',
                          label: Text(
                            'User Name',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          contentPadding: loginTFPadding,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter password',
                          label: Text(
                            'Password',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          contentPadding: loginTFPadding,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                    if (formKey.currentState!.validate()) {}
                  },
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: hundredBoarderRadius,
                      color: Theme.of(context).canvasColor,
                    ),
                    child: Text(
                      login,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Colors.white,
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
