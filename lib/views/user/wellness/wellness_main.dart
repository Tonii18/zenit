// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/views/user/wellness/month_history.dart';
import 'package:zenit/views/user/wellness/widgets/emotional_button.dart';

class WellnessMain extends StatefulWidget {
  const WellnessMain({super.key});

  @override
  State<WellnessMain> createState() => _WellnessMainState();
}

class _WellnessMainState extends State<WellnessMain> {
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

              SizedBox(height: scale * 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  EmotionalButton(scale: scale, color: Color(0xFFFF8A80), value: '1',),
                  EmotionalButton(scale: scale, color: Color(0xFFFFD180), value: '2',),
                  EmotionalButton(scale: scale, color: Color(0xFFFFF9C4), value: '3',),
                  EmotionalButton(scale: scale, color: Color(0xFFC8E6C9), value: '4',),
                  EmotionalButton(scale: scale, color: Color(0xFF81C784), value: '5',),
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
            ],
          ),
        ),
      ),
    );
  }
}
