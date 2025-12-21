import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final Widget child;
  final double topMargin;

  const MyWidget({super.key, required this.child, required this.topMargin});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: topMargin),
        child: child,
      )
    );
  }
}