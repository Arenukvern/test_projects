import 'package:carflutter_2025sep/common_imports.dart';

void main() {
  Di.instance.register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => DiProvider(
    builder: (final context) => MaterialApp.router(
      title: 'Car Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
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
