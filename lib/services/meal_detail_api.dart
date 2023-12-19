import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/meal_detail_model.dart';

class MealDetailApi {
  static Future<List<MealDetail>> getMealDetails(String mealId) async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> meals = data['meals'];
      return meals.map((meal) => MealDetail.fromJson(meal)).toList();
    } else {
      throw Exception('Failed to load meal details');
    }
  }
}
