// ignore_for_file: avoid_print

import 'package:final_project/models/meal_list_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MealApi {
  static Future<List<MealList>> getMealsByCategory(String strCategory) async {
    final apiUrl =
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$strCategory';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> mealsData = data['meals'];
        List<MealList> meals =
            mealsData.map((mealData) => MealList.fromJson(mealData)).toList();
        return meals;
      } else {
        print('Failed to load meals. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching meals: $error');
      return [];
    }
  }
}
