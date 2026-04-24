import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/views/user/home/settings.dart';

class HomeHeader extends StatelessWidget {
  final String? name;

  const HomeHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final scale = Measures.scale(context);

    final Shader linearGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        AppColors.mainGreen,
        AppColors.mainPink,
        AppColors.mainOrange,
      ],
      stops: [0.3, 0.6, 0.9],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Container(
      height: scale * 140,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Bienvenido \n${name ?? "Invitado"}',
            style: TextStyle(
              foreground: Paint()..shader = linearGradient,
              fontSize: scale * 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
            icon: Icon(
              Icons.settings,
              size: scale * 30,
              color: AppColors.mainOrange,
            ),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size.zero,
            ),
          ),
        ],
      ),
    );
  }
}
