class MealDetail {
  final String? idMeal;
  final String? strMeal;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final String? strSource;

  MealDetail(
      {required this.idMeal,
      required this.strMeal,
      required this.strCategory,
      required this.strArea,
      required this.strInstructions,
      required this.strMealThumb,
      required this.strTags,
      required this.strYoutube,
      required this.strSource});

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    return MealDetail(
        idMeal: json['idMeal'],
        strMeal: json['strMeal'],
        strCategory: json['strCategory'],
        strArea: json['strArea'],
        strInstructions: json['strInstructions'],
        strMealThumb: json['strMealThumb'],
        strTags: json['strTags'],
        strYoutube: json['strYoutube'],
        strSource: json['strSource']);
  }
}
