import 'package:flutter/material.dart';
import '../models/meal_category_model.dart';
import '../models/meal_list_model.dart';
import '../widgets/meal_list_widget.dart';

class MealListScreen extends StatelessWidget {
  final MealCategory category;
  final List<MealList> mealList;

  const MealListScreen(
      {super.key, required this.category, required this.mealList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${category.strCategory} List"),
        backgroundColor: Colors.amber,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            //Meal List List
            return MealsListWidget(meals: mealList, gridCount: 1);
          } else if (constraints.maxWidth <= 1200) {
            //Meal List Grid 4
            return MealsListWidget(meals: mealList, gridCount: 4);
          } else {
            //Meal List Grid 6
            return MealsListWidget(meals: mealList, gridCount: 6);
          }
        },
      ),
    );
  }
}
