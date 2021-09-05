import 'package:flutter/material.dart';

import 'navigation/router.dart';
import 'themes.dart';

class App extends StatelessWidget {
  final router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Design Patterns',
      theme: lightTheme,
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}
