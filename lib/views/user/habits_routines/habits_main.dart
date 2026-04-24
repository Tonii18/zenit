import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';

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
              
            ],
          ),
        ),
      ),
    );
  }
}