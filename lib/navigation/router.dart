import 'package:auto_route/annotations.dart';

import 'pages/pages.dart';

export 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: MainMenuPage, initial: true),
    AutoRoute(path: '/pattern/:id', page: DesignPatternDetailsPage),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class $AppRouter {}
