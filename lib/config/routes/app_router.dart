import 'package:flutter/material.dart';
import 'package:flutter_english_study/config/routes/route_names.dart';
import 'package:flutter_english_study/features/auth/views/sign_in.dart';
import 'package:flutter_english_study/features/auth/views/sign_up.dart';
import 'package:flutter_english_study/features/group/views/create_group.dart';
import 'package:flutter_english_study/features/group/views/group_details.dart';
import 'package:flutter_english_study/features/group/views/group_list.dart';
import 'package:flutter_english_study/features/home/views/home.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const SignIn());
      case RouteNames.signIn:
        return _materialRoute(const SignIn());
      case RouteNames.signUp:
        return _materialRoute(const SignUp());
      case RouteNames.home:
        return _materialRoute(const Home());
      case RouteNames.createGroup:
        return _materialRoute(const CreateGroup());
      case RouteNames.groupList:
        final args = settings.arguments as Map<String, dynamic>;
        final area = args['area'];
        return _materialRoute(
          GroupList(
            area: area,
          ),
        );
      case RouteNames.groupDetail:
        final args = settings.arguments as Map<String, dynamic>;
        final groupUid = args['groupUid'];
        return _materialRoute(
          GroupDetail(
            groupUid: groupUid,
          ),
        );
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
