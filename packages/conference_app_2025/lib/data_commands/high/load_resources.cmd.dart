import 'package:conference_app_2025/common_imports.dart';
import 'package:conference_app_2025/data_commands/low/load_resources/load_conference_tags.cmd.dart';
import 'package:conference_app_2025/data_commands/low/load_resources/load_persons.cmd.dart';

class LoadResourcesCommand with HasApi, HasResources {
  const LoadResourcesCommand();

  Future<void> execute() async {
    await Future.wait([
      const LoadConferenceTagsCommand().execute(),
      const LoadPersonsCommand().execute(),
    ]);
  }
}
