// ignore_for_file: unused_local_variable, unused_field

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/services/show_habits_service.dart';
import 'package:zenit/views/user/habits_routines/show_habits.dart';
import 'package:zenit/views/user/habits_routines/weekdays_screen.dart';
import 'package:zenit/views/user/habits_routines/widgets/activity_button.dart';

class HabitsMain extends StatefulWidget {
  const HabitsMain({super.key});

  @override
  State<HabitsMain> createState() => _HabitsMainState();
}

class _HabitsMainState extends State<HabitsMain> {
  List<dynamic> _habits = [];
  double _habitsCompleted = 0;

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    final habits = await ShowHabitsService.getHabits();

    if (habits != null && habits.isNotEmpty) {
      int completed = 0;

      for (var habit in habits) {
        if (habit['completed'] == true) {
          completed++;
        }
      }

      setState(() {
        _habits = habits;
        _habitsCompleted = (completed / habits.length) * 100;
      });
    } else {
      setState(() {
        _habits = [];
        _habitsCompleted = 0;
      });
    }
  }

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

              /**
               * Weekly Workout Planification
               */
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

              /**
               * Record Activity Section
               */
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

              /**
               * Daily Habits Section
               */
              Container(
                height: scale * 80,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [
                    Text(
                      'Hábitos cumplidos',
                      style: TextStyle(
                        fontSize: scale * 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.mainGreen,
                      ),
                    ),

                    SleekCircularSlider(
                      initialValue: _habitsCompleted,
                      min: 0,
                      max: 100,
                      appearance: CircularSliderAppearance(
                        customColors: CustomSliderColors(
                          progressBarColor: AppColors.mainGreen,
                          trackColor: AppColors.formFieldBck,
                          shadowMaxOpacity: 0.0,
                        ),
                        customWidths: CustomSliderWidths(
                          progressBarWidth: 6,
                          trackWidth: 6,
                          shadowWidth: 0,
                        ),
                        size: scale * 60,
                        startAngle: 270,
                        angleRange: 360,
                        infoProperties: InfoProperties(
                          mainLabelStyle: TextStyle(
                            fontSize: scale * 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.lightGrey,
                          ),
                          modifier: (double value) {
                            return '${value.toInt()}%';
                          },
                        ),
                        spinnerMode: false,
                        animationEnabled: true
                      ),
                      onChange: null,
                    ),
                  ],
                ),
              ),

              SizedBox(height: scale * 20),

              Container(
                height: scale * 80,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.mainGreen),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShowHabits()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Ver mis hábitos',
                        style: TextStyle(
                          color: AppColors.mainGreen,
                          fontWeight: FontWeight.w900,
                          fontSize: scale * 20,
                        ),
                      ),

                      Icon(
                        Icons.list,
                        color: AppColors.mainGreen,
                        size: scale * 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
