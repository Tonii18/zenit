import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/views/user/home/journal.dart';

class ScreenWidgets extends StatelessWidget {
  const ScreenWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = Measures.scale(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        // Weather widget
        Expanded(
          child: Container(
            height: scale * 90,
            decoration: BoxDecoration(
              gradient: _getGradient(),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Positioned(top: 12, left: 12, child: _getIcon()),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Text(
                    _getGreeting(),
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: scale * 20),

        // Journal button
        Expanded(
          child: Container(
            height: scale * 90,
            decoration: BoxDecoration(
              color: AppColors.mainGreen,
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Journal()),
                );
              },
              icon: Icon(Icons.book, color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }

  LinearGradient _getGradient() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 9) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.mainPink, AppColors.mainOrange],
      );
    } else if (hour >= 9 && hour < 18) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color.fromRGBO(0, 180, 216, 1), AppColors.mainGreen],
      );
    } else if (hour >= 18 && hour < 21) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(43, 27, 61, 1),
          Color.fromRGBO(111, 50, 121, 1),
          Color.fromRGBO(216, 58, 86, 1),
          Color.fromRGBO(255, 123, 84, 1),
          Color.fromRGBO(255, 178, 107, 1),
        ],
      );
    } else {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(11, 14, 20, 1),
          Color.fromRGBO(22, 27, 34, 1),
          Color.fromRGBO(36, 52, 71, 1),
          Color.fromRGBO(61, 78, 123, 1),
          Color.fromRGBO(142, 148, 178, 1),
        ],
      );
    }
  }

  Icon _getIcon() {
    final hour = DateTime.now().hour;
    if (hour < 18) {
      return Icon(Icons.sunny, color: Colors.white);
    } else if (hour < 21) {
      return Icon(Icons.sunny_snowing, color: Colors.white);
    } else {
      return Icon(Icons.nightlight_round, color: Colors.white);
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Buenos días';
    } else if (hour < 20) {
      return 'Buenas tardes';
    } else {
      return 'Buenas noches';
    }
  }
}