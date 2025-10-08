import 'package:conference_app_2025/common_imports.dart';

class LoadPersonsCommand with HasApi, HasResources {
  const LoadPersonsCommand();

  Future<void> execute() async {
    final persons = await speakerApi.getSpeakers();
    speakersResource.assignAllOrdered(persons);
  }
}
