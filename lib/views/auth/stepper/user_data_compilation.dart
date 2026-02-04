// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable, deprecated_member_use, use_build_context_synchronously, unnecessary_nullable_for_final_variable_declarations

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/core/secure_storage.dart';
import 'package:zenit/models/user_profile.dart';
import 'package:zenit/services/auth.dart';
import 'package:zenit/views/auth/login_screen.dart';
import 'package:zenit/widgets/text_form_field.dart';

class UserDataCompilation extends StatefulWidget {
  const UserDataCompilation({super.key});

  @override
  State<UserDataCompilation> createState() => _UserDataCompilationState();
}

class _UserDataCompilationState extends State<UserDataCompilation> {
  TextEditingController heighController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController stepsTargetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: scale * 30,
          vertical: scale * 30,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SvgPicture.asset(
                'assets/images/logoipsum-custom-logo (1).svg',
                height: scale * 70,
                width: scale * 70,
              ),

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
                  if (value == null || value.trim().isEmpty) {
                    return 'La altura es un campo obligatorio';
                  } else if (num.tryParse(value) == null) {
                    return 'El campo debe ser de tipo numérico';
                  } else if (value != value.toInt()) {
                    return 'El campo no puede contener decimales';
                  }
                  return null;
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
                  if (value == null || value.trim().isEmpty) {
                    return 'El peso es un campo obligatorio';
                  } else if (num.tryParse(value) == null) {
                    return 'El campo debe ser de tipo numérico';
                  } else if (value != value.toInt()) {
                    return 'El campo no puede contener decimales';
                  }
                  return null;
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
                  if (value == null || value.trim().isEmpty) {
                    return 'La edad es un campo obligatorio';
                  } else if (num.tryParse(value) == null) {
                    return 'El campo debe ser de tipo numérico';
                  } else if (value != value.toInt()) {
                    return 'El campo no puede contener decimales';
                  }
                  return null;
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
                  if (value == null || value.trim().isEmpty) {
                    return 'El género es un campo obligatorio';
                  } else if (num.tryParse(value) == null) {
                    return 'El campo no puede ser numérico';
                  } else if (value != value.toInt()) {
                    return 'El campo no puede contener decimales';
                  }
                  return null;
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
                  if (value == null || value.trim().isEmpty) {
                    return 'El objetivo de pasos es un campo obligatorio';
                  } else if (num.tryParse(value) == null) {
                    return 'El campo debe ser de tipo numérico';
                  } else if (value != value.toInt()) {
                    return 'El campo no puede contener decimales';
                  }
                  return null;
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(
                          AppColors.mainGreen,
                        ),
                      ),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          fontSize: scale * 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: scale * 150,
                    height: scale * 50,
                    child: TextButton(
                      onPressed: () async {
                        submit();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.mainGreen,
                        ),
                        foregroundColor: WidgetStatePropertyAll(
                          AppColors.white,
                        ),
                        shape: MaterialStateProperty.all(
                          ContinuousRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(30),
                          ),
                        ),
                      ),
                      child: Text(
                        'Aceptar',
                        style: TextStyle(
                          fontSize: scale * 16,
                          fontWeight: FontWeight.w900,
                        ),
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

  void submit() async {
    final email = await SecureStorage.getEmail();

    UserProfile profile = UserProfile(
      email: email!,
      heightCm: int.parse(heighController.text),
      weightKg: int.parse(weightController.text),
      age: int.parse(ageController.text),
      gender: genderController.text,
      dailyStepsGoal: double.parse(stepsTargetController.text),
    );

    final String? message = await Auth.dataCompilation(profile);

    if (message == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tus datos han sido guardados correctamente')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
