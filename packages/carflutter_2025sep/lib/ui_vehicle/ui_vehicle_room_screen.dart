import 'package:carflutter_2025sep/common_imports.dart';
import 'package:carflutter_2025sep/core/utils/screen_scaler.dart';
import 'package:carflutter_2025sep/gen/assets.gen.dart';
import 'package:carflutter_2025sep/ui_kit/theme/app_text_style.dart';
import 'package:carflutter_2025sep/ui_vehicle/hooks/use_current_vehicle.dart';
import 'package:carflutter_2025sep/ui_vehicle/ui_vehicle_drawer.dart';
import 'package:gap/gap.dart';

class UiVehicleRoomScreen extends StatelessWidget {
  const UiVehicleRoomScreen({super.key});

  @override
  Widget build(final BuildContext context) => ScreenScalerBuilder(
    builder: (final context, final scaler) =>
        const _Scaffold(children: [_Header()]),
  );
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.children});
  final List<Widget> children;

  @override
  Widget build(final BuildContext context) => Scaffold(
    drawer: const UiVehicleDrawer(),
    body: Stack(
      children: [
        Positioned.fill(
          child: Assets.images.vehicleBackground.svg(fit: BoxFit.fill),
        ),
        Column(children: children),
      ],
    ),
  );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(final BuildContext context) {
    final currentVehicle = useCurrentVehicle(context);
    return ScreenScalerBuilder(
      builder: (final context, final scaler) => Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ЛИЧНЫЙ ТРАНСПОРТ', style: AppTextStyle.s40),
                Text(currentVehicle.model, style: AppTextStyle.s20),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                ButtonContainerVariants.iconText(
                  height: 47.03,
                  onTap: () => debugPrint('Primary button tapped'),
                  text: const Center(child: Text('PRIMARY')),
                  icon: Assets.icons.icCar.svg(width: 23.51, height: 23.51),
                ),
                const Gap(11.76),
                ButtonContainerVariants.icon(
                  height: 47.03,
                  onTap: () => debugPrint('Primary button tapped'),
                  icon: Assets.icons.icClose.svg(width: 19.59, height: 19.59),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
