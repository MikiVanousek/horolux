import 'package:flutter/material.dart';
import 'package:horolux/settings/settings.dart';
import 'package:test/test.dart';
void main() {
  test('Serilizing the Setting class', () {
    Settings s = Settings(TimeOfDay(hour: 23, minute: 3), Duration(minutes: 30));
    assert(Settings.fromJson(s.toJson()) == s);

    s = Settings(TimeOfDay(hour: 26, minute: 69), Duration(hours: 100));
    assert(Settings.fromJson(s.toJson()) == s);
  });
}