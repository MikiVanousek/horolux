import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horolux/clock_screen/clock_screen_state.dart';
import 'package:horolux/clock_screen_bloc.dart';
import 'package:horolux/presets/hl_text_styles.dart';

class ClockScreen extends StatelessWidget {
  const ClockScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClockScreenBlock, ClockScreenState>(
      builder: (_, state) => Container(
        color: state.backgroundColor,
        child: Center(child: Text(state.time, style: HLTextstyles.clock.copyWith(color: state.textColor),),)
      )
    );
  }

}