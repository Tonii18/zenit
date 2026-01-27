// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/models/user_register.dart';
import 'package:zenit/services/auth.dart';
import 'package:zenit/views/verify/verification_screen.dart';
import 'package:zenit/widgets/button.dart';
import 'package:zenit/widgets/text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: AppColors.mainGreen,
        ),
        title: Text(
          'Iniciar sesion',
          style: TextStyle(
            color: AppColors.mainGreen,
            fontSize: scale * 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.white,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: 35 * scale,
              horizontal: 35 * scale,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                SvgPicture.asset(
                  'assets/images/register-vector.svg',
                  height: scale * 200,
                  width: scale * 100,
                ),

                SizedBox(height: scale * 30),

                Text(
                  'Crea tu cuenta de Zenit',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: scale * 30,
                    fontWeight: FontWeight.w900,
                    color: AppColors.mainGreen,
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
                  icon: Icons.email,
                  textEditingController: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email es obligatorio';
                    }
                    return null;
                  },
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
                  icon: Icons.account_circle,
                  textEditingController: usernameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nombre de usuario es obligatorio';
                    }
                    return null;
                  },
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
                  icon: Icons.phone,
                  textEditingController: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Teléfono es obligatorio';
                    }
                    if (value != null && value.isNotEmpty) {
                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return 'Teléfono debe contener solo números';
                      }
                    }
                    return null;
                  },
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
                  icon: Icons.lock,
                  textEditingController: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Contraseña es obligatoria';
                    }
                    if (value.length < 8) {
                      return 'Longitud mínima de 8 caracteres';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 30 * scale),

                CustomeButton(
                  width: width,
                  height: 60 * scale,
                  backgroundColor: AppColors.mainGreen,
                  borderColor: Colors.transparent,
                  borderRadius: 40,
                  text: 'Registrarme',
                  textColor: AppColors.white,
                  fontSize: 20 * scale,
                  fontWeight: FontWeight.w800,
                  onPressed: () {
                    submit();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      String username = usernameController.text;
      String phone = phoneController.text;
      String password = passwordController.text;

      UserRegister newUser = UserRegister(
        email: email,
        username: username,
        phone: phone,
        password: password,
      );

      final message = await Auth.register(newUser);

      if (message == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Registered sucessfully')));

        // Navigate to Verification screen

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerificationScreen(email: email,)),
        );

      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } else {
      // ignore: avoid_print
      print('Invalid form');
    }
  }
}
