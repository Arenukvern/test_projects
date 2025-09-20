import 'package:carflutter_2025sep/common_imports.dart';

/// {@template characters_screen}
/// Characters screen placeholder
///
/// This is a temporary placeholder screen for the characters feature.
/// {@endtemplate}
class UiVehicleDrawer extends StatelessWidget {
  /// {@macro characters_screen}
  const UiVehicleDrawer({super.key});

  @override
  Widget build(final BuildContext context) => const Drawer(
    child: Center(
      child: Text('Vehicle Drawer', style: TextStyle(fontSize: 24)),
    ),
  );
}
