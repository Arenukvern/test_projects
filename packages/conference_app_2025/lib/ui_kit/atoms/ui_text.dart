import 'package:flutter/material.dart';

/// {@template ui_text}
/// Adaptive text widget that respects configured text scale factor.
///
/// Uses text scaling from the nearest [MediaQuery] which is configured
/// by [UiScaffold] or global [TextScaleProvider].
///
/// This is the primary text widget for the application, ensuring
/// consistent text scaling behavior across all screens.
///
/// Example:
/// ```dart
/// UiText(
///   'Hello World',
///   style: AppTextStyle.s16.copyWith(fontWeight: FontWeight.bold),
/// )
/// ```
/// {@endtemplate}
class UiText extends StatelessWidget {
  /// {@macro ui_text}
  const UiText(
    this.data, {
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    super.key,
  });

  /// The text to display
  final String data;

  /// Text style to apply. Uses theme's text style if not provided.
  final TextStyle? style;

  /// See [Text.strutStyle]
  final StrutStyle? strutStyle;

  /// See [Text.textAlign]
  final TextAlign? textAlign;

  /// See [Text.textDirection]
  final TextDirection? textDirection;

  /// See [Text.locale]
  final Locale? locale;

  /// See [Text.softWrap]
  final bool? softWrap;

  /// See [Text.overflow]
  final TextOverflow? overflow;

  /// See [Text.maxLines]
  final int? maxLines;

  /// See [Text.semanticsLabel]
  final String? semanticsLabel;

  /// See [Text.textWidthBasis]
  final TextWidthBasis? textWidthBasis;

  /// See [Text.textHeightBehavior]
  final TextHeightBehavior? textHeightBehavior;

  /// See [Text.selectionColor]
  final Color? selectionColor;

  @override
  Widget build(final BuildContext context) => Text(
    data,
    style: style,
    strutStyle: strutStyle,
    textAlign: textAlign,
    textDirection: textDirection,
    locale: locale,
    softWrap: softWrap,
    overflow: overflow,
    maxLines: maxLines,
    semanticsLabel: semanticsLabel,
    textWidthBasis: textWidthBasis,
    textHeightBehavior: textHeightBehavior,
    selectionColor: selectionColor,
  );
}
