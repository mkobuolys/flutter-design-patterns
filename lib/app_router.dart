import 'package:flutter/material.dart';

import 'data/models/design_pattern.dart';
import 'navigation/pages/pages.dart';
import 'navigation/router.dart';
import 'widgets/design_patterns/index.dart';

class AppRouter {
  static const mainMenuPageRoute = '/';

  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainMenuPageRoute:
        return MaterialPageRoute(
          builder: (_) => const MainMenuPage(),
        );
      // Creational
      case DesignPatternRoutes.abstractFactoryRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const AbstractFactoryExample(),
        );
      case DesignPatternRoutes.builderRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const BuilderExample(),
        );
      case DesignPatternRoutes.factoryMethodRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const FactoryMethodExample(),
        );
      case DesignPatternRoutes.prototypeRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const PrototypeExample(),
        );
      case DesignPatternRoutes.singletonRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const SingletonExample(),
        );
      // Structural
      case DesignPatternRoutes.adapterRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const AdapterExample(),
        );
      case DesignPatternRoutes.bridgeRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const BridgeExample(),
        );
      case DesignPatternRoutes.compositeRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const CompositeExample(),
        );
      case DesignPatternRoutes.decoratorRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const DecoratorExample(),
        );
      case DesignPatternRoutes.facadeRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const FacadeExample(),
        );
      case DesignPatternRoutes.flyweightRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const FlyweightExample(),
        );
      case DesignPatternRoutes.proxyRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const ProxyExample(),
        );
      // Behavioral
      case DesignPatternRoutes.chainOfResponsibilityRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const ChainOfResponsibilityExample(),
        );
      case DesignPatternRoutes.commandRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const CommandExample(),
        );
      case DesignPatternRoutes.interpreterRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const InterpreterExample(),
        );
      case DesignPatternRoutes.iteratorRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const IteratorExample(),
        );
      case DesignPatternRoutes.mediatorRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const MediatorExample(),
        );
      case DesignPatternRoutes.mementoRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const MementoExample(),
        );
      case DesignPatternRoutes.observerRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const ObserverExample(),
        );
      case DesignPatternRoutes.stateRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const StateExample(),
        );
      case DesignPatternRoutes.strategyRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const StrategyExample(),
        );
      case DesignPatternRoutes.templateMethodRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const TemplateMethodExample(),
        );
      case DesignPatternRoutes.visitorRoute:
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
        title: settings.name!,
        designPattern: designPattern,
        example: example,
      ),
    );
  }
}
