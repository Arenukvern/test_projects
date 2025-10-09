import 'dart:async';

import 'package:conference_app_2025/common_imports.dart';

/// {@template ui_splash_screen}
/// Initial loading screen shown during app initialization.
///
/// Loads critical resources (conference tags, speakers, user's schedule)
/// and navigates to the main app once loading completes.
///
/// Follows the app loading sequence pattern:
/// 1. Load critical data with await
/// 2. Show loading indicator
/// 3. Navigate after completion using addPostFrameCallback
/// {@endtemplate}
class UiSplashScreen extends StatefulWidget {
  /// {@macro ui_splash_screen}
  const UiSplashScreen({super.key});

  @override
  State<UiSplashScreen> createState() => _UiSplashScreenState();
}

class _UiSplashScreenState extends State<UiSplashScreen> with HasResources {
  @override
  void initState() {
    super.initState();
    unawaited(_launchLoading());
  }

  /// Loads critical resources and navigates to main app
  Future<void> _launchLoading() async {
    await const LaunchAppLoadingSequenceCommand().execute();

    // Navigate after loading completes - use addPostFrameCallback
    // to ensure we have a valid context and the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (appStatusResource.value case AppStatus.error || AppStatus.loading) {
        return;
      }
      AppRoute.allConferences.go(context);
    });
  }

  /// Retry loading on error
  void _retry() => unawaited(_launchLoading());

  @override
  Widget build(final BuildContext context) {
    final appStatus = context.watch<AppStatusResource>();

    return UiScaffold(
      body: Center(
        child: switch (appStatus.value) {
          AppStatus.loading => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UiLoadingIndicator(),
              SizedBox(height: 16),
              UiText('Loading conference data...'),
            ],
          ),
          AppStatus.error => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              const UiText('Failed to load data'),
              const SizedBox(height: 16),
              UiButton(onPressed: _retry, text: 'Retry'),
            ],
          ),
          AppStatus.ready => const SizedBox.shrink(),
        },
      ),
    );
  }
}
