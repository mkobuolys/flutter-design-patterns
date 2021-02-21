import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/data/models/design_pattern.dart';
import 'package:flutter_design_patterns/data/models/design_pattern_category.dart';
import 'package:flutter_design_patterns/pages/category/category_page.dart';
import 'package:flutter_design_patterns/pages/design_pattern_details/design_pattern_details_page.dart';
import 'package:flutter_design_patterns/pages/main_menu/main_menu_page.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/index.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainMenuPage.route:
        return MaterialPageRoute(
          builder: (_) => MainMenuPage(),
        );
      case CategoryPage.route:
        final category = settings.arguments as DesignPatternCategory;

        return MaterialPageRoute(
          builder: (_) => CategoryPage(
            category: category,
          ),
        );
      // Creational
      case _DesignPatternRoutes.abstractFactoryRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          AbstractFactoryExample(),
        );
      case _DesignPatternRoutes.builderRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          BuilderExample(),
        );
      case _DesignPatternRoutes.factoryMethodRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          FactoryMethodExample(),
        );
      case _DesignPatternRoutes.prototypeRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          PrototypeExample(),
        );
      case _DesignPatternRoutes.singletonRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          SingletonExample(),
        );
      // Structural
      case _DesignPatternRoutes.adapterRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          AdapterExample(),
        );
      case _DesignPatternRoutes.bridgeRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          BridgeExample(),
        );
      case _DesignPatternRoutes.compositeRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          CompositeExample(),
        );
      case _DesignPatternRoutes.decoratorRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          DecoratorExample(),
        );
      case _DesignPatternRoutes.facadeRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          FacadeExample(),
        );
      case _DesignPatternRoutes.flyweightRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          FlyweightExample(),
        );
      case _DesignPatternRoutes.proxyRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          ProxyExample(),
        );
      // Behavioral
      case _DesignPatternRoutes.chainOfResponsibilityRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          ChainOfResponsibilityExample(),
        );
      case _DesignPatternRoutes.commandRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          CommandExample(),
        );
      case _DesignPatternRoutes.interpreterRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          InterpreterExample(),
        );
      case _DesignPatternRoutes.iteratorRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          IteratorExample(),
        );
      case _DesignPatternRoutes.mementoRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          MementoExample(),
        );
      case _DesignPatternRoutes.stateRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          StateExample(),
        );
      case _DesignPatternRoutes.strategyRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          StrategyExample(),
        );
      case _DesignPatternRoutes.templateMethodRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          TemplateMethodExample(),
        );
      case _DesignPatternRoutes.visitorRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          VisitorExample(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => MainMenuPage(),
        );
    }
  }

  static MaterialPageRoute _buildDesignPatternDetailsPageRoute(
    RouteSettings settings,
    Widget example,
  ) {
    final designPattern = settings.arguments as DesignPattern;

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
  static const String mementoRoute = '/memento';
  static const String prototypeRoute = '/prototype';
  static const String proxyRoute = '/proxy';
  static const String singletonRoute = '/singleton';
  static const String stateRoute = '/state';
  static const String strategyRoute = '/strategy';
  static const String templateMethodRoute = '/template-method';
  static const String visitorRoute = '/visitor';
}
