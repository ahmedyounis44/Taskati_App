import 'package:flutter/widgets.dart';

class TaskModel {
  String taskTitle;
  String date;
  String startTime;
  String endTime;
  String description;
  String statusText;
  Color color;

TaskModel({
    required this.taskTitle,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.statusText,
    required this.color,
  });
}
  List<TaskModel> tasks = [
    /*TaskModel(
      taskTitle: 'Client Presentation',
      date: '2024-06-17',
      startTime: '01:00 PM',
      endTime: '02:00 PM',
      description: 'Present project progress to the client.',
      statusText: 'Completed',
      color: Color(0xFFFFA726),
    ),*/
  ];
