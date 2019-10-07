import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/router.dart';
import 'package:flutter_design_patterns/themes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Design Patterns App',
      theme: lightTheme,
      onGenerateRoute: Router.generateRoute,
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() => runApp(App());
