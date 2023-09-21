import 'package:flutter/material.dart';
import 'package:pomodoro_timer/src/controllers/pomodoro_controller.dart';
import 'package:pomodoro_timer/src/screens/config/widgets/config_timer_pomodoro_widget.dart';
import 'package:provider/provider.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({
    super.key,
  });

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  Widget _buildConfigTimerPomodoro(PomodoroController pomodoroController) {
    return AnimatedBuilder(
        animation: pomodoroController,
        builder: (context, _) {
          return ConfigTimerPomodoroWidget(
            title: "Pomodoro",
            minutesText: pomodoroController.minutesPomodoroText,
            secondsText: pomodoroController.secondsPomodoroText,
            incrementMinutesPomodoro: () => context
                .read<PomodoroController>()
                .changeMinutesPomodoro(pomodoroController.minutesPomodoro + 1),
            incrementSecondsPomodoro: () => context
                .read<PomodoroController>()
                .changeSecondsPomodoro(pomodoroController.secondsPomodoro + 1),
            decrementMinutesPomodoro: () => context
                .read<PomodoroController>()
                .changeMinutesPomodoro(pomodoroController.minutesPomodoro - 1),
            decrementSecondsPomodoro: () => context
                .read<PomodoroController>()
                .changeSecondsPomodoro(pomodoroController.secondsPomodoro - 1),
          );
        });
  }

  Widget _buildConfigTimerIntervalPomodoro(
      PomodoroController pomodoroController) {
    return AnimatedBuilder(
        animation: pomodoroController,
        builder: (context, _) {
          return ConfigTimerPomodoroWidget(
            title: "Intervalo",
            minutesText: pomodoroController.minutesIntervalPomodoroText,
            secondsText: pomodoroController.secondsIntervalPomodoroText,
            incrementMinutesPomodoro: () => context
                .read<PomodoroController>()
                .changeMinutesIntervalPomodoro(
                    pomodoroController.minutesIntervalPomodoro + 1),
            incrementSecondsPomodoro: () => context
                .read<PomodoroController>()
                .changeSecondsIntervalPomodoro(
                    pomodoroController.secondsIntervalPomodoro + 1),
            decrementMinutesPomodoro: () => context
                .read<PomodoroController>()
                .changeMinutesIntervalPomodoro(
                    pomodoroController.minutesIntervalPomodoro - 1),
            decrementSecondsPomodoro: () => context
                .read<PomodoroController>()
                .changeSecondsIntervalPomodoro(
                    pomodoroController.secondsIntervalPomodoro - 1),
          );
        });
  }

  Widget _buildTitlePage() {
    return Expanded(
        child: Container(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            iconSize: 26,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Configuration",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final PomodoroController pomodoroController =
        context.watch<PomodoroController>();
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          _buildTitlePage(),
          Expanded(
              flex: 4,
              child: SizedBox(
                child: Column(
                  children: [
                    _buildConfigTimerPomodoro(pomodoroController),
                    _buildConfigTimerIntervalPomodoro(pomodoroController)
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
