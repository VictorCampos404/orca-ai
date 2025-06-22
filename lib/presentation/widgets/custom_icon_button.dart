import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/spaces.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.color,
    this.icon,
    this.enable,
    this.onTap,
    this.size,
    this.badged,
    this.badgedColor,
    this.padding,
    this.gradient,
  });

  final Function()? onTap;
  final IconData? icon;
  final Color? color;
  final double? size;
  final bool? enable;
  final bool? badged;
  final Color? badgedColor;
  final EdgeInsets? padding;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !(enable ?? true),
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
              borderRadius: BorderRadius.circular(360),
              gradient: gradient,
            ),
            padding: padding ?? const EdgeInsets.all(Spaces.half),
            child: Icon(icon, color: color ?? AppColors.text, size: size),
          ),
        ),
      ),
    );
  }
}
