// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/views/user/home/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          vertical: scale * 35,
          horizontal: scale * 35,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // ==========
              // HEADER CONTAINER
              // ==========
              Container(
                height: scale * 140,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [
                    Text(
                      'Bienvenido \nAntonio',
                      style: TextStyle(
                        foreground: Paint()..shader = linearGradient,
                        fontSize: scale * 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Settings()),
                        );
                      },
                      icon: Icon(
                        Icons.settings,
                        size: scale * 30,
                        color: AppColors.mainOrange,
                      ),
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size.zero,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: scale * 20),

              // ==========
              // PEDOMETER CONTAINER
              // ==========
              Container(
                height: scale * 350,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              SizedBox(height: scale * 20),

              // ==========
              // WEEK DAYS CONTAINER
              // ==========
              Container(
                height: scale * 60,
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
