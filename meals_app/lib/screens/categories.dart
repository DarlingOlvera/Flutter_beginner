import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController
      _animationController; //tells dart that the variable will have a value when used but not yet when the class is created

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, //required
      duration: const Duration(milliseconds: 300), //duration of animation
      //boundaries to which the animation will work, 0 and 1 are the default values
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward(); //start the animation
  }

  @override
  void dispose() {
    //making sure the animation is disposed from memory when the widget is
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    //filtra las comidas cuyas categorias ids concuerden con la de la categoria pasada como parametro
    final filteredMeals = widget.availableMeals
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
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
