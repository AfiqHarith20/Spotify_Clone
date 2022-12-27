import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'screens/bottom_nav_bar/bottom_nav_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  await Firebase.initializeApp();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('');
  await Hive.openBox('');
  await Hive.openBox('');
  await Hive.openBox('');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muzikly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Proxima',
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.black,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          circularTrackColor: Colors.greenAccent[700],
          color: Colors.greenAccent[400],
          linearMinHeight: 10,
        ),
        textTheme: const TextTheme(
          headline4: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Proxima Bold',
            fontWeight: FontWeight.w600,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: child!,
          ),
        );
      },
      home: const App(),
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
