import 'package:conference_app_2025/ui_kit/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// {@template app_colors_extension}
/// Theme extension providing access to custom app colors
/// that are not part of Material Design color scheme.
/// {@endtemplate}
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  /// {@macro app_colors_extension}
  const AppColorsExtension({
    required this.grey,
    required this.red,
    required this.yellow,
    required this.orange,
    required this.gradientYellow,
    required this.gradientOrange,
    required this.gradientRed,
  });

  final Color grey;
  final Color red;
  final Color yellow;
  final Color orange;
  final Color gradientYellow;
  final Color gradientOrange;
  final Color gradientRed;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    final Color? grey,
    final Color? red,
    final Color? yellow,
    final Color? orange,
    final Color? gradientYellow,
    final Color? gradientOrange,
    final Color? gradientRed,
  }) => AppColorsExtension(
    grey: grey ?? this.grey,
    red: red ?? this.red,
    yellow: yellow ?? this.yellow,
    orange: orange ?? this.orange,
    gradientYellow: gradientYellow ?? this.gradientYellow,
    gradientOrange: gradientOrange ?? this.gradientOrange,
    gradientRed: gradientRed ?? this.gradientRed,
  );

  @override
  ThemeExtension<AppColorsExtension> lerp(
    final ThemeExtension<AppColorsExtension>? other,
    final double t,
  ) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      grey: Color.lerp(grey, other.grey, t)!,
      red: Color.lerp(red, other.red, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      gradientYellow: Color.lerp(gradientYellow, other.gradientYellow, t)!,
      gradientOrange: Color.lerp(gradientOrange, other.gradientOrange, t)!,
      gradientRed: Color.lerp(gradientRed, other.gradientRed, t)!,
    );
  }
}

/// {@template app_theme}
/// Provides Material 3 theme configurations for the application.
///
/// Supports both light and dark themes with custom color extensions.
/// Use [light] for light mode and [dark] for dark mode.
///
/// Example:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.light(),
///   darkTheme: AppTheme.dark(),
///   themeMode: ThemeMode.system,
/// )
/// ```
/// {@endtemplate}
class AppTheme {
  /// {@macro app_theme}
  const AppTheme._();

  /// Light theme configuration with Material 3 design
  static ThemeData light() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seedColor),
    textTheme: Typography.blackHelsinki,
    extensions: const [
      AppColorsExtension(
        grey: AppColors.grey,
        red: AppColors.red,
        yellow: AppColors.yellow,
        orange: AppColors.orange,
        gradientYellow: AppColors.gradientYellow,
        gradientOrange: AppColors.gradientOrange,
        gradientRed: AppColors.gradientRed,
      ),
    ],
  );

  /// Dark theme configuration with Material 3 design
  static ThemeData dark() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.seedColor,
      brightness: Brightness.dark,
    ),
    textTheme: Typography.whiteHelsinki,
    scaffoldBackgroundColor: AppColors.background,
    extensions: const [
      AppColorsExtension(
        grey: AppColors.grey,
        red: AppColors.red,
        yellow: AppColors.yellow,
        orange: AppColors.orange,
        gradientYellow: AppColors.gradientYellow,
        gradientOrange: AppColors.gradientOrange,
        gradientRed: AppColors.gradientRed,
      ),
    ],
  );
}

/// Extension on [BuildContext] to easily access custom app colors
extension AppColorsContext on BuildContext {
  /// Access custom app colors from theme extensions
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>()!;
}
