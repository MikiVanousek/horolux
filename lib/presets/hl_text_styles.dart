import 'package:flutter/cupertino.dart';
import 'package:horolux/presets/hl_colors.dart';

class HLTextstyles {
  static final TextStyle base = TextStyle(
        color: HLColors.accent,
        decoration: TextDecoration.none,
      ),
      clock = base.copyWith(fontSize: 72),
      label = base.copyWith(
        fontSize: 24,
        color: HLColors.accentDull,
      ),
      labelAccent = label.copyWith(
        color: HLColors.accent,
      ),
      display = base.copyWith(fontSize: 72),
      button = base.copyWith(
        fontSize: 32,
        color: HLColors.background,
      );
}
