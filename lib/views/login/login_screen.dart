import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              
              SvgPicture.asset('assets/images/logoipsum-custom-logo (1).svg', height: 50, width: 50),

              SvgPicture.asset('assets/images/login-vector.svg'),

              SizedBox(height: 30),

              Text(
                'Inicia sesion en tu cuenta',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Color.fromRGBO(156, 199, 203, 1)
                ),
              ),

              SizedBox(height: 30),

              CustomeFormField(
                width: 300, 
                text: 'Correo electronico', 
                textColor: Color.fromRGBO(179, 179, 179, 1), 
                backgroundColor: Color.fromRGBO(243, 245, 247, 1), 
                iconColor: Color.fromRGBO(117, 117, 117, 1), 
                focusedOutlinedBorder: Color.fromRGBO(156, 199, 203, 1), 
                isPassword: false, 
                icon: Icons.email
              ),

              SizedBox(height: 15),

              CustomeFormField(
                width: 300, 
                text: 'Contraseña', 
                textColor: Color.fromRGBO(179, 179, 179, 1), 
                backgroundColor: Color.fromRGBO(243, 245, 247, 1), 
                iconColor: Color.fromRGBO(117, 117, 117, 1), 
                focusedOutlinedBorder: Color.fromRGBO(156, 199, 203, 1), 
                isPassword: true, 
                icon: Icons.lock
              ),

              SizedBox(height: 30),

              CustomeButton(
                width: 300, 
                height: 60, 
                backgroundColor: Color.fromRGBO(156, 199, 203, 1), 
                borderRadius: 10, 
                text: 'Iniciar sesión', 
                textColor: Colors.white, 
                fontSize: 20, 
                fontWeight: FontWeight.w800,
                onPressed: (){},
              )

            ],
          ),
        ),
      ),
    );
  }
}