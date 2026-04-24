// ignore_for_file: unused_local_variable, unused_field, unused_element, prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/core/secure_storage.dart';
import 'package:zenit/services/steps_service.dart';
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

  Map<String, dynamic>? _todaySteps;
  late StreamSubscription<StepCount> _stepCount;
  Map<String, dynamic>? _weekStats;
  int _steps = 0;
  int _initialSteps = 0;
  bool _initialStepsSet = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadTodaySteps();
    _initPodometer();
    _loadWeekStats();
  }

  Future<void> _loadWeekStats() async {
    final stats = await StepsService.getWeekStats();
    setState(() {
      _weekStats = stats;
    });
  }

  Future<void> _initPodometer() async {
    final status = await Permission.activityRecognition.request();

    if (status.isGranted) {
      _stepCount = Pedometer.stepCountStream.listen(
        _onStepCount,
        onError: _onStepCountError,
      );
    }
  }

  void _onStepCount(StepCount event) async {
    if (!_initialStepsSet) {
    
    final savedOffset = await SecureStorage.getStepOffset();
    final savedDate = await SecureStorage.getStepOffsetDate();
    final today = DateTime.now().toIso8601String().split('T')[0];

    if (savedDate != today) {
      
      await SecureStorage.saveStepOffset(event.steps, today);
      _initialSteps = event.steps;
    } else if (savedOffset != null) {
      
      _initialSteps = savedOffset;
    } else {
      
      await SecureStorage.saveStepOffset(event.steps, today);
      _initialSteps = event.steps;
    }

    _initialStepsSet = true;
  }

    int stepsToday = event.steps - _initialSteps;

    setState(() {
      _steps = stepsToday;
      if (_todaySteps != null) {
        _todaySteps!['steps'] = _steps;
        _todaySteps!['distanceKm'] = _steps * 0.000762;
        _todaySteps!['caloriesBurned'] = _steps * 0.04;
      }
    });
    _syncStepsWithBackend();
  }

  void _onStepCountError(error) {
    print('Pedometer error: $error');
  }

  Future<void> _syncStepsWithBackend() async {
    await StepsService.saveSteps(
      steps: _steps,
      distanceKm: _steps * 0.000762,
      caloriesBurned: _steps * 0.04,
    );
  }

  @override
  void dispose() {
    _stepCount.cancel();
    super.dispose();
  }

  Future<void> _loadTodaySteps() async {
    final steps = await StepsService.getTodaySteps();
    setState(() {
      _todaySteps = steps;
    });
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    final name = await UserService.getUserName();
    setState(() {
      _name = name;
      _isLoading = false;
    });
  }

  List<Widget> _showWeekDays(double scale) {
    final List<String> days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
    final List<Widget> widgets = [];

    for (int i = 0; i < 7; i++) {
      bool goalAchieved = false;

      if (_weekStats != null) {
        final records = _weekStats!['dailyRecords'] as List<dynamic>;
        goalAchieved = records[i]['goalAchieved'] as bool;
      }

      widgets.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: scale * 30,
              height: scale * 30,
              decoration: BoxDecoration(
                color: goalAchieved
                    ? AppColors.mainGreen
                    : AppColors.backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  days[i],
                  style: TextStyle(
                    fontSize: scale * 12,
                    fontWeight: FontWeight.w700,
                    color: goalAchieved
                        ? AppColors.white
                        : AppColors.darkerGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return widgets;
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
          vertical: scale * 35,
          horizontal: scale * 35,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Header container
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

              // Pedometer container
              Container(
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
                      initialValue: _todaySteps != null
                          ? (_todaySteps!['steps'] as int).toDouble().clamp(
                                0,
                                (_todaySteps!['dailyStepsGoal'] as double),
                              )
                          : 0,
                      min: 0,
                      max: _todaySteps != null
                          ? (_todaySteps!['dailyStepsGoal'] as double)
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
                              _todaySteps != null
                                  ? '${(_todaySteps!['caloriesBurned'] as double).toStringAsFixed(0)}'
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
                              _todaySteps != null
                                  ? '${(_todaySteps!['distanceKm'] as double).toStringAsFixed(1)} Km'
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
              ),

              SizedBox(height: scale * 20),

              // Weekdays container
              Container(
                height: scale * 60,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _showWeekDays(scale),
                ),
              ),

              SizedBox(height: scale * 20),

              // Weather and Journal buttons
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

  LinearGradient getGradient() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 9) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.mainPink, AppColors.mainOrange],
      );
    } else if (hour >= 9 && hour < 18) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color.fromRGBO(0, 180, 216, 1), AppColors.mainGreen],
      );
    } else if (hour >= 18 && hour < 21) {
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
    } else {
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