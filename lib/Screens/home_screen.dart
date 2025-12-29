import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/Screens/add_task_screen.dart';
import 'package:flutter_tasks_app/Widgets/datecard.dart';
import 'package:flutter_tasks_app/Widgets/taskcard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddTaskScreen()),
                      );
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
                child: ListView(
                  children: [
                    TaskCard(
                      title: 'Flutter Task - 1',
                      des: "I Will do This Task",
                      time: '02:25 AM - 02:40 AM',
                      color: Color(0xFF5B6CFF),
                    ),
                    TaskCard(
                      title: 'Flutter Task - 2',
                      time: '04:27 PM - 04:42 PM',
                      des: "I Will do This Task",
                      color: Color(0xFFFF4D6D),
                    ),
                    TaskCard(
                      title: 'Flutter Task - 3',
                      time: '07:27 PM - 09:43 PM',
                      des: "I Will do This Task",
                      color: Color(0xFFFFA26B),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
