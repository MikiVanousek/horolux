import 'dart:convert';

import 'package:flutter/material.dart';

class Settings {
  final TimeOfDay wakeupTime;
  final Duration lightDuration;

  const Settings(this.wakeupTime, this.lightDuration);

  Settings copyWith({
    TimeOfDay? wakeupTime,
    Duration? lightDuration,
  }) {
    return Settings(
      wakeupTime ?? this.wakeupTime,
      lightDuration ?? this.lightDuration,
    );
  }

  Map<String, String> toMap() {
    return {
      'wakeupTime' : '${wakeupTime.hour}:${wakeupTime.minute}',
      'lightDuration': lightDuration.inSeconds.toString(),
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    var times = map['wakeupTime']?.split(':');
    var dur = map['lightDuration'];
    if (dur == null || times == null || times.length != 2) {
      throw Exception("Illegal argument!");
    }
    var wt = TimeOfDay(hour: int.parse(times[0]), minute: int.parse(times[1]));
    var ld = Duration(seconds: int.parse(dur));
    return Settings(
      wt,
      ld,
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Settings &&
        other.wakeupTime == wakeupTime &&
        other.lightDuration == lightDuration;
  }

  @override
  int get hashCode => wakeupTime.hashCode ^ lightDuration.hashCode;
}
