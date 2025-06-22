import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/core/constants/spaces.dart';
import 'package:orca_ai/presentation/widgets/custom_icon_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final CustomIconButton? leading;
  final List<CustomIconButton>? actions;
  const CustomAppBar({super.key, this.title, this.leading, this.actions});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.background,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.background,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Container(
          color: AppColors.background,
          padding: const EdgeInsets.only(
            top: Spaces.x4,
            left: Spaces.x2,
            right: Spaces.x2,
            bottom: Spaces.x2,
          ),
          child: Row(
            children: [
              if (leading != null)
                Padding(
                  padding: const EdgeInsets.only(right: Spaces.x2),
                  child: leading!,
                ),
              Expanded(child: Text(title ?? '', style: AppTextStyles.title)),
              if (actions != null)
                for (int i = 0; i < actions!.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(left: Spaces.x2),
                    child: actions![i],
                  ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(0, 80);
}
