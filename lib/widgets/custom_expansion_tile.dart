// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/core/secure_storage.dart';
import 'package:zenit/views/auth/login_screen.dart';

class CustomExpansionTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String content;

  const CustomExpansionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  @override
  Widget build(BuildContext context) {
    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);

    return ExpansionTile(
      leading: Container(
        width: scale * 40,
        height: scale * 40,
        decoration: BoxDecoration(
          color: widget.title == 'Cerrar sesion'
              ? AppColors.mainRed
              : AppColors.mainGreen,
          shape: BoxShape.circle,
        ),
        child: Icon(widget.icon, size: scale * 20, color: AppColors.white),
      ),
      tilePadding: EdgeInsets.symmetric(horizontal: scale * 10),
      childrenPadding: EdgeInsets.symmetric(
        vertical: scale * 10,
        horizontal: scale * 10,
      ),
      title: Text(
        widget.title,
        style: TextStyle(fontSize: scale * 15, color: AppColors.darkerGrey),
      ),
      backgroundColor: AppColors.white,
      collapsedBackgroundColor: AppColors.white,
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(30),
      ),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(30),
      ),
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: widget.title != 'Cerrar sesion'
              ? Text(
                  widget.content,
                  style: TextStyle(
                    color: AppColors.darkerGrey,
                    fontWeight: FontWeight.w900,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    logout();
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    color: AppColors.mainRed,
                    size: scale * 30,
                  ),
                ),
        ),
      ],
    );
  }

  void logout() async {
    String token = SecureStorage.getToken().toString();
    SecureStorage.deleteToken(token);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
