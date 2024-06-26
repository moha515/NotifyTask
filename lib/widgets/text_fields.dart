import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final Widget? suffixIcon;

  CustomFormTextField({
    required this.hintText,
    this.obscureText = false,
    required this.onChanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
                suffixIcon: suffixIcon,

        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }
}
