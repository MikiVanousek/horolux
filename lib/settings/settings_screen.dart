import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_pickers/helpers/show_scroll_picker.dart';
import 'package:horolux/clock/clock_screen.dart';
import 'package:horolux/main.dart';
import 'package:horolux/presets/hl_colors.dart';
import 'package:horolux/presets/hl_text_styles.dart';
import 'package:horolux/settings/settings.dart';
import 'package:horolux/settings/settings_screen_bloc.dart';

class SettingsScreen extends StatelessWidget {
  static const avalibleDurations = [3, 5, 10, 15, 20, 25, 30, 40, 50, 60];
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HLColors.background,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<SettingsScreenBloc, Settings?>(
                  builder: (context, state) {
                    if (state == null) {
                      return Container();
                    }
                    return IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 64,
                          ),
                          Text(
                            "Wakeup time:",
                            style: HLTextstyles.label,
                          ),
                          GestureDetector(
                            onTap: () => changeTime(context, state),
                            child: Text(
                              state.wakeupTime.format(context),
                              style: HLTextstyles.display,
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            "Light duration:",
                            style: HLTextstyles.label,
                          ),
                          SizedBox(
                            height: 100,
                            child: GestureDetector(
                              onTap: () => changeDuration(context, state),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.ideographic,
                                children: [
                                  Text(
                                    state.lightDuration.inMinutes.toString(),
                                    style: HLTextstyles.display,
                                  ),
                                  Text(
                                    " minutes",
                                    style: HLTextstyles.labelAccent,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ClockScreen())),
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: HLColors.accent),
                child: Center(
                    child: Text(
                  "Start",
                  style: HLTextstyles.button,
                )),
              ),
            ),
            SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }

  void changeTime(BuildContext context, Settings state) async {
    var selectedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (selectedTime != null) {
      var bloc = BlocProvider.of<SettingsScreenBloc>(context);
      bloc.updateSettings(state.copyWith(wakeupTime: selectedTime));
    }
  }

  void changeDuration(BuildContext context, Settings state) async {
    List<SimpleDialogOption> options = [];
    final bloc = BlocProvider.of<SettingsScreenBloc>(context);
    for (var i in avalibleDurations) {
      options.add(
        SimpleDialogOption(
          child: Text(
            i.toString() + ' minutes',
            style: state.lightDuration.inMinutes == i
                ? HLTextstyles.labelAccent
                : HLTextstyles.label,
          ),
          onPressed: () {
            bloc.updateSettings(
                state.copyWith(lightDuration: Duration(minutes: i)));
            Navigator.of(context).pop();
          },
        ),
      );
    }
    showDialog(
        context: context,
        builder: (_) => SimpleDialog(
              backgroundColor: HLColors.card,
              children: options,
            ));
  }
}
