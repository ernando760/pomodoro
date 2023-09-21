import 'package:flutter/material.dart';
import 'package:pomodoro_timer/src/controllers/pomodoro_controller.dart';
import 'package:provider/provider.dart';

class PomodoroWidget extends StatelessWidget {
  const PomodoroWidget({
    super.key,
  });
  Widget _buildButtonsStartPauseStop(PomodoroController pomodoroController) {
    return ChangeNotifierProvider<PomodoroController>.value(
        value: pomodoroController,
        builder: (context, _) {
          return SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () => context
                        .read<PomodoroController>()
                        .playAndPausePomodoro(),
                    child: pomodoroController.isActiveTimerPomodoro
                        ? Icon(
                            Icons.pause,
                            color: pomodoroController.pomodoroStatus.color,
                          )
                        : Icon(
                            Icons.play_arrow,
                            color: pomodoroController.pomodoroStatus.color,
                          )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: pomodoroController.isActiveTimerPomodoro
                        ? () =>
                            context.read<PomodoroController>().stopPomodoro()
                        : null,
                    child: Icon(
                      Icons.stop,
                      color: pomodoroController.pomodoroStatus.color,
                    )),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          );
        });
  }

  Widget _buildTimerPomodoro(PomodoroController pomodoroController) {
    return SizedBox(
      child: ChangeNotifierProvider<PomodoroController>.value(
        value: pomodoroController,
        builder: (context, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  value: pomodoroController.progressValue,
                  color: Colors.white,
                  strokeWidth: 8.0,
                ),
              ),
              Text(
                pomodoroController.pomodoroTimer,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pomodoroController = context.watch<PomodoroController>();
    return SizedBox(
      child: Column(
        children: [
          _buildTimerPomodoro(pomodoroController),
          const SizedBox(
            height: 15,
          ),
          _buildButtonsStartPauseStop(pomodoroController)
        ],
      ),
    );
  }
}
