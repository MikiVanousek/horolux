import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horolux/clock_screen/clock_screen_state.dart';
import 'package:horolux/presets/hl_colors.dart';


class ClockScreenBlock extends Bloc<Void, ClockScreenState> {
  TimeOfDay wakeupTime; 
  final Duration lightDuration = Duration(minutes: 1); 

  ClockScreenBlock() : 
    wakeupTime = TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute + 1),
    super(ClockScreenState(_timeString(DateTime.now()), HLColors.background, HLColors.accent)) {
      _updateTime();
    }
  
  void _updateTime(){
      var time = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      var _timer = Timer(
        Duration(seconds: 1) - 
          Duration(milliseconds: time.millisecond),
        _updateTime
      );  
      emit(_genState(time));
    }
  static String _timeString(DateTime t){
    return (t.hour.toString() + ":" + t.minute.toString());
  }
  
  ClockScreenState _genState(DateTime time) {
    var timeString = _timeString(time);
    var dtw = DateTime(time.year, time.month, time.day, wakeupTime.hour, wakeupTime.minute);
    Color background, text;
    if (time.add(lightDuration).isAfter(dtw)){
      var progress = 1-(dtw.millisecondsSinceEpoch - time.millisecondsSinceEpoch) / lightDuration.inMilliseconds;
      background = Color.lerp(HLColors.background, HLColors.accent, progress) ?? Colors.red;
      text = progress > 0.5 ? HLColors.background : HLColors.accent;
    } else {
      background = HLColors.background; 
      text = HLColors.accent;
    }
    return ClockScreenState(timeString, background, text);
  }
}