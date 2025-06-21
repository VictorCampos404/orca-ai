import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';

class SecondaryButton extends StatelessWidget {
  final bool enable;
  final String text;
  final Function onTap;
  final bool vibration;
  final bool isloading;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.enable,
    required this.onTap,
    this.vibration = false,
    this.isloading = false,
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
            backgroundColor: WidgetStateProperty.all(AppColors.background),
            side: WidgetStateProperty.all(
              BorderSide(
                color: enable ? AppColors.text : AppColors.disable,
                width: 1,
              ),
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
                      color: AppColors.background,
                      strokeWidth: 2,
                      backgroundColor: AppColors.text,
                    ),
                  )
                  : Text(
                    text,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.button.copyWith(
                      color: enable ? AppColors.text : AppColors.disable,
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
