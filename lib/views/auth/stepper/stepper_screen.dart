// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/views/auth/stepper/user_data_compilation.dart';
import 'package:zenit/widgets/button.dart';

class StepperScreen extends StatelessWidget {
  const StepperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scales

    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Text(
                '¡Enhorabuena! Ya verificaste tu email',
                style: TextStyle(
                  color: AppColors.mainGreen,
                  fontSize: scale * 25,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: scale * 50),

              SvgPicture.asset(
                'assets/images/stepper-illustration.svg',
                height: scale * 200,
                width: scale * 100,
              ),

              SizedBox(height: scale * 50),

              Text(
                'Para personalizar tu experiencia, vamos a recoger \nalgunos datos personales',
                style: TextStyle(
                  color: AppColors.mainGreen,
                  fontSize: scale * 20,
                ),
                textAlign: TextAlign.start,
              ),

              SizedBox(height: scale * 200),

              CustomeButton(
                width: width,
                height: scale * 60,
                backgroundColor: AppColors.mainGreen,
                borderRadius: 40,
                text: '¡Vamos allá!',
                textColor: AppColors.white,
                fontSize: scale * 20,
                fontWeight: FontWeight.w900,
                borderColor: Colors.transparent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDataCompilation(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
