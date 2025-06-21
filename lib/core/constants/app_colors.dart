import 'package:flutter/material.dart';

class AppColors {
  AppColors();

  static const Color transparent = Colors.transparent;
  static const Color text = Color(0xFF2C2C2C);
  static const Color primary = Color(0xFF425664);
  static const Color pdf = Color(0xFFC01E2D);
  static const Color microphone = Color(0xFFC01E2D);
  static const Color success = Color(0xFF0C7C59);
  static const Color error = Color(0xFFC01E2D);
  static const Color warning = Color(0xFFFFBA08);
  static const Color background = Color(0xFFFCFAF4);
  static const Color backgroundSmoke = Color(0xFFF4F4F4);
  static const Color purple = Color(0xFF6D00AD);
  static const Color blue = Color(0xFF3D93CF);

  static Color disable = const Color(0xFF747474).withOpacity(0.5);
  static Color grey = const Color(0xFF747474);
  static const LinearGradient gemini = LinearGradient(
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.bottomEnd,
    colors: [purple, blue],
  );
  static LinearGradient geminiTranslucent = LinearGradient(
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.bottomEnd,
    colors: [purple.withOpacity(0.5), blue.withOpacity(0.5)],
  );
  static ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: primary);
}
