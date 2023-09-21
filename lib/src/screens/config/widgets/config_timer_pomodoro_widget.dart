// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ConfigTimerPomodoroWidget extends StatelessWidget {
  const ConfigTimerPomodoroWidget({
    super.key,
    required this.title,
    required this.incrementMinutesPomodoro,
    required this.incrementSecondsPomodoro,
    required this.decrementMinutesPomodoro,
    required this.decrementSecondsPomodoro,
    required this.minutesText,
    required this.secondsText,
  });
  final String title;
  final String minutesText;
  final String secondsText;

  final void Function() incrementMinutesPomodoro;
  final void Function() decrementMinutesPomodoro;
  final void Function() incrementSecondsPomodoro;
  final void Function() decrementSecondsPomodoro;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Minutes:", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      splashRadius: 25,
                      iconSize: 25,
                      onPressed: incrementMinutesPomodoro,
                      icon: const Icon(Icons.arrow_upward)),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(minutesText,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600)),
                  ),
                  IconButton(
                      onPressed: decrementMinutesPomodoro,
                      splashRadius: 25,
                      iconSize: 25,
                      icon: const Icon(Icons.arrow_downward)),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Seconds:", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: incrementSecondsPomodoro,
                      splashRadius: 25,
                      iconSize: 25,
                      icon: const Icon(Icons.arrow_upward)),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        secondsText,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      )),
                  IconButton(
                      onPressed: decrementSecondsPomodoro,
                      splashRadius: 25,
                      iconSize: 25,
                      icon: const Icon(Icons.arrow_downward)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
