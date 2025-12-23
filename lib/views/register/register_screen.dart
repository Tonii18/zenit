import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/widgets/button.dart';
import 'package:zenit/widgets/text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {

    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);
    
    return Scaffold(

      resizeToAvoidBottomInset: true,

      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 35 * scale, horizontal: 35 * scale),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    icon: Icon(Icons.arrow_back, size: scale * 45, color: AppColors.mainGreen,)
                  )
                ],
              ),

              SvgPicture.asset('assets/images/register-vector.svg', height: scale * 200, width: scale * 100),

              SizedBox(height: scale * 30),

              Text(
                'Crea tu cuenta de Zenit',
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
                text: 'Nombre de usuario', 
                textColor: AppColors.lightGrey, 
                backgroundColor: Color.fromRGBO(243, 245, 247, 1), 
                iconColor: AppColors.darkerGrey, 
                focusedOutlinedBorder: AppColors.mainGreen, 
                isPassword: false, 
                icon: Icons.account_circle
              ),

              SizedBox(height: 10 * scale),

              CustomeFormField(
                width: width, 
                text: 'Número de teléfono', 
                textColor: AppColors.lightGrey, 
                backgroundColor: Color.fromRGBO(243, 245, 247, 1), 
                iconColor: AppColors.darkerGrey, 
                focusedOutlinedBorder: AppColors.mainGreen, 
                isPassword: false, 
                icon: Icons.phone
              ),

              SizedBox(height: 10 * scale),

              CustomeFormField(
                width: width, 
                text: 'Contraseña', 
                textColor: AppColors.lightGrey, 
                backgroundColor: Color.fromRGBO(243, 245, 247, 1), 
                iconColor: AppColors.darkerGrey, 
                focusedOutlinedBorder: AppColors.mainGreen, 
                isPassword: false, 
                icon: Icons.lock
              ),

              SizedBox(height: 30 * scale),

              CustomeButton(
                width: width, 
                height: 70 * scale, 
                backgroundColor: AppColors.mainGreen,
                borderColor: Colors.transparent,
                borderRadius: 50, 
                text: 'Registrarme', 
                textColor: AppColors.white, 
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