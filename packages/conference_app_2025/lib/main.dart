import 'package:conference_app_2025/common_imports.dart';

void main() {
  Di.instance.register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => DiProvider(
    builder: (final context) => MaterialApp.router(
      title: 'Conference App 2025',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seedColor),
        textTheme: Typography.blackHelsinki,
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
      providers: [],
      builder: (final context, final child) => builder(context),
    );
  }
}
