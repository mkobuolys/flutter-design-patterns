import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/data/models/design_pattern.dart';
import 'package:flutter_design_patterns/data/models/design_pattern_category.dart';
import 'package:flutter_design_patterns/screens/category/category.dart';
import 'package:flutter_design_patterns/screens/design_pattern_details/design_pattern_details.dart';
import 'package:flutter_design_patterns/screens/main_menu/main_menu.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/abstract_factory/abstract_factory_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/adapter/adapter_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/command/command_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/composite/composite_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/decorator/decorator_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/facade/facade_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/factory_method/factory_method_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/interpreter/interpreter_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/iterator/iterator_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/memento/memento_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/prototype/prototype_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/proxy/proxy_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/singleton/singleton_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/state/state_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/strategy/strategy_example.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/template_method/template_method_example.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (_) => MainMenu(),
        );
      case categoryRoute:
        var category = settings.arguments as DesignPatternCategory;
        return MaterialPageRoute(
          builder: (_) => Category(
            category: category,
          ),
        );
      // Creational
      case _DesignPatternRoutes.abstractFactoryRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          AbstractFactoryExample(),
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
      case _DesignPatternRoutes.proxyRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          ProxyExample(),
        );
      // Behavioral
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
      default:
        return MaterialPageRoute(
          builder: (_) => MainMenu(),
        );
    }
  }

  static MaterialPageRoute _buildDesignPatternDetailsPageRoute(
    RouteSettings settings,
    Widget example,
  ) {
    var designPattern = settings.arguments as DesignPattern;
    return MaterialPageRoute(
      builder: (_) => DesignPatternDetails(
        designPattern: designPattern,
        example: example,
      ),
    );
  }
}

class _DesignPatternRoutes {
  static const String abstractFactoryRoute = '/abstract-factory';
  static const String adapterRoute = '/adapter';
  static const String commandRoute = '/command';
  static const String compositeRoute = '/composite';
  static const String decoratorRoute = '/decorator';
  static const String facadeRoute = '/facade';
  static const String factoryMethodRoute = '/factory-method';
  static const String interpreterRoute = '/interpreter';
  static const String iteratorRoute = '/iterator';
  static const String mementoRoute = '/memento';
  static const String prototypeRoute = '/prototype';
  static const String proxyRoute = '/proxy';
  static const String singletonRoute = '/singleton';
  static const String stateRoute = '/state';
  static const String strategyRoute = '/strategy';
  static const String templateMethodRoute = '/template-method';
}
