import 'package:flutter/material.dart';

import 'navigation/router.dart';
import 'themes.dart';

class App extends StatelessWidget {
  final router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Design Patterns App',
      theme: lightTheme,
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}
