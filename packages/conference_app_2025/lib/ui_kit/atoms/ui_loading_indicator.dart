import 'package:flutter/material.dart';

/// Size variants for [UiLoadingIndicator]
enum UiLoadingIndicatorSize {
  /// Small size (16x16)
  small(16),

  /// Medium size (24x24)
  medium(24),

  /// Large size (32x32)
  large(32);

  const UiLoadingIndicatorSize(this.value);

  /// Size value in pixels
  final double value;
}

/// {@template ui_loading_indicator}
/// Material 3 loading indicator with theme-aware colors.
///
/// Displays a circular progress indicator with consistent sizing
/// and color scheme across the application.
///
/// Example:
/// ```dart
/// UiLoadingIndicator(size: UiLoadingIndicatorSize.medium)
/// ```
///
/// Center on screen:
/// ```dart
/// Center(
///   child: UiLoadingIndicator(),
/// )
/// ```
/// {@endtemplate}
class UiLoadingIndicator extends StatelessWidget {
  /// {@macro ui_loading_indicator}
  const UiLoadingIndicator({
    this.size = UiLoadingIndicatorSize.medium,
    this.color,
    this.strokeWidth,
    super.key,
  });

  /// Size of the loading indicator
  final UiLoadingIndicatorSize size;

  /// Custom color. Uses theme primary color if null.
  final Color? color;

  /// Width of the indicator stroke. Uses default if null.
  final double? strokeWidth;

  @override
  Widget build(final BuildContext context) => SizedBox(
    width: size.value,
    height: size.value,
    child: CircularProgressIndicator(
      color: color ?? Theme.of(context).colorScheme.primary,
      strokeWidth: strokeWidth ?? 4.0,
    ),
  );
}
