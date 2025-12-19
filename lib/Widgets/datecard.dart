import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  final String day;
  final String month;
  final String week;
  final bool active;

  const DateCard({
    super.key,
    required this.day,
    required this.month,
    required this.week,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF5B6CFF) : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(month,
              style: TextStyle(
                  fontSize: 12,
                  color: active ? Colors.white : Colors.black)),
          Text(day,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: active ? Colors.white : Colors.black)),
          Text(week,
              style: TextStyle(
                  fontSize: 12,
                  color: active ? Colors.white : Colors.black)),
        ],
      ),
    );
  }
}
