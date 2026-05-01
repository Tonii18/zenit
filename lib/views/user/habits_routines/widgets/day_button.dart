import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/views/user/habits_routines/show_routine.dart';

class DayButton extends StatelessWidget {
  final double scale;
  final String name;

  const DayButton({super.key, required this.scale, required this.name});

  @override
  Widget build(BuildContext context) {

    String weekDay = '';

    if (name == 'L') {
      weekDay = 'Lunes';
    } else if (name == 'M') {
      weekDay = 'Martes';
    } else if (name == 'X') {
      weekDay = 'Miércoles';
    } else if (name == 'J') {
      weekDay = 'Jueves';
    } else if (name == 'V') {
      weekDay = 'Viernes';
    } else if (name == 'S') {
      weekDay = 'Sábado';
    } else if (name == 'D') {
      weekDay = 'Domingo';
    }

    return Container(
      width: scale * 100,
      height: scale * 100,

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.mainGreen),
      ),

      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShowRoutine(weekDay: weekDay)),
          );
        },
        child: Text(
          name,
          style: TextStyle(
            fontSize: scale * 20,
            fontWeight: FontWeight.w900,
            color: AppColors.mainGreen,
          ),
        ),
      ),
    );
  }
}
