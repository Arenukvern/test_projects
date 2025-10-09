import 'package:conference_app_2025/common_imports.dart';

class LoadConferenceTagsCommand with HasApi, HasResources {
  const LoadConferenceTagsCommand();

  Future<void> execute() async {
    final tags = await conferenceTagsApi.getConferenceTags();
    conferenceTagsResource.assignAllOrdered(tags);
  }
}
