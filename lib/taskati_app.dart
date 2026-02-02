import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/screens/splash_screen.dart';

class TaskatiApp extends StatelessWidget {
  const TaskatiApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      /* initialRoute: '/',
       routes: {
        //'/': (context) => Homescreen(),
        '/Result': (context) => ResultScreen(),
       },*/
     home: SplashScreen()  //ResultScreen()
      );
     
  }
}
