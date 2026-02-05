import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/views/user/home/home.dart';
import 'package:zenit/widgets/custom_bottom_navbar.dart';

class NavbarController extends StatefulWidget {
  const NavbarController({super.key});

  @override
  State<NavbarController> createState() => _NavbarControllerState();
}

class _NavbarControllerState extends State<NavbarController> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    Home(),
    Home(),
    Home(),
    Home()
  ];

  void onNavTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: screens[selectedIndex],
      bottomNavigationBar: CustomBottomNavbar(currentIndex: selectedIndex, onTap: onNavTapped),
    );
  }
}
