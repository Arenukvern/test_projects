import 'package:flutter/material.dart';

/// {@template text_scale_resource}
/// Resource for managing text scale configuration across the application.
///
/// Supports both custom scale factor and system default behavior.
/// When [value] is null, the system's text scale from [MediaQuery] is used.
///
/// Example:
/// ```dart
/// // Set custom scale
/// textScaleResource.setScale(1.5);
///
/// // Use system scale
/// textScaleResource.useSystemScale();
///
/// // Get effective scaler
/// final scaler = textScaleResource.scalerOf(context);
/// ```
/// {@endtemplate}
class TextScaleResource extends ValueNotifier<TextScaler?> {
  /// {@macro text_scale_resource}
  TextScaleResource([super.initial]);

  /// Set custom text scale factor
  void setScale(final double factor) => value = TextScaler.linear(factor);

  /// Use system text scale from MediaQuery
  void useSystemScale() => value = null;

  /// Get effective text scaler for context
  ///
  /// Returns custom [value] if set, otherwise falls back to system scale
  TextScaler scalerOf(final BuildContext context) =>
      value ?? MediaQuery.textScalerOf(context);
}
