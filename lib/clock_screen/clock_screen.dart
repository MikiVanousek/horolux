import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horolux/clock_screen/clock_screen_state.dart';
import 'package:horolux/clock_screen/clock_screen_bloc.dart';
import 'package:horolux/presets/hl_text_styles.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:wakelock/wakelock.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {

  @override
  void initState(){
    FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
    Wakelock.enable();
    super.initState();
  }

  
  @override
  void dispose(){
    FullScreen.exitFullScreen();
    Wakelock.disable();
    super.dispose();
  }

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