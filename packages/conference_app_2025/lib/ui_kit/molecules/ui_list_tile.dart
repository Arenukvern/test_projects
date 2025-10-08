import 'package:flutter/material.dart';

/// {@template ui_list_tile}
/// Wrapper around Material [ListTile] with consistent styling.
///
/// Provides theme-aware list tile with support for leading/trailing widgets
/// and optional tap handling.
///
/// Example:
/// ```dart
/// UiListTile(
///   leading: Icon(Icons.person),
///   title: Text('John Doe'),
///   subtitle: Text('Speaker'),
///   trailing: Icon(Icons.chevron_right),
///   onTap: () => navigateToDetails(),
/// )
/// ```
/// {@endtemplate}
class UiListTile extends StatelessWidget {
  /// {@macro ui_list_tile}
  const UiListTile({
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    super.key,
  });

  /// See [ListTile.leading]
  final Widget? leading;

  /// See [ListTile.title]
  final Widget? title;

  /// See [ListTile.subtitle]
  final Widget? subtitle;

  /// See [ListTile.trailing]
  final Widget? trailing;

  /// See [ListTile.isThreeLine]
  final bool isThreeLine;

  /// See [ListTile.dense]
  final bool? dense;

  /// See [ListTile.contentPadding]
  final EdgeInsetsGeometry? contentPadding;

  /// See [ListTile.enabled]
  final bool enabled;

  /// See [ListTile.onTap]
  final GestureTapCallback? onTap;

  /// See [ListTile.onLongPress]
  final GestureLongPressCallback? onLongPress;

  /// See [ListTile.selected]
  final bool selected;

  /// See [ListTile.selectedColor]
  final Color? selectedColor;

  /// See [ListTile.iconColor]
  final Color? iconColor;

  /// See [ListTile.textColor]
  final Color? textColor;

  @override
  Widget build(final BuildContext context) => ListTile(
    leading: leading,
    title: title,
    subtitle: subtitle,
    trailing: trailing,
    isThreeLine: isThreeLine,
    dense: dense,
    contentPadding: contentPadding,
    enabled: enabled,
    onTap: onTap,
    onLongPress: onLongPress,
    selected: selected,
    selectedColor: selectedColor,
    iconColor: iconColor,
    textColor: textColor,
  );
}
