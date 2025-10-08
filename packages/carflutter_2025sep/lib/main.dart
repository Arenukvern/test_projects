import 'package:carflutter_2025sep/common_imports.dart';
import 'package:carflutter_2025sep/ui_kit/theme/app_colors.dart';
import 'package:carflutter_2025sep/ui_kit/theme/app_fonts.dart';

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
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seedColor),
        textTheme: Typography.material2021().englishLike.apply(
          fontFamily: AppFonts.halvarEng,
        ),
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
        p(value: currentVehicleIdResource),
        p(value: gameStatusResource),
        p(value: vehiclesResource),
      ],
      builder: (final context, final child) => builder(context),
    );
  }
}
