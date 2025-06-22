import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/spaces.dart';

class WidgetBottomSheet {
  static Future<void> show({
    required BuildContext context,
    bool? isDismissible,
    Widget? child,
  }) async {
    await showModalBottomSheet(
      backgroundColor: AppColors.transparent,
      context: context,
      isDismissible: isDismissible ?? true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          margin: const EdgeInsets.only(top: Spaces.x8),
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
