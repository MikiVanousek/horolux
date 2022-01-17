import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horolux/clock_screen.dart';
import 'package:horolux/clock_screen_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return BlocProvider(
        create: (_) => ClockScreenBlock(), 
        child: MaterialApp(
            theme: new ThemeData(),
            home: Material(child: ClockScreen()),
          )
      );
  }
}