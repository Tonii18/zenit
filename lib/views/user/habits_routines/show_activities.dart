// ignore_for_file: unused_local_variable, prefer_final_fields, unused_field, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/services/activity_service.dart';

class ShowActivities extends StatefulWidget {
  const ShowActivities({super.key});

  @override
  State<ShowActivities> createState() => _ShowActivitiesState();
}

class _ShowActivitiesState extends State<ShowActivities> {
  List<dynamic> _activities = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    final activities = await ActivityService.getActivities();
    setState(() {
      _activities = activities ?? [];
      _loading = false;
    });
  }

  Future<void> _deleteActivity(int id) async {
    final success = await ActivityService.deleteActivity(id);
    if (success) {
      await _loadActivities();
    }
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
                    'Actividades registradas',
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

              SizedBox(height: scale * 20),

              /**
               * Content
               */
              _loading
                  ? CircularProgressIndicator(color: AppColors.mainGreen)
                  : _activities.isEmpty
                  ? Text(
                      'Aún no has registrado ninguna actividad. ¡Empieza ya!',
                      style: TextStyle(color: AppColors.darkerGrey),
                      textAlign: TextAlign.center,
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _activities.length,
                      separatorBuilder: (_, __) => SizedBox(height: scale * 10),
                      itemBuilder: (context, index) {
                        final activity = _activities[index];
                        return Container(
                          padding: EdgeInsets.all(scale * 15),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColors.lightGrey),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                activity['activityType'] == 'correr'
                                    ? Icons.directions_run
                                    : activity['activityType'] == 'caminar'
                                    ? Icons.directions_walk
                                    : activity['activityType'] == 'bicicleta'
                                    ? Icons.directions_bike
                                    : Icons
                                          .sports_handball_sharp, // Caso por defecto
                                color: AppColors.darkBlue,
                              ),

                              SizedBox(width: scale * 25),

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentGeometry.centerLeft,
                                      child: Text(
                                        activity['activityType'] ?? ' ',
                                        style: TextStyle(
                                          fontSize: scale * 15,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: scale * 5),

                                    Align(
                                      alignment: AlignmentGeometry.centerLeft,
                                      child: Text(
                                        activity['date'].toString(),
                                        style: TextStyle(
                                          fontSize: scale * 15,
                                          fontWeight: FontWeight.w100,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                    ),

                                    Align(
                                      alignment: AlignmentGeometry.centerLeft,
                                      child: Text(
                                        activity['time'].toString(),
                                        style: TextStyle(
                                          fontSize: scale * 15,
                                          fontWeight: FontWeight.w100,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                    ),

                                    Align(
                                      alignment: AlignmentGeometry.centerLeft,
                                      child: Text(
                                        activity['totalMinutes'].toString() + ' minutos',
                                        style: TextStyle(
                                          fontSize: scale * 15,
                                          fontWeight: FontWeight.w100,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                activity['totalCalories'].toString() + ' Kcal',
                                style: TextStyle(
                                  fontSize: scale * 15,
                                  fontWeight: FontWeight.w100,
                                  color: AppColors.darkBlue,
                                ),
                              ),

                              SizedBox(width: scale * 25),

                              IconButton(
                                onPressed: () {
                                  _deleteActivity(activity['id']);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: AppColors.mainRed,
                                ),
                                style: IconButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: Size.zero,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
