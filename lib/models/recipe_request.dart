class RecipeRequest {
  final int protein;
  final int carbs;
  final int fiber;
  final int calories;

  RecipeRequest({required this.protein, required this.carbs, required this.fiber, required this.calories});

  Map<String, dynamic> toJson() {
    return {
      'protein': protein,
      'carb': carbs,
      'fiber': fiber,
      'calorie': calories
    };
  }

  factory RecipeRequest.fromJson(Map<String, dynamic> json) {
    return RecipeRequest(
      protein: json['protein'],
      carbs: json['carbs'],
      fiber: json['fiber'],
      calories: json['calories'],
    );
  }
}
