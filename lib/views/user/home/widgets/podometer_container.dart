// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';

class PodometerContainer extends StatelessWidget {
  final Map<String, dynamic>? todaySteps;

  const PodometerContainer({super.key, required this.todaySteps});

  @override
  Widget build(BuildContext context) {
    final scale = Measures.scale(context);

    return Container(
      height: scale * 350,
      padding: EdgeInsets.all(scale * 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SleekCircularSlider(
            initialValue: todaySteps != null
                ? (todaySteps!['steps'] as int).toDouble().clamp(
                      0,
                      (todaySteps!['dailyStepsGoal'] as double),
                    )
                : 0,
            min: 0,
            max: todaySteps != null
                ? (todaySteps!['dailyStepsGoal'] as double)
                : 10000,
            appearance: CircularSliderAppearance(
              customColors: CustomSliderColors(
                progressBarColor: AppColors.mainGreen,
                trackColor: AppColors.lightGrey,
                shadowMaxOpacity: 0.0,
              ),
              customWidths: CustomSliderWidths(
                progressBarWidth: 10,
                trackWidth: 10,
                shadowWidth: 0,
              ),
              size: scale * 220,
              startAngle: 130,
              angleRange: 280,
              infoProperties: InfoProperties(
                mainLabelStyle: TextStyle(
                  fontSize: scale * 35,
                  fontWeight: FontWeight.w900,
                  color: AppColors.mainGreen,
                ),
                bottomLabelText: 'Pasos',
                bottomLabelStyle: TextStyle(
                  fontSize: scale * 14,
                  color: AppColors.darkerGrey,
                ),
                modifier: (double value) {
                  return value.toInt().toString();
                },
              ),
              spinnerMode: false,
              animationEnabled: true,
            ),
            onChange: null,
          ),

          SizedBox(height: scale * 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: AppColors.mainOrange,
                    size: scale * 18,
                  ),
                  SizedBox(width: scale * 5),
                  Text(
                    todaySteps != null
                        ? '${(todaySteps!['caloriesBurned'] as double).toStringAsFixed(0)}'
                        : '0',
                    style: TextStyle(
                      fontSize: scale * 14,
                      color: AppColors.darkerGrey,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    todaySteps != null
                        ? '${(todaySteps!['distanceKm'] as double).toStringAsFixed(1)} Km'
                        : '0 Km',
                    style: TextStyle(
                      fontSize: scale * 14,
                      color: AppColors.darkerGrey,
                    ),
                  ),
                  SizedBox(width: scale * 5),
                  Icon(
                    Icons.arrow_circle_right_sharp,
                    color: AppColors.mainGreen,
                    size: scale * 18,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}