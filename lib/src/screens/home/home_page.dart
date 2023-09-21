import 'package:flutter/material.dart';
import 'package:pomodoro_timer/src/screens/config/config_page.dart';
import 'package:pomodoro_timer/src/controllers/pomodoro_controller.dart';
import 'package:pomodoro_timer/src/screens/home/widgets/interval_pomodoro_widget.dart';
import 'package:pomodoro_timer/src/screens/home/widgets/timer_pomodoro_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildtogglePomodoro(PomodoroController pomodoroController) {
    return ChangeNotifierProvider<PomodoroController>.value(
      value: pomodoroController,
      builder: (context, child) {
        return Expanded(
          child: SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () =>
                      context.read<PomodoroController>().skipIntervalPomodoro(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: pomodoroController.pomodoroStatus ==
                                PomodoroStatus.pomodoro
                            ? Colors.white
                            : Colors.transparent.withOpacity(.1)),
                    child: Text(
                      "Pomodoro",
                      style: TextStyle(
                          color: pomodoroController.pomodoroStatus ==
                                  PomodoroStatus.pomodoro
                              ? pomodoroController.pomodoroStatus.color
                              : pomodoroController.pomodoroStatus.color
                                  .withOpacity(.9),
                          fontSize: 22),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () =>
                      context.read<PomodoroController>().skipPomodoro(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: pomodoroController.pomodoroStatus ==
                                PomodoroStatus.interval
                            ? Colors.white
                            : Colors.transparent.withOpacity(.1)),
                    child: Text(
                      "Interval",
                      style: TextStyle(
                          color: pomodoroController.pomodoroStatus ==
                                  PomodoroStatus.interval
                              ? pomodoroController.pomodoroStatus.color
                              : pomodoroController.pomodoroStatus.color
                                  .withOpacity(.9),
                          fontSize: 22),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openConfigPage(PomodoroController pomodoroController) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ConfigPage(),
      ),
    );
    if (context.read<PomodoroController>().isPomodoro) {
      context.read<PomodoroController>().stopPomodoro();
    } else {
      context.read<PomodoroController>().stopIntervalPomodoro();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pomodoroController = context.watch<PomodoroController>();
    return Scaffold(
      backgroundColor: pomodoroController.pomodoroStatus.color,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildtogglePomodoro(pomodoroController),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Visibility(
                    visible: pomodoroController.isPomodoro,
                    replacement: const IntervalPomodoroWidget(),
                    child: const PomodoroWidget()),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openConfigPage(pomodoroController),
        backgroundColor: Colors.white,
        child: Icon(
          Icons.timer_outlined,
          color: pomodoroController.pomodoroStatus.color,
        ),
      ),
    );
  }
}
