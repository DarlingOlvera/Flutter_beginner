import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0; // 0 = categories page 1 = favorites page
  final List<Meal> _favoriteMeals = [];

  void _showInfoMessage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    //si la comida ya existe en favoritas entonces la quita y si no, la agrega
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage('This meal is no longer a favorite');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Marked as favorite');
      });
    }
  }

  void _selecPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result =
          await Navigator.of(context).pushReplacement<Map<Filter, bool>, void>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );

      print('result here: $result');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activepage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activepage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activepage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selecPage(index);
        },
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu_rounded), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}
