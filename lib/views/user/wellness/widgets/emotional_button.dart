// ignore_for_file: sized_box_for_whitespace, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/services/emotional_service.dart';

class EmotionalButton extends StatelessWidget {
  final Color color;
  final double scale;
  final String value;

  const EmotionalButton({
    super.key,
    required this.scale,
    required this.color,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: scale * 50,
      height: scale * 50,

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),

      child: TextButton(
        onPressed: () async {
          final success = await EmotionalService.saveRecord(
            int.tryParse(value) ?? 0,
          );

          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Estado emocional registrado correctamente'),
              )
            );
          }else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Ya has registrado tu estado emocional hoy'),
                backgroundColor: AppColors.mainRed,
              ),
            );
          }
        },
        child: Text(
          value,
          style: TextStyle(
            fontSize: scale * 20,
            fontWeight: FontWeight.w900,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
