import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/Screens/add_task_screen.dart';
import 'package:flutter_tasks_app/Widgets/datecard.dart';
import 'package:flutter_tasks_app/Widgets/taskcard.dart';
import 'package:flutter_tasks_app/models/task_model.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, Sayed',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5B6CFF),
                        ),
                      ),
                      Text('Have A Nice Day.'),
                    ],
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      'https://scontent.fmct5-1.fna.fbcdn.net/v/t1.6435-9/82853971_1994220057390256_3920460651893358592_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=w7AEHDRKv3gQ7kNvwFsDdof&_nc_oc=AdkkYI1o-15q1_8lgIUdW6rHtZcV-tdHsIE0wZGYrDQ61P2FtrhZzPe7i-oAQ6BOqsWOiDKA698C-qT8UAG9jUlw&_nc_zt=23&_nc_ht=scontent.fmct5-1.fna&_nc_gid=F8lneMPwPSrme1Dkl1CTvA&oh=00_AflfWvHxHDTa8kLfzFfzhmM-SZ_QmG9yGtgE_29xPXML1g&oe=696D1BE8',
                    ),
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
                        MaterialPageRoute(builder: (context) => AddTaskScreen()),
                      );
                      setState(() {
                        
                      });
                    },
                    child: Text(
                      '+ Add Task',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Dates
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    DateCard(
                      day: '30',
                      month: 'OCT',
                      week: 'MON',
                      active: true,
                    ),
                    DateCard(day: '31', month: 'OCT', week: 'TUE'),
                    DateCard(day: '1', month: 'NOV', week: 'WED'),
                    DateCard(day: '2', month: 'NOV', week: 'THU'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Tasks
              Expanded(
                child:Visibility(visible: tasks.isEmpty,  replacement:  ListView.separated(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => TaskCard(
                    title: tasks[index].taskTitle,
                    des: tasks[index].description,
                    time: ("${tasks[index].startTime} - ${tasks[index].endTime}"),
                    color: tasks[index].color,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                
                ),child: Lottie.asset("assets/images/nodata.json"))
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
