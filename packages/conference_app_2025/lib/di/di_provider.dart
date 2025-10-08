import 'package:conference_app_2025/common_imports.dart';

class DiProvider extends StatelessWidget with ResourcesMixin {
  const DiProvider({required this.builder, super.key});
  final WidgetBuilder builder;

  @override
  Widget build(final BuildContext context) {
    const p = ChangeNotifierProvider.value;
    return MultiProvider(
      providers: [
        p(value: myConferencesResource),
        p(value: conferenceTagsResource),
        p(value: speakersResource),
        p(value: textScaleResource),
      ],
      builder: (final context, final child) => builder(context),
    );
  }
}
