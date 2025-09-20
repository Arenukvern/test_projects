import 'package:carflutter_2025sep/common_imports.dart';
import 'package:carflutter_2025sep/core/utils/screen_scaler.dart';
import 'package:carflutter_2025sep/gen/assets.gen.dart';
import 'package:carflutter_2025sep/ui_vehicle/hooks/use_current_vehicle.dart';
import 'package:carflutter_2025sep/ui_vehicle/ui_vehicle_drawer.dart';

class UiVehicleRoomScreen extends StatelessWidget {
  const UiVehicleRoomScreen({super.key});

  @override
  Widget build(final BuildContext context) => ScreenScalerBuilder(
    builder: (final context, final scaler) {
      final scaleSize = scaler.scaleSize;
      return const _Scaffold(children: [_Header()]);
    },
  );
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.children, super.key});
  final List<Widget> children;

  @override
  Widget build(final BuildContext context) => Scaffold(
    drawer: const UiVehicleDrawer(),
    body: Stack(
      children: [
        Positioned.fill(
          child: Assets.images.vehicleBackground.svg(fit: BoxFit.cover),
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
    return Row(
      children: [
        Column(
          children: [
            const Text('ЛИЧНЫЙ ТРАНСПОРТ'),
            Text(currentVehicle.model),
          ],
        ),
      ],
    );
  }
}
