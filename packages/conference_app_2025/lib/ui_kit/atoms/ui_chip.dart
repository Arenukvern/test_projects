import 'package:flutter/material.dart';

/// {@template ui_chip}
/// Single chip component for selection and filtering.
///
/// Material 3 [FilterChip] with theme-aware styling.
/// Used as atomic component in [UiMultichipsRow].
///
/// Example:
/// ```dart
/// UiChip(
///   label: 'Flutter',
///   selected: true,
///   onSelected: (selected) => print('Chip selected: $selected'),
/// )
/// ```
/// {@endtemplate}
class UiChip extends StatelessWidget {
  /// {@macro ui_chip}
  const UiChip({
    required this.label,
    required this.onSelected,
    this.selected = false,
    this.avatar,
    super.key,
  });

  /// The text label for the chip
  final String label;

  /// Whether the chip is selected
  final bool selected;

  /// Callback when selection state changes
  final ValueChanged<bool>? onSelected;

  /// Optional leading widget (typically an icon)
  final Widget? avatar;

  @override
  Widget build(final BuildContext context) => FilterChip(
    label: Text(label),
    selected: selected,
    onSelected: onSelected,
    avatar: avatar,
    showCheckmark: true,
  );
}
