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
      'heightCm': heightCm,
      'weightKg': weightKg,
      'age': age,
      'gender': gender,
      'dailyStepsGoal': dailyStepsGoal
    };
  }
}
