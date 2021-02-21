import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_router.dart';
import 'pages/main_menu/main_menu_page.dart';
import 'themes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Design Patterns App',
      theme: lightTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: MainMenuPage.route,
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(App());
}
