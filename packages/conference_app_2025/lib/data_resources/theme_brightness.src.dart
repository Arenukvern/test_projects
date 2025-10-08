import 'package:flutter/material.dart';

/// {@template theme_brightness_resource}
/// Resource for managing theme brightness/mode across the application.
///
/// Supports light, dark, and system modes.
///
/// Example:
/// ```dart
/// // Set light mode
/// themeBrightnessResource.setLightMode();
///
/// // Set dark mode
/// themeBrightnessResource.setDarkMode();
///
/// // Use system mode
/// themeBrightnessResource.setSystemMode();
///
/// // Check current mode
/// final isLight = themeBrightnessResource.isLightMode;
/// ```
/// {@endtemplate}
class ThemeBrightnessResource extends ValueNotifier<ThemeMode> {
  /// {@macro theme_brightness_resource}
  ThemeBrightnessResource([super.initial = ThemeMode.system]);

  /// Set light mode
  void setLightMode() => value = ThemeMode.light;

  /// Set dark mode
  void setDarkMode() => value = ThemeMode.dark;

  /// Set system mode (follows device settings)
  void setSystemMode() => value = ThemeMode.system;

  /// Toggle between light and dark modes
  void toggle() =>
      value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

  /// Check if currently in light mode
  bool get isLightMode => value == ThemeMode.light;

  /// Check if currently in dark mode
  bool get isDarkMode => value == ThemeMode.dark;

  /// Check if using system mode
  bool get isSystemMode => value == ThemeMode.system;
}
