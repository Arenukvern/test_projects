import 'package:conference_app_2025/common_imports.dart';
import 'package:flutter/gestures.dart';

/// {@template ui_scaffold}
/// Custom scaffold with configurable text scaling support.
///
/// Wraps Material [Scaffold] and applies text scale factor
/// either from global [TextScaleProvider] or per-screen override.
///
/// Supports both global app-wide text scaling and per-screen overrides
/// for fine-grained accessibility control.
///
/// Example with global scale:
/// ```dart
/// UiScaffold(
///   appBar: AppBar(title: Text('My Screen')),
///   body: MyContent(),
/// )
/// ```
///
/// Example with custom scale:
/// ```dart
/// UiScaffold(
///   textScaleFactor: 1.5,
///   body: MyContent(),
/// )
/// ```
/// {@endtemplate}
class UiScaffold extends StatelessWidget {
  /// {@macro ui_scaffold}
  const UiScaffold({
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.textScaleFactor,
    super.key,
  });

  /// See [Scaffold.appBar]
  final PreferredSizeWidget? appBar;

  /// See [Scaffold.body]
  final Widget? body;

  /// See [Scaffold.floatingActionButton]
  final Widget? floatingActionButton;

  /// See [Scaffold.floatingActionButtonLocation]
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// See [Scaffold.floatingActionButtonAnimator]
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// See [Scaffold.persistentFooterButtons]
  final List<Widget>? persistentFooterButtons;

  /// See [Scaffold.persistentFooterAlignment]
  final AlignmentDirectional persistentFooterAlignment;

  /// See [Scaffold.drawer]
  final Widget? drawer;

  /// See [Scaffold.onDrawerChanged]
  final DrawerCallback? onDrawerChanged;

  /// See [Scaffold.endDrawer]
  final Widget? endDrawer;

  /// See [Scaffold.onEndDrawerChanged]
  final DrawerCallback? onEndDrawerChanged;

  /// See [Scaffold.bottomNavigationBar]
  final Widget? bottomNavigationBar;

  /// See [Scaffold.bottomSheet]
  final Widget? bottomSheet;

  /// See [Scaffold.backgroundColor]
  final Color? backgroundColor;

  /// See [Scaffold.resizeToAvoidBottomInset]
  final bool? resizeToAvoidBottomInset;

  /// See [Scaffold.primary]
  final bool primary;

  /// See [Scaffold.drawerDragStartBehavior]
  final DragStartBehavior drawerDragStartBehavior;

  /// See [Scaffold.extendBody]
  final bool extendBody;

  /// See [Scaffold.extendBodyBehindAppBar]
  final bool extendBodyBehindAppBar;

  /// See [Scaffold.drawerScrimColor]
  final Color? drawerScrimColor;

  /// See [Scaffold.drawerEdgeDragWidth]
  final double? drawerEdgeDragWidth;

  /// See [Scaffold.drawerEnableOpenDragGesture]
  final bool drawerEnableOpenDragGesture;

  /// See [Scaffold.endDrawerEnableOpenDragGesture]
  final bool endDrawerEnableOpenDragGesture;

  /// See [Scaffold.restorationId]
  final String? restorationId;

  /// Custom text scale factor for this screen.
  /// If null, uses global text scale from [TextScaleResource].
  /// If provided, overrides global setting for this screen only.
  final double? textScaleFactor;

  TextScaler? _getTextScaler(final BuildContext context) {
    if (textScaleFactor != null) return TextScaler.linear(textScaleFactor!);
    return null;
  }

  @override
  Widget build(final BuildContext context) {
    final textScaler = _getTextScaler(context);
    final mediaQuery = MediaQuery.of(context);

    return MediaQuery(
      data: mediaQuery.copyWith(textScaler: textScaler),
      child: Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        persistentFooterButtons: persistentFooterButtons,
        persistentFooterAlignment: persistentFooterAlignment,
        drawer: drawer,
        onDrawerChanged: onDrawerChanged,
        endDrawer: endDrawer,
        onEndDrawerChanged: onEndDrawerChanged,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        primary: primary,
        drawerDragStartBehavior: drawerDragStartBehavior,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        drawerScrimColor: drawerScrimColor,
        drawerEdgeDragWidth: drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        restorationId: restorationId,
      ),
    );
  }
}
