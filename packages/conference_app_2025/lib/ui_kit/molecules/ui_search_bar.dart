import 'package:flutter/material.dart';

/// {@template ui_search_bar}
/// Search bar with leading search icon and clear button.
///
/// Material 3 styled search input field with automatic clear button
/// that appears when text is present.
///
/// Example:
/// ```dart
/// UiSearchBar(
///   controller: _searchController,
///   onChanged: (text) => _handleSearch(text),
///   hintText: 'Search speakers...',
/// )
/// ```
/// {@endtemplate}
class UiSearchBar extends StatefulWidget {
  /// {@macro ui_search_bar}
  const UiSearchBar({
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.hintText = 'Search',
    this.autofocus = false,
    super.key,
  });

  /// Controller for the search text field
  final TextEditingController? controller;

  /// Callback when search text changes
  final ValueChanged<String>? onChanged;

  /// Callback when search is submitted
  final ValueChanged<String>? onSubmitted;

  /// Hint text displayed when field is empty
  final String hintText;

  /// Whether the field should autofocus
  final bool autofocus;

  @override
  State<UiSearchBar> createState() => _UiSearchBarState();
}

class _UiSearchBarState extends State<UiSearchBar> {
  TextEditingController? _internalController;
  bool _hasText = false;

  TextEditingController get _controller =>
      widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = TextEditingController();
    }
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(final UiSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      // Remove listener from old controller
      (oldWidget.controller ?? _internalController)?.removeListener(
        _onTextChanged,
      );

      // Dispose old internal controller if it exists and we're switching to
      // external
      if (oldWidget.controller == null && widget.controller != null) {
        _internalController?.dispose();
        _internalController = null;
      }

      // Create new internal controller if switching from external to internal
      if (oldWidget.controller != null && widget.controller == null) {
        _internalController = TextEditingController();
      }

      // Add listener to new controller and update state
      _hasText = _controller.text.isNotEmpty;
      _controller.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _internalController?.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (_hasText != hasText) {
      setState(() => _hasText = hasText);
    }
  }

  void _clearText() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(final BuildContext context) => TextField(
    controller: _controller,
    autofocus: widget.autofocus,
    onChanged: widget.onChanged,
    onSubmitted: widget.onSubmitted,
    decoration: InputDecoration(
      hintText: widget.hintText,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: _hasText
          ? IconButton(icon: const Icon(Icons.clear), onPressed: _clearText)
          : null,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
