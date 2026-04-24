import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/views/user/habits_routines/weekdays_screen.dart';
import 'package:zenit/views/user/habits_routines/widgets/activity_button.dart';
import 'package:zenit/views/user/home/settings.dart';
import 'package:zenit/widgets/button.dart';

class HabitsMain extends StatefulWidget {
  const HabitsMain({super.key});

  @override
  State<HabitsMain> createState() => _HabitsMainState();
}

class _HabitsMainState extends State<HabitsMain> {
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
              Center(
                child: Text(
                  'Mis hábitos y rutinas',
                  style: TextStyle(
                    color: AppColors.mainGreen,
                    fontSize: scale * 25,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: scale * 50),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Planificación semanal',
                  style: TextStyle(
                    color: AppColors.darkerGrey,
                    fontSize: scale * 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              SizedBox(height: scale * 10),

              SizedBox(
                height: scale * 60,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WeekdaysScreen()),
                    );
                  },

                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.mainGreen,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Ver mis rutinas',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      Icon(Icons.arrow_forward_ios, color: AppColors.white),
                    ],
                  ),
                ),
              ),

              SizedBox(height: scale * 30),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Registrar actividad',
                  style: TextStyle(
                    color: AppColors.darkerGrey,
                    fontSize: scale * 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              SizedBox(height: scale * 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  ActivityButton(
                    name: 'run',
                    scale: scale,
                    icon: Icon(Icons.directions_run),
                  ),
                  ActivityButton(
                    name: 'walk',
                    scale: scale,
                    icon: Icon(Icons.hiking),
                  ),
                  ActivityButton(
                    name: 'bike',
                    scale: scale,
                    icon: Icon(Icons.pedal_bike),
                  ),
                ],
              ),

              SizedBox(height: scale * 20),

              Container(
                height: scale * 80,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              SizedBox(height: scale * 30),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mis hábitos diarios',
                  style: TextStyle(
                    color: AppColors.darkerGrey,
                    fontSize: scale * 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              SizedBox(height: scale * 10),

              Container(
                height: scale * 80,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              SizedBox(height: scale * 20),

              Container(
                height: scale * 80,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
