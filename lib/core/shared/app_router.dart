import 'package:flutter/material.dart';
import 'package:payroll_system/features/system/presentation/pages/system.dart';

import '../../features/login/presentation/screens/login.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const Login());
      case '/system':
        return MaterialPageRoute(builder: (_) => const System());
      // case '/login':
      //   return MaterialPageRoute(builder: (_) => const Login());
      // case '/splash':
      //   return MaterialPageRoute(builder: (_) => const Splash());
      default:
        return null;
    }
  }
}

enum Routes {
  login,
  system,
}

extension RouteName on Routes {
  String get name {
    switch (this) {
      case Routes.login:
        return '/login';
      case Routes.system:
        return '/system';
      default:
        return '';
    }
  }
}
