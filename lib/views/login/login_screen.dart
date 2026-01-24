// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/core/secure_storage.dart';
import 'package:zenit/services/auth.dart';
import 'package:zenit/views/register/register_screen.dart';
import 'package:zenit/widgets/button.dart';
import 'package:zenit/widgets/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: scale * 35,
              horizontal: scale * 35,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                SvgPicture.asset(
                  'assets/images/login-vector.svg',
                  height: scale * 200,
                  width: scale * 100,
                ),

                SizedBox(height: scale * 30),

                Text(
                  'Inicia sesion en tu cuenta',
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
                  text: 'Iniciar sesión',
                  textColor: AppColors.white,
                  fontSize: 20 * scale,
                  fontWeight: FontWeight.w800,
                  onPressed: () {
                    submit();
                  },
                ),

                SizedBox(height: 10 * scale),

                CustomeButton(
                  width: width,
                  height: 60 * scale,
                  backgroundColor: AppColors.white,
                  borderColor: AppColors.mainGreen,
                  borderRadius: 40,
                  text: 'Registrarme',
                  textColor: AppColors.mainGreen,
                  fontSize: 20 * scale,
                  fontWeight: FontWeight.w800,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
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
      final email = emailController.text;
      final password = passwordController.text;

      final result = await Auth.login(email, password);

      if (result!.startsWith('eyJ')) {
        await SecureStorage.saveToken(result);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Has iniciado sesion con éxito')),
        );

        // Redirect to home
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result)));
      }
    }
  }
}
