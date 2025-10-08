import 'package:carflutter_2025sep/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class ParamTile extends StatelessWidget {
  const ParamTile({
    required this.titleText,
    this.value,
    this.valueText = '',
    super.key,
  });
  final String titleText;
  final Widget? value;
  final String valueText;

  @override
  Widget build(final BuildContext context) => Container(
    constraints: const BoxConstraints(maxWidth: 248.06),
    padding: const EdgeInsets.symmetric(horizontal: 15.68, vertical: 9.8),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [AppColors.white0, AppColors.white20, AppColors.white0],
      ),
      borderRadius: BorderRadius.circular(11.76),
    ),
    child: Row(
      children: [
        Text(titleText),
        const Spacer(),
        if (valueText.isEmpty)
          value ?? const SizedBox.shrink()
        else
          Text(valueText),
      ],
    ),
  );
}
