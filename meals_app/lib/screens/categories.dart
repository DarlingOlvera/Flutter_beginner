import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;
  void _selectCategory(BuildContext context, Category category) {
    //filtra las comidas cuyas categorias ids concuerden con la de la categoria pasada como parametro
    final filteredMeals = availableMeals
        .where((element) => element.categories.contains(category.id))
        .toList();

    //sirve para navegar entre screens, hace uso de un stack
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          category: category,
          meals: filteredMeals,
        ),
      ),
    ); //Navigator.of(context).push(route) es lo mismo
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //deja definir el numero de columnas en el grid
        crossAxisCount: 2, //numero de columnas
        childAspectRatio: 3 / 2, //size de los hijos
        crossAxisSpacing: 20, //espacio en x
        mainAxisSpacing: 20, //espacio en y
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectedCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
