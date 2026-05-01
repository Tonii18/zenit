class ExerciseModel {
  final String weekDay;
  final String name;
  final int sets;
  final int reps;
  final double weight;

  ExerciseModel({required this.weekDay, required this.name, required this.sets, required this.reps, required this.weight});

  Map<String, dynamic> toJson() {
    return {
      'weekDay': weekDay,
      'name': name,
      'sets': sets,
      'reps': reps,
      'weight': weight
    };
  }

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      weekDay: json['weekDay'],
      name: json['name'],
      sets: json['sets'],
      reps: json['reps'],
      weight: json['weight']
    );
  }
}
