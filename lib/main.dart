import 'package:flutter/material.dart';
import 'title_page.dart';
import 'package:flutter/services.dart';
import 'package:brain_train_app/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  List<ThemeMode> themes = [ThemeMode.light, ThemeMode.dark];
  int actTheme = 0;
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainAce.pro',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 187, 187, 187),
          onPrimary: Color.fromARGB(255, 121, 121, 121),
          secondary: Color.fromARGB(255, 116, 116, 116),
          onSecondary: Colors.black,
          tertiary: Color.fromARGB(255, 189, 189, 189),
          surface: Color.fromARGB(255, 252, 252, 252),
          error: Color.fromARGB(255, 255, 156, 149),
          shadow: Color.fromARGB(255, 255, 255, 255),
        ),
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color.fromARGB(255, 117, 117, 117),
          onPrimary: Color.fromARGB(255, 224, 224, 224),
          secondary: Color.fromARGB(255, 255, 255, 255),
          onSecondary: Colors.white,
          tertiary: Colors.black,
          surface: Color.fromARGB(255, 19, 19, 19),
          error: Color.fromARGB(255, 234, 31, 17),
          shadow: Color.fromARGB(255, 0, 0, 0),
        ),
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      themeMode: _themeMode,
      home: const TitlePage(title: 'BrainAce.pro'),
    );
  }

  void switchTheme() {
    setState(
      () {
        actTheme = actTheme ^ 1;
        _themeMode = themes[actTheme];
      },
    );
  }
}
