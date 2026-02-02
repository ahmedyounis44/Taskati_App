import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/Screens/add_task_screen.dart';
import 'package:flutter_tasks_app/Screens/auth_screen.dart';
import 'package:flutter_tasks_app/Widgets/datecard.dart';
import 'package:flutter_tasks_app/Widgets/taskcard.dart';
import 'package:flutter_tasks_app/app_strings.dart';
import 'package:flutter_tasks_app/models/task_model.dart';
import 'package:flutter_tasks_app/models/user_model.dart';
import 'package:flutter_tasks_app/screens/user_screen.dart';
import 'package:flutter_tasks_app/widgets/statuscard.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? currentUser = Hive.box<UserModel>(AppStrings.userBox).getAt(0);
  int indexSelected = 0;
  int dateindexSelected = 0;
  DateTime today = DateTime.now();
  DateTime selecteddate = DateTime.now();
  String selectedstatusText = 'All';
  List<TaskModel> tasks = [];

  @override
  Widget build(BuildContext context) {
    tasks = Hive.box<TaskModel>(AppStrings.taskBox).values
        .where(
          (task) =>
              task.statusText ==
              (selectedstatusText == 'All'
                  ? task.statusText
                  : selectedstatusText),
        )
        .where(
          (task2) =>
              task2.date ==
              '${selecteddate.day.toString().padLeft(2, '0')}-${selecteddate.month.toString().padLeft(2, '0')}-${selecteddate.year}',
        )
        .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ${currentUser?.name ?? ""}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5B6CFF),
                        ),
                      ),
                      const Text('Have A Nice Day.'),
                    ],
                  ),
                  SizedBox(width: 120),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>  UserScreen(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: Image.file(
                        File(currentUser?.image ?? ""),
                      ).image,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Hive.box<UserModel>(AppStrings.userBox).clear();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => AuthScreen()),
                        (route) => false,
                      );
                    },
                    icon: Icon(Icons.logout, color: Colors.red),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'October 30, 2023',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Today'),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B6CFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddTaskScreen(),
                        ),
                      );
                      setState(() {});
                    },
                    child: Text(
                      '+ Add Task',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 40,
                child: Row(
                  children: List.generate(3, (index) {
                    String statusText;

                    switch (index) {
                      case 0:
                        statusText = 'All';
                        break;
                      case 1:
                        statusText = 'Todo';
                        break;
                      case 2:
                        statusText = 'Completed';
                        break;
                      default:
                        statusText = '';
                    }
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: StatusCard(
                        text: statusText,
                        active: indexSelected == index,
                        onTap: () {
                          setState(() {
                            indexSelected = index;
                            selectedstatusText = statusText;
                          });
                        },
                      ),
                    );
                  }),
                ),
              ),

              /// Dates
              const SizedBox(height: 20),
              /* SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    DateCard(
                      day: '30',
                      month: 'OCT',
                      week: 'MON',
                      active: true,
                      onTap: () {},
                    ),
                    DateCard(
                      day: '31',
                      month: 'OCT',
                      week: 'TUE',
                      onTap: () {},
                    ),
                    DateCard(day: '1', month: 'NOV', week: 'WED', onTap: () {}),
                    DateCard(day: '2', month: 'NOV', week: 'THU', onTap: () {}),
                  ],
                ),
              ),*/
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    DateTime date = today.add(Duration(days: index));
                    //print(selecteddate);
                    return DateCard(
                      day: date.day.toString(),
                      month: DateFormat('MMM').format(date).toUpperCase(),
                      week: DateFormat('EEE').format(date).toUpperCase(),
                      active: dateindexSelected == index, // today active
                      onTap: () {
                        setState(() {
                          selecteddate = date;
                          dateindexSelected = index;
                        });
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              /// Tasks
              Expanded(
                child: Visibility(
                  visible: tasks.isEmpty,
                  replacement: ListView.separated(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) => TaskCard(
                      title: tasks[index].taskTitle,
                      des: tasks[index].description,
                      statusText: tasks[index].statusText,
                      time:
                          ("${tasks[index].startTime} - ${tasks[index].endTime}"),
                      color: Color(tasks[index].color),
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                  ),
                  child: Lottie.asset("assets/images/nodata.json"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updatelist(selectedstatusText, selecteddate) {
    tasks = Hive.box<TaskModel>(AppStrings.taskBox).values
        .where(
          (task) =>
              task.statusText ==
              (selectedstatusText == 'All'
                  ? task.statusText
                  : selectedstatusText),
        )
        .where(
          (task2) =>
              task2.date ==
              '${selecteddate.day.toString().padLeft(2, '0')}-${selecteddate.month.toString().padLeft(2, '0')}-${selecteddate.year}',
        )
        .toList();
  }
}
