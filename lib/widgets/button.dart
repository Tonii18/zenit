import 'package:flutter/material.dart';

class CustomeButton extends StatefulWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback? onPressed;

  const CustomeButton({
    super.key,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.borderRadius,
    required this.text,
    required this.textColor,
    required this.fontSize,
    required this.fontWeight,
    this.onPressed,
    required this.borderColor,
  });

  @override
  State<CustomeButton> createState() => _CustomeButtonState();
}

class _CustomeButtonState extends State<CustomeButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          side: BorderSide(color: widget.borderColor),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.textColor,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
          ),
        ),
      ),
    );
  }
}
