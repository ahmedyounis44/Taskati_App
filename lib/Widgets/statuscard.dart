import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String text;
  final bool active;
  final void Function()? onTap;

  const StatusCard({
    super.key,
    this.active = false,
    required this.text,
     required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
      child: Container(
        width: 90,
        height: 40,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF5B6CFF) : Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                    fontSize: 12,
                    color: active ? Colors.white : Colors.white)),
           
          ],
        ),
      ),
    
    );
  }
}
