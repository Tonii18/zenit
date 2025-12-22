import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/widgets/button.dart';
import 'package:zenit/widgets/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      
      appBar: AppBar(
        backgroundColor:  AppColors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: scale * 35, horizontal: scale * 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              
              SvgPicture.asset('assets/images/login-vector.svg', height: scale * 200, width: scale * 100),

              SizedBox(height: scale * 30),

              Text(
                'Inicia sesion en tu cuenta',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: scale * 30,
                  fontWeight: FontWeight.w900,
                  color: AppColors.mainGreen
                ),
              ),

              SizedBox(height: 30 * scale),

              CustomeFormField(
                width: width, 
                text: 'Correo electronico', 
                textColor: AppColors.lightGrey, 
                backgroundColor: Color.fromRGBO(243, 245, 247, 1), 
                iconColor: AppColors.darkerGrey, 
                focusedOutlinedBorder: AppColors.mainGreen, 
                isPassword: false, 
                icon: Icons.email
              ),

              SizedBox(height: 10 * scale),

              CustomeFormField(
                width: width, 
                text: 'Contraseña', 
                textColor: AppColors.lightGrey, 
                backgroundColor: Color.fromRGBO(243, 245, 247, 1), 
                iconColor: AppColors.darkerGrey, 
                focusedOutlinedBorder: AppColors.mainGreen, 
                isPassword: true, 
                icon: Icons.lock
              ),

              SizedBox(height: 30 * scale),

              CustomeButton(
                width: width, 
                height: 70 * scale, 
                backgroundColor: AppColors.mainGreen,
                borderColor: Colors.transparent,
                borderRadius: 10, 
                text: 'Iniciar sesión', 
                textColor: AppColors.white, 
                fontSize: 22 * scale, 
                fontWeight: FontWeight.w800,
                onPressed: (){},
              ),

              SizedBox(height: 10 * scale),

              CustomeButton(
                width: width, 
                height: 70 * scale, 
                backgroundColor: AppColors.white,
                borderColor: AppColors.mainGreen,
                borderRadius: 10, 
                text: 'Registrarme', 
                textColor: AppColors.mainGreen, 
                fontSize: 22 * scale, 
                fontWeight: FontWeight.w800,
                onPressed: (){},
              ),

            ],
          ),
        ),
      ),
    );
  }
}