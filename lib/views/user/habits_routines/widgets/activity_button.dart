import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';

class ActivityButton extends StatelessWidget {
  final double scale;
  final Icon icon;
  final String name;

  const ActivityButton({super.key, required this.scale, required this.icon, required this.name});

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

      child: IconButton(
        onPressed: () {},
        icon: icon,
        color: AppColors.mainGreen,
        iconSize: scale * 40,
      ),
    );
  }
}
