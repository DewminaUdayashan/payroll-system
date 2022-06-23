import 'package:flutter/material.dart';

import '../../features/login/presentation/screens/login.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const Login());
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
  dashboard,
}

extension RouteName on Routes {
  String get name {
    switch (this) {
      case Routes.login:
        return '/login';
      case Routes.dashboard:
        return '/dashboard';
      default:
        return '';
    }
  }
}
