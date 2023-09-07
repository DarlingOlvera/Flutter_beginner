import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/single_meal.dart';
import 'package:meals_app/widgets/meal_item.dart';
import 'package:meals_app/data/dummy_data.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.category,
    required this.meals,
  });

  final Category? category;
  final List<Meal> meals;

  void _selectedMeal(BuildContext context, Meal meal) {
    //filtra las comidas cuyas categorias ids concuerden con la de la categoria pasada como parametro
    final principalMeal =
        dummyMeals.where((element) => element.id == meal.id).toList();

    //sirve para navegar entre screens, hace uso de un stack
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleMealScreen(
          meal: principalMeal[0],
        ),
      ),
    ); //Navigator.of(context).push(route) es lo mismo
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) => MealItem(
              meal: meals[index],
              onSelectedMeal: () {
                _selectedMeal(context, meals[index]);
              },
            ));

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh ... nothing here!',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    }
    if (category != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            category!.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          backgroundColor: category!.color.withOpacity(0.7),
        ),
        body: content,
      );
    }
    return content;
  }
}
