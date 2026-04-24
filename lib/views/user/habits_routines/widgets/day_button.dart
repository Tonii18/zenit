import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';

class DayButton extends StatelessWidget {
  final double scale;
  final String name;

  const DayButton({super.key, required this.scale,required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: scale * 100,
      height: scale * 100,

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.mainGreen),
      ),

      child: TextButton(
        onPressed: (){},
        child: Text(
          name,
          style: TextStyle(
            fontSize: scale * 20,
            fontWeight: FontWeight.w900,
            color: AppColors.mainGreen
          ),
        ),
      ),
    );
  }
}
