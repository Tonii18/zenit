import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/views/user/habits_routines/widgets/day_button.dart';

class WeekdaysScreen extends StatefulWidget {
  const WeekdaysScreen({super.key});

  @override
  State<WeekdaysScreen> createState() => _WeekdaysScreenState();
}

class _WeekdaysScreenState extends State<WeekdaysScreen> {
  @override
  Widget build(BuildContext context) {
    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: scale * 35,
          vertical: scale * 35,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.mainGreen,
                      size: scale * 30,
                    ),
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                  ),
                  Text(
                    'Planificación semanal',
                    style: TextStyle(
                      fontSize: scale * 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.mainGreen,
                    ),
                  ),
                ],
              ),

              SizedBox(height: scale * 10),

              Divider(height: 1, color: AppColors.mainGreen),

              SizedBox(height: scale * 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  DayButton(scale: scale, name: 'L'),
                  DayButton(scale: scale, name: 'M'),
                  DayButton(scale: scale, name: 'X'),
                ],
              ),

              SizedBox(height: scale * 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  DayButton(scale: scale, name: 'J'),
                  DayButton(scale: scale, name: 'V'),
                  DayButton(scale: scale, name: 'S'),
                ],
              ),

              SizedBox(height: scale * 20),

              DayButton(scale: scale, name: 'D'),

              SizedBox(height: scale * 180),

              SvgPicture.asset(
                'assets/images/undraw_athletes-training_koqa 1.svg',
                height: scale * 200,
                width: scale * 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
