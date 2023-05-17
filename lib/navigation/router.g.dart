// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $mainMenuRoute,
    ];

RouteBase get $mainMenuRoute => GoRouteData.$route(
      path: '/',
      factory: $MainMenuRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'pattern/:id',
          factory: $DesignPatternDetailsRouteExtension._fromState,
        ),
      ],
    );

extension $MainMenuRouteExtension on MainMenuRoute {
  static MainMenuRoute _fromState(GoRouterState state) => const MainMenuRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $DesignPatternDetailsRouteExtension on DesignPatternDetailsRoute {
  static DesignPatternDetailsRoute _fromState(GoRouterState state) =>
      DesignPatternDetailsRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/pattern/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerHash() => r'ad2e290396c92a7229e87dc91b315b4471fe6b4c';

/// See also [router].
@ProviderFor(router)
final routerProvider = AutoDisposeProvider<GoRouter>.internal(
  router,
  name: r'routerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$routerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RouterRef = AutoDisposeProviderRef<GoRouter>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
