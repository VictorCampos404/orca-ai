import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/spaces.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.color,
    this.icon,
    this.enable,
    this.isLoading,
    this.onTap,
    this.size,
    this.badged,
    this.badgedColor,
  });

  final Function()? onTap;
  final IconData? icon;
  final Color? color;
  final double? size;
  final bool? enable;
  final bool? isLoading;
  final bool? badged;
  final Color? badgedColor;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: (isLoading ?? false) || !(enable ?? true),
      child: Material(
        color:
            badged ?? false
                ? badgedColor ?? AppColors.backgroundSmoke
                : AppColors.transparent,
        borderRadius: BorderRadius.circular(360),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(360),
          child: Container(
            decoration: BoxDecoration(
              color:
                  !(isLoading ?? false)
                      ? AppColors.transparent
                      : (color ?? AppColors.text),
              borderRadius: BorderRadius.circular(360),
            ),
            padding: const EdgeInsets.all(Spaces.x1),
            child: Icon(icon, color: color ?? AppColors.text, size: size),
          ),
        ),
      ),
    );
  }
}
