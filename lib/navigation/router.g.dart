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

  void replace(BuildContext context) => context.replace(location);
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

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerHash() => r'7aea5ccfc73a19a14afda1df517396c9a3ca6182';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouterRef = AutoDisposeProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
