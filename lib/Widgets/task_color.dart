import 'package:flutter/material.dart';

class TaskColor extends StatelessWidget {
   final Color color;
   final bool selectedColor;
   final Function()?onTap;
  const TaskColor({super.key,required this.color, required this.selectedColor,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 36,
        height: 36,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: selectedColor
            ? const Icon(Icons.check, color: Colors.white)
            : null,
      ),
    );
  }
}
