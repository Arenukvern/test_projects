import 'dart:async';

import 'package:golden_toolkit/golden_toolkit.dart';

/// {@template flutter_test_config}
/// Global test configuration for golden tests.
///
/// Loads fonts and sets up test configuration for all tests.
/// {@endtemplate}
Future<void> testExecutable(final FutureOr<void> Function() testMain) async =>
    GoldenToolkit.runWithConfiguration(() async {
      await loadAppFonts();
      await testMain();
    }, config: GoldenToolkitConfiguration(skipGoldenAssertion: () => false));
