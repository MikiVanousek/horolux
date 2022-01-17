import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horolux/clock_screen_bloc.dart';
import 'package:horolux/clock_screen_state.dart';

class ClockScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ClockScreenBlock, ClockScreenState>(
        builder: (_, state) => Text(state.time))
    );
  }

}