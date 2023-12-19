import 'package:flutter/material.dart';
import '../models/meal_list_model.dart';
import '../screens/meal_detail_screen.dart';
import '../services/meal_detail_api.dart';

class MealsListWidget extends StatelessWidget {
  final List<MealList> meals;
  final int gridCount;

  const MealsListWidget(
      {super.key, required this.meals, required this.gridCount});

  @override
  Widget build(BuildContext context) {
    if (gridCount == 1) {
      // List view
      return ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return ListTile(
            title: Text(meal.strMeal),
            subtitle: Text(meal.idMeal),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(meal.strMealThumb),
            ),
            onTap: () => _navigateToMealDetail(context, meal.idMeal),
          );
        },
      );
    } else {
      // Grid view
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridCount,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return InkWell(
            onTap: () => _navigateToMealDetail(context, meal.idMeal),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      meal.strMealThumb,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      meal.strMeal,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  void _navigateToMealDetail(BuildContext context, String mealId) async {
    final mealDetails = await MealDetailApi.getMealDetails(mealId);
    final mealDetail = mealDetails.isNotEmpty ? mealDetails.first : null;

    if (mealDetail != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealDetailScreen(
            mealName: mealDetail.strMeal ?? "",
            mealImage: mealDetail.strMealThumb ?? "",
            category: mealDetail.strCategory ?? "",
            area: mealDetail.strArea ?? "",
            instructions: mealDetail.strInstructions ?? "",
            tags: mealDetail.strTags ?? "",
            youtubeLink: mealDetail.strYoutube ?? "",
            sourceLink: mealDetail.strSource ?? "",
          ),
        ),
      );
    } else {
      // Handle the case where meal details are not available
    }
  }
}
