import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horolux/clock/clock_screen_bloc.dart';
import 'package:horolux/clock/clock_screen_state.dart';
import 'package:horolux/presets/hl_colors.dart';
import 'package:horolux/presets/hl_text_styles.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:horolux/settings/settings.dart';
import 'package:horolux/settings/settings_screen.dart';
import 'package:horolux/settings/settings_screen_bloc.dart';
import 'package:wakelock/wakelock.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  void initState() {
    super.initState();
    // This is broken, I filed an issue on github.
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Wakelock.enable();
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsScreenBloc, Settings?>(
      builder: (context, state) {
        if (state == null) {
          debugPrint(
              'Major internal error! This screen was entered without settings.');
          Navigator.of(context).pop();
          return Container();
        }
        return BlocProvider(
          create: (context) => ClockScreenBlock(state, context),
          child: BlocBuilder<ClockScreenBlock, ClockScreenState>(
              builder: (context, state) => Material(
                    child: Container(
                      color: state.backgroundColor,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: IconButton(
                              // onPressed: () => Navigator.of(context).push(
                              // MaterialPageRoute(builder: (_) => SettingsScreen())),
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(
                                Icons.settings,
                                color: state.accentColor,
                                size: 32,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              state.time,
                              style: HLTextstyles.clock
                                  .copyWith(color: state.accentColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
        );
      },
    );
  }
}
