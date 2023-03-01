import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'pages/pages.dart';

part 'router.g.dart';

@riverpod
GoRouter router(_) => GoRouter(
      routes: $appRoutes,
      redirect: (context, state) =>
          state.location.isEmpty ? const MainMenuRoute().location : null,
    );

@TypedGoRoute<MainMenuRoute>(
  path: '/',
  routes: [
    TypedGoRoute<DesignPatternDetailsRoute>(path: 'pattern/:id'),
  ],
)
@immutable
class MainMenuRoute extends GoRouteData {
  const MainMenuRoute();

  @override
  Widget build(_, __) => const MainMenuPage();
}

@immutable
class DesignPatternDetailsRoute extends GoRouteData {
  const DesignPatternDetailsRoute(this.id);

  final String id;

  @override
  Widget build(_, __) => DesignPatternDetailsPage(id: id);
}
