import 'package:flutter/material.dart';

/// {@template ui_button_decoration}
/// Immutable decoration configuration for styled buttons.
///
/// Provides static factory methods for common button styles
/// aligned with Material 3 design patterns.
///
/// Example:
/// ```dart
/// // Use predefined style
/// UiButton(
///   decoration: UiButtonDecoration.filled,
///   text: 'Submit',
///   onPressed: () {},
/// )
///
/// // Create custom style
/// UiButton(
///   decoration: UiButtonDecoration.create(
///     backgroundColor: Colors.blue,
///     padding: EdgeInsets.all(16),
///   ),
///   text: 'Custom',
///   onPressed: () {},
/// )
/// ```
/// {@endtemplate}
class UiButtonDecoration {
  /// {@macro ui_button_decoration}
  const UiButtonDecoration._({
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.gradient,
    this.variant,
  });

  /// {@macro ui_button_decoration}
  factory UiButtonDecoration.create({
    final EdgeInsets? padding,
    final Color? backgroundColor,
    final Color? foregroundColor,
    final BorderRadius? borderRadius,
    final Border? border,
    final List<BoxShadow>? boxShadow,
    final Gradient? gradient,
    final String? variant,
  }) => UiButtonDecoration._(
    padding: padding,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    borderRadius: borderRadius,
    border: border,
    boxShadow: boxShadow,
    gradient: gradient,
    variant: variant,
  );

  /// Padding inside the button
  final EdgeInsets? padding;

  /// Background color (ignored if gradient is set)
  final Color? backgroundColor;

  /// Text and icon color
  final Color? foregroundColor;

  /// Border radius for rounded corners
  final BorderRadius? borderRadius;

  /// Border styling
  final Border? border;

  /// Shadow effects
  final List<BoxShadow>? boxShadow;

  /// Gradient background (overrides backgroundColor)
  final Gradient? gradient;

  /// Style variant identifier
  final String? variant;

  /// Filled button style (Material 3 default)
  ///
  /// Uses theme primary color for background
  static final filled = UiButtonDecoration.create(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    borderRadius: const BorderRadius.all(Radius.circular(20)),
  );

  /// Outlined button style
  ///
  /// Transparent background with theme-colored border
  static const outlined = UiButtonDecoration._(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    backgroundColor: Colors.transparent,
    variant: 'outlined',
  );

  /// Text button style with minimal decoration
  static const text = UiButtonDecoration._(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    backgroundColor: Colors.transparent,
    variant: 'text',
  );

  /// Gradient button style with app gradient colors
  ///
  /// Note: Gradient colors are resolved from theme at build time
  static const gradientStyle = UiButtonDecoration._(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    variant: 'gradient',
  );
}
