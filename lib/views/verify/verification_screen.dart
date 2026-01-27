import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/services/auth.dart';

class VerificationScreen extends StatefulWidget {

  final String email;

  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    // Scales

    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);

    // Code

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: scale * 150,
              width: scale * 150,
              child: IconButton(
                onPressed: () async {
                  await Auth.sendVerificationEmail(widget.email);
                },
                icon: Icon(
                  Icons.verified,
                  color: AppColors.white,
                  size: 50 * scale,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.mainGreen,
                ),
              ),
            ),

            SizedBox(height: scale * 30),

            Text(
              'Pulsa para verificar tu cuenta',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: scale * 25,
                color: AppColors.mainGreen,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: scale * 30),

            Text(
              'Es necesario que verifiques tu cuenta para poder acceder a la aplicación',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: scale * 15,
                color: AppColors.mainGreen,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
