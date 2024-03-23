import 'package:flutter/material.dart';
import 'package:flutter_english_study/config/routes/route_names.dart';

import 'config/routes/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RouteNames.signIn,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
