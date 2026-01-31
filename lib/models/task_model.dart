import 'package:hive_flutter/adapters.dart';

// This MUST be uncommented for the generator to work
part 'task_model.g.dart'; 

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String taskTitle;
  @HiveField(1)
  String date;
  @HiveField(2)
  String startTime;
  @HiveField(3)
  String endTime;
  @HiveField(4)
  String description;
  @HiveField(5)
  String statusText;
  @HiveField(6)
  int color;

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