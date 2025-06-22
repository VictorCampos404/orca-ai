import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final bool enable;
  final String text;
  final Function onTap;
  final bool vibration;
  final bool isloading;
  final Color? color;
  final Color? textColor;
  final bool border;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.enable,
    required this.onTap,
    this.vibration = false,
    this.isloading = false,
    this.color,
    this.textColor,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: AbsorbPointer(
        absorbing: !enable || isloading,
        child: ElevatedButton(
          style: ButtonStyle(
            side:
                border
                    ? WidgetStateProperty.all(
                      BorderSide(
                        color: enable ? AppColors.text : AppColors.disable,
                        width: 1,
                      ),
                    )
                    : null,
            backgroundColor: WidgetStateProperty.all(
              enable ? (color ?? AppColors.primary) : AppColors.disable,
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            elevation: WidgetStateProperty.all(0),
          ),
          onPressed: () => enable ? onPressed() : null,
          child:
              isloading
                  ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: color ?? AppColors.primary,
                      strokeWidth: 2,
                      backgroundColor: textColor ?? Colors.white,
                    ),
                  )
                  : Text(
                    text,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.button.copyWith(
                      color: textColor ?? Colors.white,
                    ),
                  ),
        ),
      ),
    );
  }

  void onPressed() async {
    onTap();
  }
}
