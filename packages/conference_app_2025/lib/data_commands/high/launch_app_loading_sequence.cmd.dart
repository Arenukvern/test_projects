import 'package:conference_app_2025/data_commands/middle/load_resources.cmd.dart';
import 'package:conference_app_2025/data_listeners/data_listeners.dart';
import 'package:conference_app_2025/data_resources/data_resources.dart';
import 'package:conference_app_2025/di/di.dart';

class LaunchAppLoadingSequenceCommand with HasServices, HasResources, HasApi {
  const LaunchAppLoadingSequenceCommand();

  Future<void> execute() async {
    try {
      appStatusResource.value = AppStatus.loading;
      // Load critical data - await completion
      await const LoadResourcesCommand().execute();

      await notificationService.initializePlugin();

      clientApi.addListener(ConferenceUpdatesListener());

      // Update app status to ready
      appStatusResource.value = AppStatus.ready;
    } catch (error) {
      // Handle loading errors
      appStatusResource.value = AppStatus.error;
    }
  }
}
