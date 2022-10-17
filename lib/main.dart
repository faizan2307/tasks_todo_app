
import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:tasks_todo_app/Screens/landingPage.dart';
import 'package:tasks_todo_app/Screens/todoScreens/taskScreen.dart';

import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackGestureWidthTheme(
      
      backGestureWidth: BackGestureWidth.fraction(1 / 2),
      child: MaterialApp(
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
          }),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Task Todos',
        // home: welcomePage(),
        routes: {
          '/': (context) => welcomePage(),
          '/newMainScreenFb': (context) => NewMainScreenFirebase(),
        },
      ),
    );
  }
}
