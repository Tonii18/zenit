// ignore_for_file: unused_field, unused_local_variable

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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Icon(Icons.support_outlined, color: AppColors.mainGreen,),

                                  Text(
                                    habit['name'] ?? ' ',
                                    style: TextStyle(
                                      fontSize: scale * 14,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.darkerGrey,
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: () {
                                      //_deleteEntry(entry['id']);
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
                        );
                      },
                    ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //_openCreateDialog();
        },
        backgroundColor: AppColors.mainGreen,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
