// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/models/activity_record_model.dart';
import 'package:zenit/services/activity_service.dart';

class ActivityButton extends StatefulWidget {
  final double scale;
  final Icon icon;
  final String name;

  const ActivityButton({
    super.key,
    required this.scale,
    required this.icon,
    required this.name,
  });

  @override
  State<ActivityButton> createState() => _ActivityButtonState();
}

class _ActivityButtonState extends State<ActivityButton> {
  void _openCreateActivity() {
    final distanceController = TextEditingController();
    final minutesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        title: Text(
          'Nueva Actividad',
          style: TextStyle(
            color: AppColors.mainGreen,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: distanceController,
              decoration: InputDecoration(
                hintText: 'Distancia recorrida (en Km)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: AppColors.mainGreen),
                ),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: minutesController,
              decoration: InputDecoration(
                hintText: 'Duración de actividad (en Minutos)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: AppColors.mainGreen),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: TextStyle(color: AppColors.darkerGrey),
            ),
          ),
          TextButton(
            onPressed: () async {
              final distanceString = distanceController.text.trim();
              final minutesString = minutesController.text.trim();

              if (distanceString.isEmpty || minutesString.isEmpty) return;

              final double distanceDouble =
                  double.tryParse(distanceString) ?? 0;
              final int minutesInt = int.tryParse(minutesString) ?? 0;

              DateTime now = DateTime.now();

              ActivityRecordModel activityRecordModel = ActivityRecordModel(
                activityType: widget.name,
                totalDistance: distanceDouble,
                totalMinutes: minutesInt,
                totalCalories: 0.0,
                date: now,
                time: now,
              );

              final success = await ActivityService.createActivity(
                activityRecordModel,
              );
              Navigator.pop(context);
            },
            child: Text(
              'Guardar',
              style: TextStyle(color: AppColors.mainGreen),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.scale * 100,
      height: widget.scale * 100,

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.mainGreen),
      ),

      child: IconButton(
        onPressed: () {
          _openCreateActivity();
        },
        icon: widget.icon,
        color: AppColors.mainGreen,
        iconSize: widget.scale * 40,
      ),
    );
  }
}
