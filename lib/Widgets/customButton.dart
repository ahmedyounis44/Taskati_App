import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String name;
  final void Function()? onPressed;
  const Custombutton({super.key, required this.name, this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        minimumSize: Size(double.infinity, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(name, style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
