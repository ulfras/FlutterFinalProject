class MealList {
  final String strMeal;
  final String strMealThumb;
  final String idMeal;

  MealList({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory MealList.fromJson(Map<String, dynamic> json) {
    return MealList(
      strMeal: json['strMeal'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      idMeal: json['idMeal'] ?? '',
    );
  }
}
