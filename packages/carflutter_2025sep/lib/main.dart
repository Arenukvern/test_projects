import 'package:carflutter_2025sep/di/di.dart';
import 'package:carflutter_2025sep/ui_vehicle_room/ui_vehicle_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => DiProvider(
    builder: (final context) => MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const UiVehicleRoomScreen(),
    ),
  );
}

class DiProvider extends StatelessWidget with ResourcesMixin {
  const DiProvider({required this.builder, super.key});
  final WidgetBuilder builder;

  @override
  Widget build(final BuildContext context) {
    const p = ChangeNotifierProvider.value;
    return MultiProvider(
      providers: [
        p(value: gameStatusResource),
        p(value: vehiclesResource),
      ],
      builder: (final context, final child) => builder(context),
    );
  }
}
