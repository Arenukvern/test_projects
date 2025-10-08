import 'package:conference_app_2025/ui_kit/atoms/atoms.dart';
import 'package:flutter/material.dart';

/// Selection mode for multichips
enum UiMultichipsSelectionMode {
  /// Only one chip can be selected at a time
  single,

  /// Multiple chips can be selected simultaneously
  multiple,
}

/// {@template ui_multichips_row}
/// Horizontal scrollable row of selectable chips.
///
/// Combines [UiChip] atoms into a scrollable molecular component
/// with selection handling.
///
/// Example (single selection):
/// ```dart
/// UiMultichipsRow(
///   items: ['Flutter', 'Dart', 'Firebase'],
///   selectedItems: {'Flutter'},
///   onSelectionChanged: (selected) => setState(() => _selected = selected),
/// )
/// ```
///
/// Example (multiple selection):
/// ```dart
/// UiMultichipsRow(
///   items: ['Mobile', 'Web', 'Desktop'],
///   selectedItems: {'Mobile', 'Web'},
///   selectionMode: UiMultichipsSelectionMode.multiple,
///   onSelectionChanged: (selected) => setState(() => _platforms = selected),
/// )
/// ```
/// {@endtemplate}
class UiMultichipsRow extends StatelessWidget {
  /// {@macro ui_multichips_row}
  const UiMultichipsRow({
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
    this.selectionMode = UiMultichipsSelectionMode.single,
    this.spacing = 8.0,
    super.key,
  });

  /// List of chip labels
  final List<String> items;

  /// Currently selected item labels
  final Set<String> selectedItems;

  /// Callback when selection changes
  final ValueChanged<Set<String>> onSelectionChanged;

  /// Selection mode (single or multiple)
  final UiMultichipsSelectionMode selectionMode;

  /// Spacing between chips
  final double spacing;

  void _handleChipTap(final String item) {
    final newSelection = Set<String>.from(selectedItems);

    if (selectionMode == UiMultichipsSelectionMode.single) {
      if (newSelection.contains(item)) {
        newSelection.clear();
      } else {
        newSelection
          ..clear()
          ..add(item);
      }
    } else {
      if (newSelection.contains(item)) {
        newSelection.remove(item);
      } else {
        newSelection.add(item);
      }
    }

    onSelectionChanged(newSelection);
  }

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          UiChip(
            label: items[i],
            selected: selectedItems.contains(items[i]),
            onSelected: (_) => _handleChipTap(items[i]),
          ),
          if (i < items.length - 1) SizedBox(width: spacing),
        ],
      ],
    ),
  );
}
