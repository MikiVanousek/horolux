import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horolux/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreenBloc extends Cubit<Settings?> {
  static const key = 'HL_SETTINGS';
  static const defualtSettings =
      Settings(TimeOfDay(hour: 7, minute: 0), Duration(minutes: 30));
  late SharedPreferences prefs;
  SettingsScreenBloc() : super(defualtSettings) {
    _queryPres();
  }

  void _queryPres() async {
    prefs = await SharedPreferences.getInstance();
    var ss = prefs.getString(key);
    if (ss != null) {
      try {
        emit(Settings.fromJson(ss));
        return;
      } catch (_) {
        debugPrint(
            'The json representation of the settings saved in shared preferences is invalid!\n$ss');
      }
    }
    emit(defualtSettings);
  }
  
  Future<bool> updateSettings(Settings newSettings) async {
    await prefs.setString(key, newSettings.toJson());
    emit(newSettings);
    return true;
  }
}
