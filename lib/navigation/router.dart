import 'package:auto_route/annotations.dart';

import 'pages/pages.dart';

export 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: MainMenuPage, initial: true),
    AutoRoute(path: '/pattern/:id', page: DesignPatternDetailsPage),
  ],
)
class $AppRouter {}

class DesignPatternRoutes {
  static const String abstractFactoryRoute = '/abstract-factory';
  static const String adapterRoute = '/adapter';
  static const String bridgeRoute = '/bridge';
  static const String builderRoute = '/builder';
  static const String chainOfResponsibilityRoute = '/chain-of-responsibility';
  static const String commandRoute = '/command';
  static const String compositeRoute = '/composite';
  static const String decoratorRoute = '/decorator';
  static const String facadeRoute = '/facade';
  static const String factoryMethodRoute = '/factory-method';
  static const String flyweightRoute = '/flyweight';
  static const String interpreterRoute = '/interpreter';
  static const String iteratorRoute = '/iterator';
  static const String mediatorRoute = '/mediator';
  static const String mementoRoute = '/memento';
  static const String observerRoute = '/observer';
  static const String prototypeRoute = '/prototype';
  static const String proxyRoute = '/proxy';
  static const String singletonRoute = '/singleton';
  static const String stateRoute = '/state';
  static const String strategyRoute = '/strategy';
  static const String templateMethodRoute = '/template-method';
  static const String visitorRoute = '/visitor';
}
