import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFavoriteMeal;
  final Function isFavoriteMeal;

  MealDetailScreen(this.toggleFavoriteMeal, this.isFavoriteMeal);

  static const routeName = '/meal-detail';

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _buildSectionContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavoriteMeal(mealId) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFavoriteMeal(mealId),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Text('Network Issue :('),
                ),
              ),
              _buildSectionTitle(context, 'Ingredients'),
              _buildSectionContainer(
                ListView.builder(
                  itemCount: selectedMeal.ingredients.length,
                  itemBuilder: (_, index) {
                    return Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(
                          selectedMeal.ingredients[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildSectionTitle(context, 'Steps'),
              _buildSectionContainer(
                ListView.builder(
                  itemCount: selectedMeal.steps.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('# ${index + 1}'),
                          ),
                          title: Text(selectedMeal.steps[index]),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
