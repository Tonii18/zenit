class ActivityRecordModel {
  final String activityType;
  final double totalDistance;
  final int totalMinutes;
  final DateTime date;
  final DateTime time;

  ActivityRecordModel({required this.activityType, required this.totalDistance, required this.totalMinutes, required this.date, required this.time});

  Map<String, dynamic> toJson() {
    return {
      'activityType': activityType,
      'totalDistance': totalDistance,
      'totalMinutes': totalMinutes,
      'date': date,
      'time': time
    };
  }

  factory ActivityRecordModel.fromJson(Map<String, dynamic> json) {
    return ActivityRecordModel(
      activityType: json['activityType'],
      totalDistance: json['totalDistance'],
      totalMinutes: json['totalMinutes'],
      date: json['date'],
      time: json['time']
    );
  }
}
