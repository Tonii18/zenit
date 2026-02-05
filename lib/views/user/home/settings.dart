// ignore_for_file: unused_local_variable, unused_field, prefer_final_fields, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/models/user_profile.dart';
import 'package:zenit/services/user_service.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  UserProfile? _userProfile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);

    final userData = await UserService.getCurrentUser();

    setState(() {
      _userProfile = userData;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: scale * 35,
          horizontal: scale * 35,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.mainGreen,
                      size: scale * 30,
                    ),
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                  ),
                  Text(
                    'Ajustes',
                    style: TextStyle(
                      fontSize: scale * 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.mainGreen,
                    ),
                  ),
                ],
              ),

              SizedBox(height: scale * 10),

              Divider(height: 1, color: AppColors.mainGreen),

              SizedBox(height: scale * 30),

              CircleAvatar(
                radius: scale * 60,
                backgroundColor: AppColors.mainGreen,
                child: Text(
                  '${_userProfile?.email[0].toUpperCase() ?? ' '}',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: scale * 50,
                  ),
                ),
              ),

              SizedBox(height: scale * 30),

              Text(
                '${_userProfile?.email ?? ' '}',
                style: TextStyle(fontSize: scale * 15),
              ),

              SizedBox(height: scale * 60),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Datos personales',
                  style: TextStyle(
                    fontSize: scale * 15,
                    fontWeight: FontWeight.w900,
                    color: AppColors.darkerGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
