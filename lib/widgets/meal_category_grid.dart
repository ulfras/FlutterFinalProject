// ignore_for_file: use_build_context_synchronously

import 'package:final_project/screens/meal_list_screen.dart';
import 'package:flutter/material.dart';
import '../models/meal_category_model.dart';
import '../services/meal_category_service.dart';
import '../services/meal_list_api.dart';

class MealCategoryGrid extends StatelessWidget {
  final int gridCount;

  const MealCategoryGrid({Key? key, required this.gridCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MealCategory> mealCategoryList =
        MealCategoryService.getMealCategories();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.count(
        crossAxisCount: gridCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: mealCategoryList.map((category) {
          return InkWell(
            onTap: () async {
              final meals =
                  await MealApi.getMealsByCategory(category.strCategory);

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MealListScreen(category: category, mealList: meals)),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      category.strCategoryThumb,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      category.strCategory,
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
        }).toList(),
      ),
    );
  }
}
