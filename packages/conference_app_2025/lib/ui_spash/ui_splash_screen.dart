import 'dart:async';

import 'package:conference_app_2025/data_commands/high/load_resources.cmd.dart';
import 'package:flutter/widgets.dart';

class UiSplashScreen extends StatefulWidget {
  const UiSplashScreen({super.key});

  @override
  State<UiSplashScreen> createState() => _UiSplashScreenState();
}

class _UiSplashScreenState extends State<UiSplashScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(const LoadResourcesCommand().execute());
  }

  @override
  Widget build(final BuildContext context) => const Placeholder();
}
