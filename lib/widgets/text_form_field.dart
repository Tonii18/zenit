import 'package:flutter/material.dart';

class CustomeFormField extends StatefulWidget {

  final double width;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color iconColor;
  final Color focusedOutlinedBorder;
  final TextEditingController? textEditingController;
  final bool isPassword;
  final IconData icon;

  const CustomeFormField({super.key, required this.width, required this.text, required this.textColor, required this.backgroundColor, required this.iconColor, required this.focusedOutlinedBorder, this.textEditingController, required this.isPassword, required this.icon});

  @override
  State<CustomeFormField> createState() => _CustomeFormFieldState();
}

class _CustomeFormFieldState extends State<CustomeFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        obscureText: widget.isPassword,

        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          prefixIconColor: widget.iconColor,

          filled: true,
          fillColor: widget.backgroundColor,

          hintText: widget.text,
          hintStyle: TextStyle(
            color: widget.textColor,
            fontFamily: 'MontserratAlternates',
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),

          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.focusedOutlinedBorder),
          ),
        ),
      ),
    );
  }
}
