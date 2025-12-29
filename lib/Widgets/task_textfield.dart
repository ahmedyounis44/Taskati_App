
import 'package:flutter/material.dart';

class TaskTextfield extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final bool readOnly;
  final Widget? suffixIcon;
  final Function()? onTap;
  final FormFieldValidator<String>?validate;


  const TaskTextfield({
    super.key,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
    this.validate
   
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      readOnly: readOnly,
       validator: validate,
      onTapOutside: (value) {
        FocusScope.of(context).unfocus();
      },
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        ),
      ),
    );
  }
}
