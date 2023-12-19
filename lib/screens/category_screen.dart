import 'package:flutter/material.dart';
import '../widgets/meal_category_grid.dart';
import '../widgets/meal_category_list.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Categories'),
        backgroundColor: Colors.amber,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return const MealCategoryList();
          } else if (constraints.maxWidth <= 1200) {
            return const MealCategoryGrid(gridCount: 4);
          } else {
            return const MealCategoryGrid(gridCount: 6);
          }
        },
      ),
    );
  }
}
