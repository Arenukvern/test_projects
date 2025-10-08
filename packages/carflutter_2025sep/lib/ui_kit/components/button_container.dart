import 'dart:ui';

import 'package:carflutter_2025sep/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

/// {@template button_container}
/// A glassmorphic button container matching SVG design specifications.
///
/// Features:
/// - Linear gradient with 315° angle (bottom-left to top-right)
/// - Backdrop blur effect for glassmorphic appearance
/// - Optional gradient border using CustomPainter
/// - Responsive scaling for rectangle and square formats
/// - Flex row layout with centered alignment
/// - Fixed dimensions based on SVG specifications
/// {@endtemplate}
class ButtonContainer extends StatelessWidget {
  /// {@macro button_container}
  const ButtonContainer({
    required this.child,
    this.onTap,
    this.width,
    this.height,
    this.gradientBorder,
    this.borderStrokeWidth = 1.5,
    super.key,
  });

  /// The child widget to display inside the container
  final Widget child;

  /// Callback when container is tapped
  final VoidCallback? onTap;

  /// Container width override (optional)
  final double? width;

  /// Container height override (optional)
  final double? height;

  /// Optional gradient to apply to border. If null, no gradient border is drawn
  final Gradient? gradientBorder;

  /// Stroke width for the gradient border
  final double borderStrokeWidth;

  @override
  Widget build(final BuildContext context) {
    final scaledWidth = width;
    final scaledHeight = height ?? 47.03;
    const scaledBorderRadius = 11.76;
    const horizontalPadding = 11.76;
    const verticalPadding = 11.76;
    const scaledGap = 11.76;

    final borderRadius = BorderRadius.circular(scaledBorderRadius);

    return LayoutBuilder(
      builder: (final context, final constraints) => GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.66, sigmaY: 8.66),
            child: Container(
              width: scaledWidth,
              height: scaledHeight,
              decoration: BoxDecoration(
                border: GradientBoxBorder(
                  gradient:
                      gradientBorder ??
                      const RadialGradient(
                        colors: [
                          AppColors.white0,
                          AppColors.white20,
                          AppColors.white0,
                        ],
                        stops: [0.0, 0.5, 1.0],
                        center: Alignment.topLeft,
                        // TODO(arenukvern): add dependence from widget ratio
                        // width / height
                        radius: 1.5,
                      ),
                  width: 0.39,
                ),

                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0x0DFFFFFF), // rgba(255, 255, 255, 0.05)
                    Color(0x00FFFFFF), // rgba(255, 255, 255, 0)
                  ],
                  stops: [0.0, 1.0],
                ),
                borderRadius: borderRadius,
              ),
              // SVG auto layout: flex-direction: row, align-items: center
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: _buildChildWithGap(scaledGap),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds child widget with proper gap spacing for flex layout
  Widget _buildChildWithGap(final double gap) {
    if (child is Row) {
      final row = child as Row;
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _addGapBetweenChildren(row.children, gap),
      );
    }

    return child;
  }

  /// Adds gap spacing between child widgets
  List<Widget> _addGapBetweenChildren(
    final List<Widget> children,
    final double gap,
  ) {
    if (children.length <= 1) return children;

    final result = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(Gap(gap));
      }
    }
    return result;
  }
}

/// {@template button_container_variants}
/// Predefined ButtonContainer variants for common use cases.
///
/// All variants use the same glassmorphic styling from SVG specifications
/// with different child content arrangements. Support optional gradient borders.
/// {@endtemplate}
class ButtonContainerVariants {
  ButtonContainerVariants._();

  /// Standard glassmorphic button matching SVG specifications
  static ButtonContainer standard({
    required final Widget child,
    required final VoidCallback? onTap,
    final double? width,
    final double? height,
    final Gradient? gradientBorder,
    final double borderStrokeWidth = 1.5,
  }) => ButtonContainer(
    onTap: onTap,
    width: width,
    height: height,
    gradientBorder: gradientBorder,
    borderStrokeWidth: borderStrokeWidth,
    child: child,
  );

  /// Icon-only button with SVG car icon dimensions (23.51x23.51px)
  static ButtonContainer icon({
    required final Widget icon,
    required final VoidCallback? onTap,
    final double? width,
    final double? height,
    final Gradient? gradientBorder,
    final double borderStrokeWidth = 1.5,
  }) => ButtonContainer(
    onTap: onTap,
    width: width,
    height: height,
    gradientBorder: gradientBorder,
    borderStrokeWidth: borderStrokeWidth,
    child: icon,
  );

  /// Button with icon and text in row layout
  static ButtonContainer iconText({
    required final Widget icon,
    required final Widget text,
    required final VoidCallback? onTap,
    final double? width,
    final double? height,
    final Gradient? gradientBorder,
    final double borderStrokeWidth = 1.5,
  }) => ButtonContainer(
    onTap: onTap,
    width: width,
    height: height,
    gradientBorder: gradientBorder,
    borderStrokeWidth: borderStrokeWidth,
    child: Row(mainAxisSize: MainAxisSize.min, children: [icon, text]),
  );

  /// Text-only button
  static ButtonContainer text({
    required final Widget text,
    required final VoidCallback? onTap,
    final double? width,
    final double? height,
    final Gradient? gradientBorder,
    final double borderStrokeWidth = 1.5,
  }) => ButtonContainer(
    onTap: onTap,
    width: width,
    height: height,
    gradientBorder: gradientBorder,
    borderStrokeWidth: borderStrokeWidth,
    child: text,
  );
}
