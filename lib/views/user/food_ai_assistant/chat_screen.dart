// ignore_for_file: sort_child_properties_last, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int protein = 1;
  int carbs = 1;
  int fiber = 1;

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

    List<Color> gradientColors = [
      AppColors.mainGreen,
      AppColors.mainPink,
      AppColors.mainOrange,
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: scale * 35,
          horizontal: scale * 35,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                '¿Qué te apetece comer hoy?',
                style: TextStyle(
                  foreground: Paint()..shader = linearGradient,
                  fontSize: scale * 25,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: scale * 30),

              Container(
                height: scale * 250,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              SizedBox(height: scale * 20),

              Container(
                height: scale * 250,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: BoxBorder.all(color: AppColors.lightGrey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: scale * 150,
                          child: Slider(
                            value: protein.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                protein = value.toInt();
                              });
                            },
                            min: 1,
                            max: 100,
                            activeColor: AppColors.mainPink,
                          ),
                        ),
                        Text(
                          protein.toString() + ' g de proteina',
                          style: TextStyle(fontSize: scale * 13),
                        ),
                        SizedBox(
                          width: scale * 150,
                          child: Slider(
                            value: carbs.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                carbs = value.toInt();
                              });
                            },
                            min: 1,
                            max: 100,
                            activeColor: AppColors.mainOrange,
                          ),
                        ),
                        Text(
                          carbs.toString() + ' g de hidratos',
                          style: TextStyle(fontSize: scale * 13),
                        ),
                        SizedBox(
                          width: scale * 150,
                          child: Slider(
                            value: fiber.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                fiber = value.toInt();
                              });
                            },
                            min: 1,
                            max: 100,
                            activeColor: AppColors.mainGreen,
                          ),
                        ),
                        Text(
                          fiber.toString() + ' g de fibra',
                          style: TextStyle(fontSize: scale * 13),
                        ),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: scale * 13, horizontal: scale * 13),
                          child: SleekCircularSlider(
                            initialValue: 1,
                            max: 1000,
                            appearance: CircularSliderAppearance(
                              customColors: CustomSliderColors(
                                progressBarColor: AppColors.mainPink,
                                trackColor: AppColors.lightGrey,
                                shadowMaxOpacity: 0.2,
                              ),
                              customWidths: CustomSliderWidths(
                                progressBarWidth: 12,
                                trackWidth: 12,
                                shadowWidth: 20,
                              ),
                              size: scale * 150,
                              startAngle: 150,
                              angleRange: 240,
                              infoProperties: InfoProperties(
                                mainLabelStyle: TextStyle(
                                  fontSize: scale * 13,
                                  color: AppColors.darkerGrey,
                                ),
                                modifier: (double value) {
                                  return '${value.toStringAsFixed(0)} Kcal';
                                },
                              ),
                              spinnerMode: false,
                              animationEnabled: true,
                            ),
                            onChange: (double value) {
                              
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: scale * 20),

              SizedBox(
                width: width,
                height: scale * 45,
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(colors: gradientColors),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.auto_awesome, color: AppColors.white),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(20),
                      ),
                      shadowColor: Colors.transparent,
                      elevation: 0,
                    ),
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
