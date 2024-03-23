import 'package:flutter/material.dart';
import 'package:flutter_english_study/config/routes/route_names.dart';
import 'package:flutter_english_study/features/auth/views/sign_in.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const SignIn());
      case RouteNames.signIn:
        return _materialRoute(const SignIn());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
