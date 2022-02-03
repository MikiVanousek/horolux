import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horolux/presets/hl_colors.dart';

import 'clock_screen_state.dart';

class ClockScreenBlock extends Bloc<Void, ClockScreenState> {
  ClockScreenBlock() : super(ClockScreenState(_timeString(DateTime.now()), HLColors.background, HLColors.accent)) {
    _updateTime();
  }
  
  void _updateTime(){
      var time = DateTime.now();
      emit(new ClockScreenState(_timeString(time)));
      // Update once per minute. If you want to update every second, use the
      // following code.
      var _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: time.second) -
            Duration(milliseconds: time.millisecond),
        _updateTime,
      );  
  }

  static String _timeString(DateTime t){
    return (t.hour.toString() + ":" + t.minute.toString());
  }
}