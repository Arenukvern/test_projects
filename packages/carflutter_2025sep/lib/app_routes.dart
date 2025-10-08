import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// {@template app_route}
/// Enum-based type-safe routing for the application
///
/// Provides centralized route definitions with path and name properties,
/// along with convenient navigation methods.
/// {@endtemplate}
enum AppRoute {
  /// Home screen route
  home('/home', 'home'),

  /// Vehicle room screen route
  vehicleRoom('/vehicle-room', 'vehicle-room');

  /// {@macro app_route}
  const AppRoute(this.path, this.name);

  /// The path for this route
  final String path;

  /// The name for this route
  final String name;
}

/// {@template app_route_navigation}
/// Extension providing navigation methods for AppRoute enum
///
/// Enables type-safe navigation using enum values instead of hardcoded strings.
/// {@endtemplate}
extension AppRouteNavigation on AppRoute {
  /// Navigate to this route using go()
  void go(final BuildContext context) => context.go(path);

  /// Navigate to this route using push()
  Future<void> push(final BuildContext context) => context.push(path);

  /// Navigate to this route using goNamed()
  void goNamed(
    final BuildContext context, {
    final Map<String, String> pathParameters = const {},
    final Map<String, dynamic> queryParameters = const {},
    final Object? extra,
  }) => context.goNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );

  /// Navigate to this route using pushNamed()
  Future<void> pushNamed(
    final BuildContext context, {
    final Map<String, String> pathParameters = const {},
    final Map<String, dynamic> queryParameters = const {},
    final Object? extra,
  }) => context.pushNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );
}
