import 'package:flutter/material.dart';

class HLColors {
  static const Color background = Colors.black,
      card = Color(0xFF222222),
      accent = Colors.white,
      accentDull = Color(0xFFBCBCBC);

  static final materialTheme = ThemeData(
    // time picker background
    // cardColor: accentDull,
    timePickerTheme: TimePickerThemeData(
      backgroundColor: card,
      hourMinuteColor: MaterialStateColor.resolveWith(
          (states) => states.contains(MaterialState.selected) ? accent : card),
      hourMinuteTextColor: MaterialStateColor.resolveWith(
        (states) =>
            states.contains(MaterialState.selected) ? background : accentDull,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: accent,
      secondary: background,
    ),
  );
}
