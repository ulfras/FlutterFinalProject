// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../models/meal_category_model.dart';
import '../screens/meal_list_screen.dart';
import '../services/meal_category_service.dart';
import '../services/meal_list_api.dart';

class MealCategoryList extends StatelessWidget {
  const MealCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MealCategory> mealCategoryList =
        MealCategoryService.getMealCategories();

    return ListView.builder(
      itemBuilder: (context, index) {
        final MealCategory category = mealCategoryList[index];
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Image.network(category.strCategoryThumb),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          category.strCategory,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: mealCategoryList.length,
    );
  }
}
