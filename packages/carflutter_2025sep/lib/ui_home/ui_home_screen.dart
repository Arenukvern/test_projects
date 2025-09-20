import 'package:carflutter_2025sep/common_imports.dart';
import 'package:carflutter_2025sep/data_listeners/data_listeners.dart';

/// {@template home_screen}
/// Home screen placeholder
///
/// This is a temporary placeholder screen that will be replaced
/// with the actual home screen implementation.
/// {@endtemplate}
class UiHomeScreen extends StatefulWidget {
  /// {@macro home_screen}
  const UiHomeScreen({super.key});

  @override
  State<UiHomeScreen> createState() => _UiHomeScreenState();
}

class _UiHomeScreenState extends State<UiHomeScreen>
    with ResourcesMixin, ApiMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  void _init() {
    clientApi
      ..addListener(VehicleListener())
      ..pingReady();
    gameStatusResource.value = GameStatus.loaded;
  }

  @override
  Widget build(final BuildContext context) {
    final gameStatus = context.watch<GameStatusResources>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Initial Screen'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            switch (gameStatus.value) {
              GameStatus.loading => const CircularProgressIndicator(),
              GameStatus.loaded => ElevatedButton(
                onPressed: () => AppRoute.vehicleRoom.go(context),
                child: const Text('Go to Vehicle Room'),
              ),
              GameStatus.error => const Text('Error'),
            },
          ],
        ),
      ),
    );
  }
}
