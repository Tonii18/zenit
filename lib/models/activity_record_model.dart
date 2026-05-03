class ActivityRecordModel {
  final String activityType;
  final double totalDistance;
  final int totalMinutes;
  final double totalCalories;
  final DateTime date;
  final DateTime time;

  ActivityRecordModel({
    required this.activityType,
    required this.totalDistance,
    required this.totalMinutes,
    required this.totalCalories,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'activityType': activityType,
      'totalDistance': totalDistance,
      'totalMinutes': totalMinutes,
      'date': date.toIso8601String().split('T')[0],
      'time': time.toIso8601String().split('T')[1].substring(0, 8),
    };
  }

  factory ActivityRecordModel.fromJson(Map<String, dynamic> json) {
    return ActivityRecordModel(
      activityType: json['activityType'],
      totalDistance: json['totalDistance'],
      totalMinutes: json['totalMinutes'],
      totalCalories: json['totalCalories'] ?? 0.0,
      date: json['date'],
      time: json['time'],
    );
  }
}
