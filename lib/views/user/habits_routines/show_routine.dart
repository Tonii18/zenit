// ignore_for_file: unused_local_variable, prefer_final_fields, unused_field, prefer_interpolation_to_compose_strings, use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/models/exercise_model.dart';
import 'package:zenit/services/workout_service.dart';

class ShowRoutine extends StatefulWidget {
  final String weekDay;

  const ShowRoutine({super.key, required this.weekDay});

  @override
  State<ShowRoutine> createState() => _ShowRoutineState();
}

class _ShowRoutineState extends State<ShowRoutine> {
  List<dynamic> _routine = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadRoutine();
  }

  Future<void> _loadRoutine() async {
    final routine = await WorkoutService.getRoutine(widget.weekDay);
    setState(() {
      _routine = routine ?? [];
      _loading = false;
    });
  }

  Future<void> _deleteExercise(int id) async {
    final success = await WorkoutService.deleteExercise(id);
    if (success) {
      await _loadRoutine();
    }
  }

  void _openCreateExercise() {
    final nameController = TextEditingController();
    final setsController = TextEditingController();
    final repsController = TextEditingController();
    final weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        title: Text(
          'Nuevo ejercicio',
          style: TextStyle(
            color: AppColors.mainGreen,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Nombre del ejercicio',
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
              controller: setsController,
              decoration: InputDecoration(
                hintText: 'Número de series',
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
              controller: repsController,
              decoration: InputDecoration(
                hintText: 'Número de repeticiones',
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
              controller: weightController,
              decoration: InputDecoration(
                hintText: 'Lastre (opcional)',
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
              final nameString = nameController.text.trim();
              final setsString = setsController.text.trim();
              final repsString = repsController.text.trim();
              final weightString = weightController.text.trim();

              if (nameString.isEmpty ||
                  setsString.isEmpty ||
                  repsString.isEmpty)
                return;

              final int setsInt = int.tryParse(setsString) ?? 0;
              final int repsInt = int.tryParse(repsString) ?? 0;

              final double weightDouble = weightString.isEmpty
                  ? 0.0
                  : (double.tryParse(weightString) ?? 0.0);

              ExerciseModel exerciseModel = ExerciseModel(
                weekDay: widget.weekDay,
                name: nameString,
                sets: setsInt,
                reps: repsInt,
                weight: weightDouble,
              );

              final success = await WorkoutService.createExercise(
                exerciseModel,
              );
              Navigator.pop(context);

              if (success) _loadRoutine();
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
                    widget.weekDay,
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
                  : _routine.isEmpty
                  ? Text(
                      'Aún no has creado ningún ejercicio. ¡Empieza ya!',
                      style: TextStyle(color: AppColors.darkerGrey),
                      textAlign: TextAlign.center,
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _routine.length,
                      separatorBuilder: (_, __) => SizedBox(height: scale * 10),
                      itemBuilder: (context, index) {
                        final exercise = _routine[index];
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
                                Icons.sports_handball_sharp,
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
                                        exercise['name'] ?? ' ',
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
                                        exercise['sets'].toString() +
                                            'x' +
                                            exercise['reps'].toString(),
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
                                exercise['weight'].toString() + ' Kg',
                                style: TextStyle(
                                  fontSize: scale * 15,
                                  fontWeight: FontWeight.w100,
                                  color: AppColors.darkBlue,
                                ),
                              ),

                              SizedBox(width: scale * 25),

                              IconButton(
                                onPressed: () {
                                  _deleteExercise(exercise['id']);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openCreateExercise();
        },
        backgroundColor: AppColors.mainGreen,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
