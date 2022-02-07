import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horolux/clock/clock_screen.dart';
import 'package:horolux/clock/clock_screen_bloc.dart';
import 'package:horolux/presets/hl_colors.dart';
import 'package:horolux/settings/settings_screen.dart';
import 'package:horolux/settings/settings_screen_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SettingsScreenBloc(),
        child: MaterialApp(
          theme: HLColors.materialTheme,
          home: SettingsScreen(),
        ));
  }
}
