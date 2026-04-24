// ignore_for_file: unused_local_variable, unused_field, unused_element, prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/core/secure_storage.dart';
import 'package:zenit/services/steps_service.dart';
import 'package:zenit/services/user_service.dart';
import 'package:zenit/views/user/home/widgets/home_header.dart';
import 'package:zenit/views/user/home/widgets/podometer_container.dart';
import 'package:zenit/views/user/home/widgets/screen_widgets.dart';
import 'package:zenit/views/user/home/widgets/weekdays_container.dart';

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
          vertical: scale * 35,
          horizontal: scale * 35,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Header Widget

              HomeHeader(name: _name),

              SizedBox(height: scale * 20),

              // Pedometer container Widget

              PodometerContainer(todaySteps: _todaySteps),

              SizedBox(height: scale * 20),

              // Weekdays container

              WeekdaysContainer(weekStats: _weekStats),

              SizedBox(height: scale * 20),

              // Weather Widget and Journal button

              ScreenWidgets(),
            ],
          ),
        ),
      ),
    );
  }
}