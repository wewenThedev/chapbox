import 'package:chapbox/configs/styles.dart';
import 'package:flutter/material.dart';
import 'package:chapbox/configs/themes.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  CustomButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
      style: customStyle(context)
    );
  }
}
