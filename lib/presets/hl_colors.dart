import 'package:flutter/material.dart';

class HLColors {
  static const Color background = Colors.black,
      accent = Colors.white,
      accentDull = Color(0xFFBCBCBC);

  static final materialTheme = ThemeData(
    // time picker background
    cardColor: accentDull,
    colorScheme: ColorScheme.dark(
      primary: accent,
      secondary: background,
    ),
  );
}
