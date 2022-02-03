import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horolux/clock_screen/clock_screen_state.dart';
import 'package:horolux/presets/hl_colors.dart';


class ClockScreenBlock extends Bloc<Void, ClockScreenState> {
  TimeOfDay wakeupTime; 
  Duration lightDuration = new Duration(minutes: 1);
  ClockScreenBlock() : super(ClockScreenState(_timeString(DateTime.now()), HLColors.background, HLColors.accent)) {
    _updateTime();
    // testing pourpuses
    var now = TimeOfDay.now();
    wakeupTime = TimeOfDay(hour: now.hour, minute: now.minute + lightDuration.inMinutes);
  }
  
  void _updateTime(){
      var time = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      var _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: time.second) -
            Duration(milliseconds: time.millisecond),
        _updateTime
      );  

    }
  static String _timeString(DateTime t){
    return (t.hour.toString() + ":" + t.minute.toString());
  }
  
  static ClockScreenState _genState(TimeOfDay time) {
    var now = DateTime.now();
    var timeString = _timeString(now);
    var dtw = DateTime(now.year, now.month, now.day, wakeupTime.hour, wakeupTime.minute);
    Color background;
    if (now.add(this.lightDuration).isAfter(dtw)){
      var progress = (now.microsecondsSinceEpoch - dtw.microsecondsSinceEpoch) / lightDuration.inMicroseconds;  
      background = Color.lerp(HLColors.background, HLColors.accent, progress) ?? Colors.red;
    } else {
      background = HLColors.background; 
    }
    return ClockScreenState(timeString, background, HLColors.accent);
  }
}