import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';

import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayMeals;
  bool initialLoaded = false;

  @override
  void didChangeDependencies() {
    if (initialLoaded == false) {
      final routeArgs =
      ModalRoute.of(context).settings.arguments as Map<String, String>;

      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      displayMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();

      initialLoaded = true;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    displayMeals.removeWhere((meal) => meal.id == mealId);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          return MealItem(
            mealId: displayMeals[index].id,
            title: displayMeals[index].title,
            imageUrl: displayMeals[index].imageUrl,
            duration: displayMeals[index].duration,
            complexity: displayMeals[index].complexity,
            affordability: displayMeals[index].affordability,
          );
        },
        itemCount: displayMeals.length,
      ),
    );
  }
}
