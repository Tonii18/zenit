class UserProfile {

  final int heightCm;
  final int weightKg;
  final int age;
  final String gender;
  final double dailyStepsGoal;

  UserProfile({ 
    required this.heightCm, 
    required this.weightKg, 
    required this.age, 
    required this.gender, 
    required this.dailyStepsGoal
  });

  Map<String, dynamic> toJson(){
    return {
      'height_cm': heightCm,
      'weight_kg': weightKg,
      'age': age,
      'gender': gender,
      'daily_steps_goal': dailyStepsGoal
    };
  }
}
