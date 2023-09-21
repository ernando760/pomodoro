import 'package:flutter/material.dart';
import 'package:pomodoro_timer/src/screens/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pomodoro Timer",
      home: HomePage(),
    );
  }
}
