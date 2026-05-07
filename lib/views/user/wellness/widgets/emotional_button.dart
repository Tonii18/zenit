// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';

class EmotionalButton extends StatelessWidget {
  final Color color;
  final double scale;
  final String value;

  const EmotionalButton({super.key, required this.scale, required this.color, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: scale * 50,
      height: scale * 50,

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),

      child: TextButton(
        onPressed: () {},
        child: Text(
          value,
          style: TextStyle(
            fontSize: scale * 20,
            fontWeight: FontWeight.w900,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
