// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import 'pages/pages.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    MainMenuRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.MainMenuPage(),
      );
    },
    DesignPatternDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DesignPatternDetailsRouteArgs>(
          orElse: () =>
              DesignPatternDetailsRouteArgs(id: pathParams.getString('id')));
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.DesignPatternDetailsPage(id: args.id),
      );
    },
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(
          MainMenuRoute.name,
          path: '/',
        ),
        _i2.RouteConfig(
          DesignPatternDetailsRoute.name,
          path: '/pattern/:id',
        ),
        _i2.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.MainMenuPage]
class MainMenuRoute extends _i2.PageRouteInfo<void> {
  const MainMenuRoute()
      : super(
          MainMenuRoute.name,
          path: '/',
        );

  static const String name = 'MainMenuRoute';
}

/// generated route for
/// [_i1.DesignPatternDetailsPage]
class DesignPatternDetailsRoute
    extends _i2.PageRouteInfo<DesignPatternDetailsRouteArgs> {
  DesignPatternDetailsRoute({required String id})
      : super(
          DesignPatternDetailsRoute.name,
          path: '/pattern/:id',
          args: DesignPatternDetailsRouteArgs(id: id),
          rawPathParams: {'id': id},
        );

  static const String name = 'DesignPatternDetailsRoute';
}

class DesignPatternDetailsRouteArgs {
  const DesignPatternDetailsRouteArgs({required this.id});

  final String id;

  @override
  String toString() {
    return 'DesignPatternDetailsRouteArgs{id: $id}';
  }
}
