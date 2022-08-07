import 'package:flutter/material.dart';

import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';

import './dummy_data.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _filteredMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _saveFilters(Map<String, bool> filterData) {
    _filters = filterData;

    _filteredMeals = DUMMY_MEALS.where((meal) {
      if (_filters['gluten'] && !meal.isGlutenFree) {
        return false;
      }
      if (_filters['lactose'] && !meal.isLactoseFree) {
        return false;
      }
      if (_filters['vegan'] && !meal.isVegan) {
        return false;
      }
      if (_filters['vegetarian'] && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    setState(() {});
  }

  void _toggleFavoriteMeal(String mealId) {
    int currentIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (currentIndex >= 0) {
      _favoriteMeals.removeAt(currentIndex);
    } else {
      _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    }

    setState(() {});
  }

  bool _isFavoriteMeal(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yumm Meals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyMedium: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodySmall: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleMedium: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_filteredMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavoriteMeal, _isFavoriteMeal),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _saveFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => TabsScreen(_favoriteMeals),
        );
      },
    );
  }
}
