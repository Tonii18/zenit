// ignore_for_file: unused_local_variable, prefer_final_fields, unused_field, unused_element

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/services/emotional_service.dart';

class MonthHistory extends StatefulWidget {
  const MonthHistory({super.key});

  @override
  State<MonthHistory> createState() => _MonthHistoryState();
}

class _MonthHistoryState extends State<MonthHistory> {
  Map<String, int> _emotionalCalendar = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadEmotions();
  }

  Future<void> _loadEmotions() async {
    final emotions = await EmotionalService.getMonthRecords();

    Map<String, int> map = {};

    if (emotions != null) {
      for (var emotion in emotions) {
        map[emotion['date']] = emotion['emotionalValue'];
      }
    }

    setState(() {
      _emotionalCalendar = map;
      _loading = false;
    });
  }

  // Get the match color for each day of the month

  Color _getColor(int? value) {
    switch (value) {
      case 1:
        return Color(0xFFFF8A80);
      case 2:
        return Color(0xFFFFD180);
      case 3:
        return Color(0xFFFFF9C4);
      case 4:
        return Color(0xFFC8E6C9);
      case 5:
        return Color(0xFF81C784);
      default:
        return AppColors.lightGrey;
    }
  }

  // Create calendar

  List<Widget> _buildCalendar(double scale) {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final firstDayOfMonth = DateTime(now.year, now.month, 1).weekday;

    List<Widget> cells = [];

    final List<String> weekDaysHeader = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

    for (String day in weekDaysHeader) {
      cells.add(
        Center(
          child: Text(
            day,
            style: TextStyle(
              fontSize: scale * 13,
              fontWeight: FontWeight.w700,
              color: AppColors.mainGreen,
            ),
          ),
        ),
      );
    }

    for (int i = 1; i < firstDayOfMonth; i++) {
      cells.add(SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final dateStr =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
      final emotionalValue = _emotionalCalendar[dateStr];

      cells.add(
        Container(
          margin: EdgeInsets.all(scale * 2),
          decoration: BoxDecoration(
            color: _getColor(emotionalValue),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              day.toString(),
              style: TextStyle(
                fontSize: scale * 13,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      );
    }

    return cells;
  }

  String _getMonthName() {
    const months = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];
    return months[DateTime.now().month - 1];
  }

  Widget _legendItem(double scale, Color color, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: scale * 3),
      child: Row(
        children: [
          Container(
            width: scale * 20,
            height: scale * 20,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(width: scale * 10),
          Text(
            label,
            style: TextStyle(fontSize: scale * 13, color: AppColors.darkerGrey),
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
                    'Mi mes',
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

              Text(
                _getMonthName(),
                style: TextStyle(
                  fontSize: scale * 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkerGrey,
                ),
              ),

              SizedBox(height: scale * 20),

              /**
               * Calendar content
               */
              _loading
                  ? CircularProgressIndicator(color: AppColors.mainGreen)
                  : Container(
                      padding: EdgeInsets.all(scale * 15),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: GridView.count(
                        crossAxisCount: 7,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: _buildCalendar(scale),
                      ),
                    ),

              SizedBox(height: scale * 20),

              Container(
                padding: EdgeInsets.all(scale * 15),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Leyenda',
                      style: TextStyle(
                        fontSize: scale * 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkerGrey,
                      ),
                    ),
                    SizedBox(height: scale * 10),
                    _legendItem(scale, Color(0xFFFF8A80), 'Muy mal'),
                    _legendItem(scale, Color(0xFFFFD180), 'Mal'),
                    _legendItem(scale, Color(0xFFFFF9C4), 'Regular'),
                    _legendItem(scale, Color(0xFFC8E6C9), 'Bien'),
                    _legendItem(scale, Color(0xFF81C784), 'Muy bien'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
