import 'package:flutter/cupertino.dart';
import 'package:horolux/presets/hl_colors.dart';

class HLTextstyles {
  static TextStyle base = new TextStyle(
    color: HLColors.accent,
    decoration: TextDecoration.none,
  );

  static TextStyle clock = base.copyWith(fontSize: 48);
}