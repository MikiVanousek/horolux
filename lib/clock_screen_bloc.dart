import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'clock_screen_state.dart';

class ClockScreenBlock extends Bloc<Void, ClockScreenState> {
  ClockScreenBlock() : super(new ClockScreenState(_timeString(DateTime.now()))) {
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
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      // _timer = Timer(
      //   Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
      //   _updateTime,
      // );
    }
  static String _timeString(DateTime t){
    return (t.hour.toString() + ":" + t.minute.toString());
  }
}