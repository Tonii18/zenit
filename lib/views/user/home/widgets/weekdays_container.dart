import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';

class WeekdaysContainer extends StatelessWidget {
  final Map<String, dynamic>? weekStats;

  const WeekdaysContainer({super.key, required this.weekStats});

  @override
  Widget build(BuildContext context) {
    final scale = Measures.scale(context);

    return Container(
      height: scale * 60,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _buildWeekDays(scale),
      ),
    );
  }

  List<Widget> _buildWeekDays(double scale) {
    final List<String> days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
    final List<Widget> widgets = [];

    for (int i = 0; i < 7; i++) {
      bool goalAchieved = false;

      if (weekStats != null) {
        final records = weekStats!['dailyRecords'] as List<dynamic>;
        goalAchieved = records[i]['goalAchieved'] as bool;
      }

      widgets.add(
        Container(
          width: scale * 30,
          height: scale * 30,
          decoration: BoxDecoration(
            color: goalAchieved
                ? AppColors.mainGreen
                : AppColors.backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              days[i],
              style: TextStyle(
                fontSize: scale * 12,
                fontWeight: FontWeight.w700,
                color: goalAchieved
                    ? AppColors.white
                    : AppColors.darkerGrey,
              ),
            ),
          ),
        ),
      );
    }

    return widgets;
  }
}