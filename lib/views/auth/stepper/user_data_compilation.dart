// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/widgets/text_form_field.dart';

class UserDataCompilation extends StatefulWidget {
  const UserDataCompilation({super.key});

  @override
  State<UserDataCompilation> createState() => _UserDataCompilationState();
}

class _UserDataCompilationState extends State<UserDataCompilation> {
  @override
  Widget build(BuildContext context) {

    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);

    TextEditingController heighController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController stepsTargetController = TextEditingController();
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: scale * 30,
          vertical: scale * 30
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              SvgPicture.asset('assets/images/logoipsum-custom-logo (1).svg', height: scale * 70, width: scale * 70),

              SizedBox(height: scale * 50),

              Text(
                'Completa con tus \ndetalles personales',
                style: TextStyle(
                  color: AppColors.mainGreen,
                  fontWeight: FontWeight.w900,
                  fontSize: scale * 25,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: scale * 50),

              CustomeFormField(
                width: width, 
                text: 'Altura (en Cm)', 
                textColor: AppColors.lightGrey, 
                backgroundColor: AppColors.formFieldBck, 
                iconColor: AppColors.darkerGrey, 
                focusedOutlinedBorder: AppColors.mainGreen, 
                isPassword: false, 
                icon: Icons.height,
                textEditingController: heighController, 
                validator: (value) {
                  
                },
              ),

              SizedBox(height: scale * 10),

              CustomeFormField(
                width: width, 
                text: 'Peso (en Kg)', 
                textColor: AppColors.lightGrey, 
                backgroundColor: AppColors.formFieldBck, 
                iconColor: AppColors.darkerGrey, 
                focusedOutlinedBorder: AppColors.mainGreen, 
                isPassword: false, 
                icon: Icons.line_weight, 
                textEditingController: weightController,
                validator: (value) {
                  
                },
              ),

              SizedBox(height: scale * 10),

              CustomeFormField(
                width: width, 
                text: 'Edad', 
                textColor: AppColors.lightGrey, 
                backgroundColor: AppColors.formFieldBck, 
                iconColor: AppColors.darkerGrey, 
                focusedOutlinedBorder: AppColors.mainGreen, 
                isPassword: false, 
                icon: Icons.person,
                textEditingController: ageController, 
                validator: (value) {
                  
                },
              ),

              SizedBox(height: scale * 10),

              CustomeFormField(
                width: width, 
                text: 'Género', 
                textColor: AppColors.lightGrey, 
                backgroundColor: AppColors.formFieldBck, 
                iconColor: AppColors.darkerGrey, 
                focusedOutlinedBorder: AppColors.mainGreen, 
                isPassword: false, 
                icon: Icons.female,
                textEditingController: genderController,
                validator: (value) {
                  
                },
              ),

              SizedBox(height: scale * 10),

              CustomeFormField(
                width: width, 
                text: 'Objetivo de pasos diario', 
                textColor: AppColors.lightGrey, 
                backgroundColor: AppColors.formFieldBck, 
                iconColor: AppColors.darkerGrey, 
                focusedOutlinedBorder: AppColors.mainGreen, 
                isPassword: false, 
                icon: Icons.run_circle,
                textEditingController: stepsTargetController,
                validator: (value) {
                  
                },
              ),

              SizedBox(height: scale * 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  SizedBox(
                    width: scale * 150,
                    height: scale * 50,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(AppColors.mainGreen)
                      ),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          fontSize: scale * 16,
                          fontWeight: FontWeight.w900
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: scale * 150,
                    height: scale * 50,
                    child: TextButton(
                      onPressed: (){},
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(AppColors.mainGreen),
                        foregroundColor: WidgetStatePropertyAll(AppColors.white),
                        shape: MaterialStateProperty.all(
                          ContinuousRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(30)
                          )
                        ),
                      ),
                      child: Text(
                        'Aceptar',
                        style: TextStyle(
                          fontSize: scale * 16,
                          fontWeight: FontWeight.w900
                        ),
                      )
                    ),
                  ),
                ],
              )
            ],
          )
        ),
      ),
    );
  }

  void submit() async {
    
  }
}