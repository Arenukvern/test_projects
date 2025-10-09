import 'package:conference_app_2025/ui_kit/decorations/decorations.dart';
import 'package:conference_app_2025/ui_kit/theme/theme.dart';
import 'package:flutter/material.dart';

/// {@template ui_button}
/// Flexible button component that consumes [UiButtonDecoration].
///
/// Integrates with AppTheme and supports loading states, icons,
/// and smooth transitions between states.
///
/// Example (filled):
/// ```dart
/// UiButton(
///   text: 'Submit',
///   onPressed: () => _submit(),
/// )
/// ```
///
/// Example (gradient with icon):
/// ```dart
/// UiButton(
///   decoration: UiButtonDecoration.gradient,
///   icon: Icon(Icons.star),
///   text: 'Featured',
///   onPressed: () => _showFeatured(),
/// )
/// ```
///
/// Example (loading state):
/// ```dart
/// UiButton(
///   text: 'Loading...',
///   isLoading: _isProcessing,
///   onPressed: _isProcessing ? null : () => _process(),
/// )
/// ```
/// {@endtemplate}
class UiButton extends StatelessWidget {
  /// {@macro ui_button}
  const UiButton({
    this.decoration,
    this.onPressed,
    this.child,
    this.text,
    this.icon,
    this.isLoading = false,
    this.loadingIndicator,
    super.key,
  });

  /// Button decoration configuration.
  /// If null, uses [UiButtonDecoration.filled] as default.
  final UiButtonDecoration? decoration;

  /// Button press callback
  final VoidCallback? onPressed;

  /// Button content widget (overrides [text])
  final Widget? child;

  /// Button text content
  final String? text;

  /// Optional leading icon
  final Widget? icon;

  /// Whether button is in loading state
  final bool isLoading;

  /// Custom loading indicator widget
  final Widget? loadingIndicator;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    // Use filled as default decoration
    final effectiveDecoration = decoration ?? UiButtonDecoration.filled;

    // Resolve colors based on decoration variant
    final variant = effectiveDecoration.variant;
    final isGradientStyle = variant == 'gradient';
    final isOutlinedStyle = variant == 'outlined';
    final isTextStyle = variant == 'text';

    // Determine background and foreground colors
    Color? backgroundColor = effectiveDecoration.backgroundColor;
    Color foregroundColor =
        effectiveDecoration.foregroundColor ?? theme.colorScheme.onPrimary;

    // Apply theme-based defaults
    if (backgroundColor == null && !isGradientStyle) {
      if (isOutlinedStyle || isTextStyle) {
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.primary;
      } else {
        backgroundColor = theme.colorScheme.primary;
        foregroundColor = theme.colorScheme.onPrimary;
      }
    }

    // Resolve gradient if gradient style
    Gradient? gradient = effectiveDecoration.gradient;
    if (isGradientStyle) {
      gradient ??= LinearGradient(
        colors: [
          appColors.gradientYellow,
          appColors.gradientOrange,
          appColors.gradientRed,
        ],
      );
      foregroundColor = Colors.white;
    }

    // Resolve border for outlined style
    Border? border = effectiveDecoration.border;
    if (isOutlinedStyle) {
      border ??= Border.all(color: theme.colorScheme.primary, width: 1.5);
    }

    // Resolve padding
    final padding =
        effectiveDecoration.padding ??
        const EdgeInsets.symmetric(vertical: 12, horizontal: 24);

    final content = _buildContent(context, theme, foregroundColor);

    return InkWell(
      onTap: isLoading ? null : onPressed,
      borderRadius: effectiveDecoration.borderRadius,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: padding,
        decoration: BoxDecoration(
          color: gradient == null ? backgroundColor : null,
          gradient: gradient,
          border: border,
          borderRadius: effectiveDecoration.borderRadius,
          boxShadow: effectiveDecoration.boxShadow,
        ),
        child: content,
      ),
    );
  }

  Widget _buildContent(
    final BuildContext context,
    final ThemeData theme,
    final Color textColor,
  ) {
    final textWidget = text != null ? Text(text!) : null;
    final contentWidget = child ?? textWidget ?? const SizedBox.shrink();

    if (!isLoading) {
      // Normal state - show icon and content
      if (icon != null) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconTheme(
              data: IconThemeData(color: textColor),
              child: icon!,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: DefaultTextStyle.merge(
                style: theme.textTheme.labelLarge!.copyWith(color: textColor),
                textAlign: TextAlign.center,
                child: contentWidget,
              ),
            ),
          ],
        );
      }

      return DefaultTextStyle.merge(
        style: theme.textTheme.labelLarge!.copyWith(color: textColor),
        textAlign: TextAlign.center,
        child: contentWidget,
      );
    }

    // Loading state
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (child != null || text != null) ...[
          Flexible(
            child: DefaultTextStyle.merge(
              style: theme.textTheme.labelLarge!.copyWith(color: textColor),
              textAlign: TextAlign.center,
              child: contentWidget,
            ),
          ),
          const SizedBox(width: 8),
        ],
        loadingIndicator ??
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(textColor),
              ),
            ),
      ],
    );
  }
}
