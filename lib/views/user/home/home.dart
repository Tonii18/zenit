// ignore_for_file: unused_local_variable, unused_field

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/models/user_profile.dart';
import 'package:zenit/services/user_service.dart';
import 'package:zenit/views/user/home/journal.dart';
import 'package:zenit/views/user/home/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _name;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);

    final name = await UserService.getUserName();

    setState(() {
      _name = name;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);

    // Gradient for welcoming message

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

    // Gradients for day reminder

    final weatherGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        AppColors.mainGreen,
        AppColors.mainPink,
        AppColors.mainOrange,
      ],
    );

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
              /**
               * Header container
               */
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
                      'Bienvenido \n${_name ?? "Invitado"}',
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

              /**
               * Pedometer container
               */
              Container(
                height: scale * 350,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              SizedBox(height: scale * 20),

              /**
               * Weekdays container
               */
              Container(
                height: scale * 60,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              SizedBox(height: scale * 20),

              /**
               * Weather and Journal buttons
               */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: scale * 90,
                      decoration: BoxDecoration(
                        gradient: getGradient(),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          Positioned(top: 12, left: 12, child: getIcon()),
                          Positioned(
                            bottom: 12,
                            right: 12,
                            child: Text(
                              getGreeting(),
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: scale * 20),

                  Expanded(
                    child: Container(
                      height: scale * 90,
                      decoration: BoxDecoration(
                        color: AppColors.mainGreen,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Journal()),
                          );
                        },
                        icon: Icon(Icons.book, color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to get a gradient for each moment of the day

  LinearGradient getGradient() {
    final hour = DateTime.now().hour;

    // Sunrise
    if (hour >= 5 && hour < 9) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(255, 209, 102, 1),
          Color.fromRGBO(255, 153, 102, 1),
          Color.fromRGBO(255, 94, 98, 1),
          Color.fromRGBO(112, 76, 141, 1),
        ],
      );
    }
    // Noon
    else if (hour >= 9 && hour < 18) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromRGBO(0, 119, 182, 1),
          Color.fromRGBO(0, 180, 216, 1),
          Color.fromRGBO(144, 224, 239, 1),
          Color.fromRGBO(255, 249, 196, 1),
        ],
      );
    }
    // Sunset
    else if (hour >= 18 && hour < 21) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(43, 27, 61, 1),
          Color.fromRGBO(111, 50, 121, 1),
          Color.fromRGBO(216, 58, 86, 1),
          Color.fromRGBO(255, 123, 84, 1),
          Color.fromRGBO(255, 178, 107, 1),
        ],
      );
    }
    // Night
    else {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(11, 14, 20, 1),
          Color.fromRGBO(22, 27, 34, 1),
          Color.fromRGBO(36, 52, 71, 1),
          Color.fromRGBO(61, 78, 123, 1),
          Color.fromRGBO(142, 148, 178, 1),
        ],
      );
    }
  }

  // Function to get the emoji which represents the moment of the day

  Icon getIcon() {
    final hour = DateTime.now().hour;

    if (hour < 18) {
      return Icon(Icons.sunny, color: Colors.white);
    } else if (hour < 21) {
      return Icon(Icons.sunny_snowing, color: Colors.white);
    } else {
      return Icon(Icons.nightlight_round, color: Colors.white);
    }
  }

  // Function to get the matching greeting according to the time of the day

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Buenos días';
    } else if (hour < 20) {
      return 'Buenas tardes';
    } else {
      return 'Buenas noches';
    }
  }
}
