import 'package:flutter/material.dart';

class TaskLable extends StatelessWidget {
 final String text;
  const TaskLable({super.key,required this.text});
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}