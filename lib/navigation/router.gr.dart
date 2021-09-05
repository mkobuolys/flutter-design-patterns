// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;
import 'package:flutter/widgets.dart' as _i5;

import '../data/models/design_pattern.dart' as _i4;
import 'pages/pages.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MainMenuRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.MainMenuPage();
        }),
    DesignPatternDetailsRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<DesignPatternDetailsRouteArgs>();
          return _i3.DesignPatternDetailsPage(
              id: args.id,
              designPattern: args.designPattern,
              example: args.example);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MainMenuRoute.name, path: '/'),
        _i1.RouteConfig(DesignPatternDetailsRoute.name, path: '/pattern/:id'),
        _i1.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

class MainMenuRoute extends _i1.PageRouteInfo {
  const MainMenuRoute() : super(name, path: '/');

  static const String name = 'MainMenuRoute';
}

class DesignPatternDetailsRoute
    extends _i1.PageRouteInfo<DesignPatternDetailsRouteArgs> {
  DesignPatternDetailsRoute(
      {required String id,
      required _i4.DesignPattern designPattern,
      required _i5.Widget example})
      : super(name,
            path: '/pattern/:id',
            args: DesignPatternDetailsRouteArgs(
                id: id, designPattern: designPattern, example: example),
            rawPathParams: {'id': id});

  static const String name = 'DesignPatternDetailsRoute';
}

class DesignPatternDetailsRouteArgs {
  const DesignPatternDetailsRouteArgs(
      {required this.id, required this.designPattern, required this.example});

  final String id;

  final _i4.DesignPattern designPattern;

  final _i5.Widget example;
}
