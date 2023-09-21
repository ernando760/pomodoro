import 'package:pomodoro_timer/src/controllers/pomodoro_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProvider {
  static final providers = <SingleChildWidget>[
    ChangeNotifierProvider(
      create: (context) => PomodoroController(),
    )
  ];
}
