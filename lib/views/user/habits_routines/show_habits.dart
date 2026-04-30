// ignore_for_file: unused_field, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/services/show_habits_service.dart';

class ShowHabits extends StatefulWidget {
  const ShowHabits({super.key});

  @override
  State<ShowHabits> createState() => _ShowHabitsState();
}

class _ShowHabitsState extends State<ShowHabits> {
  List<dynamic> _habits = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    final habits = await ShowHabitsService.getHabits();
    setState(() {
      _habits = habits ?? [];
      _loading = false;
    });
  }

  Future<void> _deleteHabit(int id) async {
    final success = await ShowHabitsService.deleteHabit(id);
    if (success) {
      await _loadHabits();
    }
  }

  Future<void> _checkHabit(int id) async {
    final succes = await ShowHabitsService.checkHabit(id);
    if (succes) {
      await _loadHabits();
    }
  }

  void _openCreateHabit() {
    final habitController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        title: Text(
          'Nuevo hábito',
          style: TextStyle(
            color: AppColors.mainGreen,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: habitController,
              decoration: InputDecoration(
                hintText: 'Escribir hábito',
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
              final habit = habitController.text.trim();

              if (habit.isEmpty) return;

              final success = await ShowHabitsService.createHabit(habit);
              Navigator.pop(context);

              if (success) _loadHabits();
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
          horizontal: scale * 35,
          vertical: scale * 35,
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
                    'Mis hábitos diarios',
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
                  : _habits.isEmpty
                  ? Text(
                      'Aún no has escrito ningun hábito. ¡Empieza ya!',
                      style: TextStyle(color: AppColors.darkerGrey),
                      textAlign: TextAlign.center,
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _habits.length,
                      separatorBuilder: (_, __) => SizedBox(height: scale * 10),
                      itemBuilder: (context, index) {
                        final habit = _habits[index];
                        return Container(
                          padding: EdgeInsets.all(scale * 15),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: BoxBorder.all(color: AppColors.mainGreen),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.support_outlined,
                                    color: AppColors.mainGreen,
                                  ),

                                  Text(
                                    habit['name'] ?? ' ',
                                    style: TextStyle(
                                      fontSize: scale * 14,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.darkerGrey,
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      Checkbox(
                                        value: habit['completed'] ?? false,
                                        activeColor: AppColors.mainGreen,
                                        onChanged: (value) {
                                          _checkHabit(habit['id']);
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _deleteHabit(habit['id']);
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
                                ],
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
          _openCreateHabit();
        },
        backgroundColor: AppColors.mainGreen,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
