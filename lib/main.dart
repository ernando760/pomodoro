import 'package:flutter/material.dart';
import 'package:pomodoro_timer/my_app.dart';
import 'package:pomodoro_timer/src/providers/app_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  runApp(MultiProvider(
    providers: AppProvider.providers,
    child: const MyApp(),
  ));
}
