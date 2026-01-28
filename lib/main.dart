import 'package:flutter/material.dart';
import 'package:zenit/views/auth/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zenit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'MontserratAlternates',
        scaffoldBackgroundColor: Colors.white
      ),
      home: LoginScreen(),
    );
  }
}
