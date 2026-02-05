class UserProfile {

  final String email;
  final int heightCm;
  final int weightKg;
  final int age;
  final String gender;
  final double dailyStepsGoal;

  UserProfile({ 
    required this.email,
    required this.heightCm, 
    required this.weightKg, 
    required this.age, 
    required this.gender, 
    required this.dailyStepsGoal
  });

  Map<String, dynamic> toJson(){
    return {
      'email': email,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'age': age,
      'gender': gender,
      'dailyStepsGoal': dailyStepsGoal
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
  return UserProfile(
    email: json['email'],
    heightCm: json['heightCm'],
    weightKg: json['weightKg'],
    age: json['age'],
    gender: json['gender'],
    dailyStepsGoal: json['dailyStepsGoal'],
  );
}
}
