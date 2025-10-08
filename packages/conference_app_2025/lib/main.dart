import 'package:conference_app_2025/common_imports.dart';
import 'package:conference_app_2025/di/di_provider.dart';

void main() {
  Di.instance.register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => DiProvider(
    builder: (final context) {
      final themeMode = context.watch<ThemeBrightnessResource>().value;

      return MaterialApp.router(
        title: 'Conference App 2025',
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: themeMode,
        routerConfig: appRouter,
      );
    },
  );
}
