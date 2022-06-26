import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll_system/core/shared/extentions.dart';

import '../../../../../../core/shared/assets_paths.dart';
import '../../../../../login/presentation/blocs/bloc/session_bloc.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Row(
        children: [
          Image.asset(logoUrl),
          const SizedBox(width: 5),
          BlocBuilder<SessionBloc, SessionState>(
            builder: (context, state) {
              final currentState = state as SessionStarted;
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentState.systemUser.name.toFirstLetterUpper(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    currentState.systemUser.roleId.toRoleName(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
