import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/core/constants/spaces.dart';

class CustomToastButton extends StatelessWidget {
  const CustomToastButton({
    super.key,
    this.icon,
    this.text,
    this.enable,
    this.onTap,
    this.badged,
    this.badgedColor,
  });

  final Function()? onTap;
  final IconData? icon;
  final String? text;
  final bool? enable;
  final bool? badged;
  final Color? badgedColor;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !(enable ?? true),
      child: Material(
        color:
            badged ?? false
                ? badgedColor ?? AppColors.backgroundSmoke
                : AppColors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(360),
          side: BorderSide(color: AppColors.disable, width: 0.5),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(360),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(360)),
            padding: const EdgeInsets.symmetric(
              vertical: Spaces.half,
              horizontal: Spaces.x1_half,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(text ?? '', style: AppTextStyles.toast),
                const SizedBox(width: Spaces.half),
                Icon(icon, color: AppColors.text, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
