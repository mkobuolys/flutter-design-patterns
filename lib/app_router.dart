import 'package:flutter/material.dart';

import 'data/models/design_pattern.dart';
import 'pages/design_pattern_details/design_pattern_details_page.dart';
import 'pages/main_menu/main_menu_page.dart';
import 'widgets/design_patterns/index.dart';

class AppRouter {
  static const mainMenuPageRoute = '/main-menu';

  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainMenuPageRoute:
        return MaterialPageRoute(
          builder: (_) => const MainMenuPage(),
        );
      // Creational
      case _DesignPatternRoutes.abstractFactoryRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const AbstractFactoryExample(),
        );
      case _DesignPatternRoutes.builderRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const BuilderExample(),
        );
      case _DesignPatternRoutes.factoryMethodRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const FactoryMethodExample(),
        );
      case _DesignPatternRoutes.prototypeRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const PrototypeExample(),
        );
      case _DesignPatternRoutes.singletonRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const SingletonExample(),
        );
      // Structural
      case _DesignPatternRoutes.adapterRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const AdapterExample(),
        );
      case _DesignPatternRoutes.bridgeRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const BridgeExample(),
        );
      case _DesignPatternRoutes.compositeRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const CompositeExample(),
        );
      case _DesignPatternRoutes.decoratorRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const DecoratorExample(),
        );
      case _DesignPatternRoutes.facadeRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const FacadeExample(),
        );
      case _DesignPatternRoutes.flyweightRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const FlyweightExample(),
        );
      case _DesignPatternRoutes.proxyRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const ProxyExample(),
        );
      // Behavioral
      case _DesignPatternRoutes.chainOfResponsibilityRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const ChainOfResponsibilityExample(),
        );
      case _DesignPatternRoutes.commandRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const CommandExample(),
        );
      case _DesignPatternRoutes.interpreterRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const InterpreterExample(),
        );
      case _DesignPatternRoutes.iteratorRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const IteratorExample(),
        );
      case _DesignPatternRoutes.mediatorRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const MediatorExample(),
        );
      case _DesignPatternRoutes.mementoRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const MementoExample(),
        );
      case _DesignPatternRoutes.observerRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const ObserverExample(),
        );
      case _DesignPatternRoutes.stateRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const StateExample(),
        );
      case _DesignPatternRoutes.strategyRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const StrategyExample(),
        );
      case _DesignPatternRoutes.templateMethodRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const TemplateMethodExample(),
        );
      case _DesignPatternRoutes.visitorRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const VisitorExample(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const MainMenuPage(),
        );
    }
  }

  static MaterialPageRoute _buildDesignPatternDetailsPageRoute(
    RouteSettings settings,
    Widget example,
  ) {
    final designPattern = settings.arguments! as DesignPattern;

    return MaterialPageRoute(
      builder: (_) => DesignPatternDetailsPage(
        designPattern: designPattern,
        example: example,
      ),
    );
  }
}

class _DesignPatternRoutes {
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
