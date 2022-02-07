import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horolux/clock/clock_screen_state.dart';
import 'package:horolux/presets/hl_colors.dart';
import 'package:horolux/settings/settings.dart';

class ClockScreenBlock extends Cubit<ClockScreenState> {
  final Duration lightDuration;
  final DateTime wakeupTime;
  final BuildContext context;

  ClockScreenBlock(Settings settings, this.context)
      : lightDuration = settings.lightDuration,
        wakeupTime = _nextDateTime(settings.wakeupTime),
        super(ClockScreenState(
          settings.wakeupTime.toString(),
          HLColors.background,
          HLColors.accent,
        )) {
    _updateTime();
  }

  static DateTime _nextDateTime(TimeOfDay timeOfDay) {
    var now = DateTime.now();
    // tests if the selected time already happened today
    int extraDay = 0;
    if (now.hour > timeOfDay.hour ||
        (now.hour == timeOfDay.hour && now.minute >= timeOfDay.minute)) {
      extraDay = 1;
    }
    var today = DateTime(now.year, now.month, now.day + extraDay,
        timeOfDay.hour, timeOfDay.minute);
    if(!today.isAfter(now)){
      throw Exception('Time of wake up is not in the future!');
    }
    return today;
  }

  void _updateTime() {
    if(super.isClosed){
      return;
    }
    var time = DateTime.now();
    // TODO varible update rate - update often only if nessecary
    var _timer = Timer(
        const Duration(seconds: 1) - Duration(milliseconds: time.millisecond),
        _updateTime);
    emit(_genState(time));
  }

  // TODO format properly with context and user prefs
  static String _timeString(DateTime t) {
    var h = t.hour.toString();
    if (h.length < 2) h += ' ';
    var m = t.minute.toString();
    if (m.length < 2) m = '0' + m;

    return h + ':' + m;
  }

  ClockScreenState _genState(DateTime time) {
    var timeString = _timeString(time);
    Color background, text;
    if (time.add(lightDuration).isAfter(wakeupTime)) {
      var progress = 1 -
          (wakeupTime.millisecondsSinceEpoch - time.millisecondsSinceEpoch) /
              lightDuration.inMilliseconds;
      background = Color.lerp(HLColors.background, HLColors.accent, progress) ??
          Colors.red;
      text = progress > 0.5 ? HLColors.background : HLColors.accent;
    } else {
      background = HLColors.background;
      text = HLColors.accent;
    }
    return ClockScreenState(timeString, background, text);
  }
}
