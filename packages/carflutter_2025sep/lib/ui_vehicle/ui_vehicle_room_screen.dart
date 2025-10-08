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
    builder: (final context, final scaler) => const _Scaffold(
      children: [
        Positioned(top: 16, left: 34.37, child: _HeaderLeft()),
        Positioned(
          top: 0,
          left: 50.94,
          bottom: 0,
          right: 0,
          child: _VehicleList(),
        ),
        Positioned(top: 16, right: 34.37, child: _HeaderRight()),
      ],
    ),
  );
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.children});
  final List<Widget> children;

  @override
  Widget build(final BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: true,
    drawer: const UiVehicleDrawer(),
    body: Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Assets.images.vehicleBackground.svg(fit: BoxFit.fill),
        ),
        ...children,
      ],
    ),
  );
}

class _HeaderLeft extends StatelessWidget {
  const _HeaderLeft();

  @override
  Widget build(final BuildContext context) {
    final currentVehicle = useCurrentVehicle(context);
    return ScreenScalerBuilder(
      builder: (final context, final scaler) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 362),
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ЛИЧНЫЙ ТРАНСПОРТ', style: AppTextStyle.s40),
              Text(
                currentVehicle.model,
                style: AppTextStyle.s20.copyWith(color: AppColors.white50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderRight extends StatelessWidget {
  const _HeaderRight();

  @override
  Widget build(final BuildContext context) => ScreenScalerBuilder(
    builder: (final context, final scaler) => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ButtonContainerVariants.iconText(
          onTap: () => debugPrint('Primary button tapped'),
          text: const Center(child: Text('PRIMARY')),
          icon: Assets.icons.icCar.svg(width: 23.51, height: 23.51),
        ),
        const Gap(20.38),
        ButtonContainerVariants.icon(
          onTap: () => debugPrint('Primary button tapped'),
          icon: Assets.icons.icClose.svg(width: 19.59, height: 19.59),
        ),
      ],
    ),
  );
}

class _VehicleList extends StatelessWidget {
  const _VehicleList();

  @override
  Widget build(final BuildContext context) {
    final vehicles = context.watch<VehiclesResource>().orderedValues;
    final currentVehicleId = context.watch<CurrentVehicleIdResource>();
    return Row(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 152.83),
          child: ListView.separated(
            separatorBuilder: (final context, final index) => const Gap(8),
            itemCount: vehicles.length,
            padding: const EdgeInsets.only(top: 105),
            itemBuilder: (final context, final index) {
              final vehicle = vehicles[index];
              return _VehicleCard(
                key: ValueKey(vehicle.id),
                vehicle: vehicle,
                isSelected: vehicle.id == currentVehicleId.value,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _VehicleCard extends StatelessWidget {
  const _VehicleCard({
    required this.vehicle,
    required this.isSelected,
    super.key,
  });
  final Vehicle vehicle;
  final bool isSelected;

  @override
  Widget build(final BuildContext context) {
    const radius = 11.76;
    const margin = 3.92;
    return SizedBox(
      width: 149.7 + margin,
      height: 105.42 + margin,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Positioned(
            top: margin,
            left: 0,
            right: margin,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Assets.images.smallVehiclePattern.image(fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: VehiclePlate(plateType: vehicle.plateType),
          ),
          Positioned(
            top: margin,
            right: margin,
            left: 0,
            bottom: 0,
            child: _VehicleCardBody(vehicle: vehicle),
          ),
        ],
      ),
    );
  }
}

class _VehicleCardBody extends StatelessWidget {
  const _VehicleCardBody({required this.vehicle});
  final Vehicle vehicle;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(11.76),
      gradient: const SweepGradient(
        startAngle: 26.57 * (3.141592653589793 / 180),
        endAngle: (26.57 + 360) * (3.141592653589793 / 180),
        center: Alignment.centerLeft,
        stops: [
          0.0,
          (5.99 + 19.49) / 360, // ~0.071
          (340.51 + 19.49) / 360, // ~1.0
          1.0,
        ],
        colors: [
          Color.fromRGBO(250, 76, 52, 0), // transparent
          Color(0xFFFFCA00), // #FFCA00
          Color.fromRGBO(250, 76, 52, 0), // transparent
          Color(0xFFFFCA00), // #FFCA00
        ],
        transform: GradientRotation(-90 * (3.141592653589793 / 270)),
      ),
    ),
    child: Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 5.88,
          left: 9.8,
          child: Row(
            children: [
              Assets.icons.icTimer.svg(width: 9.8, height: 9.8),
              const Gap(3.14),
              Text('${vehicle.leftTime} ч.', style: AppTextStyle.s10),
            ],
          ),
        ),
        Positioned(
          bottom: 11.35,
          left: 10.58,
          width: 100,
          child: Row(
            children: [
              Flexible(
                child: Text(
                  vehicle.model.toUpperCase(),
                  style: AppTextStyle.s10,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
