import 'package:carflutter_2025sep/core/core.dart';
import 'package:carflutter_2025sep/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// 0: Russian,
/// 1: Belarusian,
/// 2: Kazakhstani,
/// 3: Ukrainian,
/// 4: Brazilian,
/// 5: Empty
enum PlateType { belarusian, kazakhstani, ukrainian, brazilian, empty, russian }

class VehiclePlate extends StatelessWidget {
  const VehiclePlate({required this.plateType, super.key});
  final PlateType plateType;

  @override
  Widget build(final BuildContext context) => ScreenScalerBuilder(
    builder: (final context, final scaler) {
      final scaleSize = scaler.scaleSize;
      // Vary plate type based on index for demo
      final plateType = PlateType.values[this.plateType.index % 6];

      if (plateType case PlateType.belarusian) {
        // Belarusian plate
        return SizedBox(
          width: scaleSize(74, 195),
          height: scaleSize(16, 45),
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  ParkingImages.plateBel,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                left: scaleSize(17, 44),
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    'A123BC',
                    style: TextStyle(
                      fontFamily: AppFonts.halvarEng,
                      fontWeight: FontWeight.w500,
                      letterSpacing: scaleSize(1.2, 3.2),
                      height: .94,
                      color: const Color(0xFF010101),
                      fontSize: scaleSize(12, 32),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (plateType case PlateType.kazakhstani) {
        // Kazakhstani plate
        return SizedBox(
          width: scaleSize(74, 195),
          height: scaleSize(16, 45),
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  ParkingImages.plateKaz,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                left: scaleSize(13, 32),
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    'A123BC',
                    style: TextStyle(
                      fontFamily: AppFonts.halvarEng,
                      fontWeight: FontWeight.w500,
                      letterSpacing: scaleSize(1.2, 3.2),
                      height: .94,
                      color: const Color(0xFF010101),
                      fontSize: scaleSize(12, 32),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: scaleSize(4, 10),
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    '02',
                    style: TextStyle(
                      fontFamily: AppFonts.halvarEng,
                      fontWeight: FontWeight.w500,
                      letterSpacing: scaleSize(1.2, 3.2),
                      height: .94,
                      color: const Color(0xFF010101),
                      fontSize: scaleSize(12, 32),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (plateType case PlateType.ukrainian) {
        // Ukrainian plate
        return SizedBox(
          width: scaleSize(74, 195),
          height: scaleSize(16, 45),
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  ParkingImages.plateUkr,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                left: scaleSize(15, 38),
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    'AA1234BB',
                    style: TextStyle(
                      fontFamily: AppFonts.halvarEng,
                      fontWeight: FontWeight.w500,
                      letterSpacing: scaleSize(1.2, 3.2),
                      height: .94,
                      color: const Color(0xFF010101),
                      fontSize: scaleSize(12, 32),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (plateType case PlateType.brazilian) {
        // Brazilian plate
        return SizedBox(
          width: scaleSize(74, 195),
          height: scaleSize(16, 45),
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  ParkingImages.plateBrazil,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                left: scaleSize(10, 26),
                top: scaleSize(4, 14),
                child: Text(
                  'ABC-1234',
                  style: TextStyle(
                    fontFamily: AppFonts.halvarEng,
                    fontWeight: FontWeight.w500,
                    letterSpacing: scaleSize(1.2, 3.2),
                    height: .94,
                    color: const Color(0xFF010101),
                    fontSize: scaleSize(12, 32),
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (plateType case PlateType.empty) {
        // Empty plate
        return SizedBox(
          width: scaleSize(74, 195),
          height: scaleSize(16, 45),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(ParkingImages.plateEmpty, fit: BoxFit.fill),
              ),
              Center(
                child: Text(
                  'НОМЕРА НЕТ',
                  style: TextStyle(
                    fontFamily: AppFonts.halvarEng,
                    fontWeight: FontWeight.w500,
                    letterSpacing: scaleSize(0.7, 1.8), // 10% of font size
                    height: .94,
                    color: const Color(0xFF010101),
                    fontSize: scaleSize(7, 18),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        // Russian plate
        return SizedBox(
          width: scaleSize(74, 195),
          height: scaleSize(16, 45),
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  ParkingImages.plateRus,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                left: scaleSize(8, 22),
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    'A123BC',
                    style: TextStyle(
                      fontFamily: AppFonts.halvarEng,
                      fontWeight: FontWeight.w500,
                      letterSpacing: scaleSize(1.2, 3.2),
                      height: .94,
                      color: const Color(0xFF010101),
                      fontSize: scaleSize(12, 32),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: scaleSize(4, 10),
                top: scaleSize(3, 8),
                child: Center(
                  child: Text(
                    '777',
                    style: TextStyle(
                      fontFamily: AppFonts.halvarEng,
                      letterSpacing: scaleSize(0.4, 1.05),
                      height: .94,
                      fontWeight: FontWeight.w500,
                      fontSize: scaleSize(8, 21),
                      color: const Color(0xFF010101),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    },
  );
}
