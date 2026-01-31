import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/app_strings.dart';
import 'package:flutter_tasks_app/models/task_model.dart';
import 'package:flutter_tasks_app/models/user_model.dart';
import 'package:flutter_tasks_app/taskati_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
   await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(TaskModelAdapter());
    await Hive.openBox<UserModel>(AppStrings.userBox);
     await Hive.openBox<TaskModel>(AppStrings.taskBox);
  runApp(TaskatiApp());
}
