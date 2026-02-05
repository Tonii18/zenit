// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavbar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {

    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);

    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_work_rounded), label: 'Principal'),
        BottomNavigationBarItem(icon: Icon(Icons.track_changes_rounded), label: 'Hábitos'),
        BottomNavigationBarItem(icon: Icon(Icons.fastfood_outlined), label: 'Alimentación'),
        BottomNavigationBarItem(icon: Icon(Icons.heart_broken_rounded), label: 'Bienestar'),
      ],
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.mainGreen,
      unselectedItemColor: AppColors.lightGrey,
      iconSize: scale * 35,

      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
