import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/Screens/auth_screen.dart';
import 'package:flutter_tasks_app/Screens/home_screen.dart';
import 'package:flutter_tasks_app/app_strings.dart';
import 'package:flutter_tasks_app/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    nextscreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/splash_icon.json',
              width: 150,
              height: 150,
            ),

            Text(
              "Taskati",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
              "It's Time to get organize ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextscreen() {
    Future.delayed(Duration(seconds: 4), () {
      if(Hive.box<UserModel>(AppStrings.userBox).isNotEmpty)
      {
          Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  HomeScreen()),
        );
      }else{
          Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  AuthScreen()),
        );
      }
    
    });
  }
}
