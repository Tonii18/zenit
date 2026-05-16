// ignore_for_file: unused_local_variable, use_function_type_syntax_for_parameters

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/services/activity_service.dart';
import 'package:zenit/services/emotional_service.dart';
import 'package:zenit/services/steps_service.dart';
import 'package:zenit/views/user/wellness/month_history.dart';
import 'package:zenit/views/user/wellness/widgets/emotional_button.dart';

class WellnessMain extends StatefulWidget {
  const WellnessMain({super.key});

  @override
  State<WellnessMain> createState() => _WellnessMainState();
}

class _WellnessMainState extends State<WellnessMain> {
  int _weekSteps = 0;
  double _weekCalories = 0;
  int _weekActivities = 0;
  int _weekEmotions = 0;
  bool _loadingSummary = true;

  @override
  void initState() {
    super.initState();
    _loadWeekSummary();
  }

  Future<void> _loadWeekSummary() async {
    final weekStats = await StepsService.getWeekStats();
    final activities = await ActivityService.getActivities();
    final emotions = await EmotionalService.getMonthRecords();

    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final sunday = monday.add(Duration(days: 6));

    // Count activities registered

    int activitiesCount = 0;
    if (activities != null) {
      for (var activity in activities) {
        final date = DateTime.parse(activity['date']);
        if (!date.isBefore(monday) && !date.isAfter(sunday)) {
          activitiesCount++;
        }
      }
    }

    // Count emotional state

    int emotionalCount = 0;
    if (emotions != null) {
      for (var emotion in emotions) {
        final date = DateTime.parse(emotion['date']);
        if (!date.isBefore(monday) && !date.isAfter(sunday)) {
          emotionalCount += (emotion['emotionalValue'] as int);
        }
      }
    }

    setState(() {
      _weekSteps = weekStats?['totalSteps'] ?? 0;
      _weekCalories = weekStats?['totalCalories'] ?? 0.0;
      _weekActivities = activitiesCount;
      _weekEmotions = emotionalCount;
      _loadingSummary = false;
    });
  }

  Widget _summaryCard({
    required double scale,
    required IconData icon,
    required String label,
    required String value,
    required double progress,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(scale * 15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: scale * 25),
          SizedBox(width: scale * 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: scale * 13,
                    color: AppColors.darkerGrey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: scale * 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    backgroundColor: AppColors.lightGrey,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: scale * 8,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: scale * 15),
          Text(
            value,
            style: TextStyle(
              fontSize: scale * 13,
              fontWeight: FontWeight.w900,
              color: AppColors.darkerGrey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);

    final Shader linearGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        AppColors.mainGreen,
        AppColors.mainPink,
        AppColors.mainOrange,
      ],
      stops: [0.3, 0.6, 0.9],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

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
                  'Consulta aqui tu nivel de bienestar',
                  style: TextStyle(
                    foreground: Paint()..shader = linearGradient,
                    fontSize: scale * 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              SizedBox(height: scale * 50),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '¿Cómo te encuentras hoy?',
                  style: TextStyle(
                    color: AppColors.darkerGrey,
                    fontSize: scale * 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              SizedBox(height: scale * 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  EmotionalButton(
                    scale: scale,
                    color: Color(0xFFFF8A80),
                    value: '1',
                  ),
                  EmotionalButton(
                    scale: scale,
                    color: Color(0xFFFFD180),
                    value: '2',
                  ),
                  EmotionalButton(
                    scale: scale,
                    color: Color(0xFFFFF9C4),
                    value: '3',
                  ),
                  EmotionalButton(
                    scale: scale,
                    color: Color(0xFFC8E6C9),
                    value: '4',
                  ),
                  EmotionalButton(
                    scale: scale,
                    color: Color(0xFF81C784),
                    value: '5',
                  ),
                ],
              ),

              SizedBox(height: scale * 20),

              SizedBox(
                height: scale * 60,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MonthHistory()),
                    );
                  },

                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.mainGreen,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Ver mi mes',
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

              SizedBox(height: scale * 50),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tu resumen de esta semana',
                  style: TextStyle(
                    color: AppColors.darkerGrey,
                    fontSize: scale * 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              SizedBox(height: scale * 20),

              /**
               * Weekly summaries Content
               */
              _loadingSummary
                  ? CircularProgressIndicator(color: AppColors.mainGreen)
                  : Column(
                      children: [
                        _summaryCard(
                          scale: scale,
                          icon: Icons.directions_walk,
                          label: 'Pasos esta semana',
                          value: _weekSteps.toString(),
                          progress:
                              _weekSteps /
                              70000,
                          color: AppColors.mainGreen,
                        ),

                        SizedBox(height: scale * 10),

                        _summaryCard(
                          scale: scale,
                          icon: Icons.local_fire_department,
                          label: 'Calorías esta semana',
                          value: '${_weekCalories.toStringAsFixed(0)} kcal',
                          progress:
                              _weekCalories /
                              3500,
                          color: AppColors.mainOrange,
                        ),

                        SizedBox(height: scale * 10),

                        _summaryCard(
                          scale: scale,
                          icon: Icons.sports,
                          label: 'Actividades registradas',
                          value: _weekActivities.toString(),
                          progress:
                              _weekActivities /
                              7,
                          color: AppColors.mainPink,
                        ),

                        SizedBox(height: scale * 10),

                        _summaryCard(
                          scale: scale,
                          icon: Icons.mood,
                          label: 'Bienestar emocional',
                          value: '$_weekEmotions / 35',
                          progress: _weekEmotions / 35,
                          color: Color(0xFF81C784),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
