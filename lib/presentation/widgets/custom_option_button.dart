import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/core/constants/spaces.dart';

class CustomOptionButton extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;
  final String? text;

  const CustomOptionButton({super.key, this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spaces.x2,
            vertical: Spaces.x1,
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spaces.x2),
                  child: Text(
                    text ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.optionTitle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
