import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/data/models/design_pattern.dart';
import 'package:flutter_design_patterns/data/models/design_pattern_category.dart';
import 'package:flutter_design_patterns/screens/category/category.dart';
import 'package:flutter_design_patterns/screens/design_pattern_details/design_pattern_details.dart';
import 'package:flutter_design_patterns/screens/main_menu/main_menu.dart';
import 'package:flutter_design_patterns/widgets/introduction/introduction.dart';

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
      case _DesignPatternRoutes.introductionRoute:
        var designPattern = settings.arguments as DesignPattern;
        return MaterialPageRoute(
          builder: (_) => DesignPatternDetails(
            designPattern: designPattern,
            example: Introduction(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => MainMenu(),
        );
    }
  }
}

class _DesignPatternRoutes {
  static const String introductionRoute = '/introduction';
}
