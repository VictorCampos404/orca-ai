import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/core/constants/custom_icons.dart';
import 'package:orca_ai/core/enums/device.dart';
import 'package:orca_ai/core/models/request_result.dart';

class PopUp {
  PopUp._();

  static void showResult({RequestResult? result}) {
    if (result == null) return;

    if (!result.status) {
      showError(result.title ?? '', message: result.message);
      return;
    }

    if ((result.title ?? '').isNotEmpty || (result.message ?? '').isNotEmpty) {
      showSuccess(result.title ?? '', message: result.message);
    }
  }

  static void showNotification(String title, {String? message}) {
    final context = Modular.routerDelegate.navigatorKey.currentContext;

    if (context == null) return;

    Flushbar(
      maxWidth: Device.phone.maxWidth,
      duration: const Duration(seconds: 4),
      icon: Icon(CustomIcons.notification_2_fill, color: AppColors.warning),
      boxShadows: <BoxShadow>[
        BoxShadow(
          color: AppColors.disable,
          blurRadius: 7.0,
          offset: const Offset(0.0, 0.75),
        ),
      ],
      backgroundColor: AppColors.background,
      borderRadius: BorderRadius.circular(5),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.fromLTRB(20, 12, 16, 12),
      titleText: Text(
        title,
        style: AppTextStyles.itemTitle.copyWith(
          color: AppColors.warning,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText:
          message == null
              ? const SizedBox()
              : Text(message, style: AppTextStyles.itemTitle),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  static void showError(String title, {String? message}) {
    final context = Modular.routerDelegate.navigatorKey.currentContext;

    if (context == null) return;

    Flushbar(
      maxWidth: Device.phone.maxWidth,
      duration: const Duration(seconds: 4),
      icon: Icon(CustomIcons.error_warning_fill, color: AppColors.error),
      boxShadows: <BoxShadow>[
        BoxShadow(
          color: AppColors.disable,
          blurRadius: 7.0,
          offset: const Offset(0.0, 0.75),
        ),
      ],
      backgroundColor: AppColors.background,
      borderRadius: BorderRadius.circular(5),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.fromLTRB(20, 12, 16, 12),
      titleText: Text(
        title,
        style: AppTextStyles.itemTitle.copyWith(
          color: AppColors.error,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText:
          message == null
              ? const SizedBox()
              : Text(message, style: AppTextStyles.itemTitle),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  static void showSuccess(String title, {String? message}) {
    final context = Modular.routerDelegate.navigatorKey.currentContext;

    if (context == null) return;

    Flushbar(
      maxWidth: Device.phone.maxWidth,
      duration: const Duration(seconds: 4),
      icon: Icon(CustomIcons.checkbox_circle_fill, color: AppColors.success),
      boxShadows: <BoxShadow>[
        BoxShadow(
          color: AppColors.disable,
          blurRadius: 7.0,
          offset: const Offset(0.0, 0.75),
        ),
      ],
      backgroundColor: AppColors.background,
      borderRadius: BorderRadius.circular(5),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.fromLTRB(20, 12, 16, 12),
      titleText: Text(
        title,
        style: AppTextStyles.itemTitle.copyWith(
          color: AppColors.success,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText:
          message == null
              ? const SizedBox()
              : Text(message, style: AppTextStyles.itemTitle),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}
