import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
}; //k al principio es la convencion recomendada de flutter para el nombre de variables globales

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0; // 0 = categories page 1 = favorites page
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

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
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );

      //print('result here: $result');
      setState(() {
        _selectedFilters = result ??
            kInitialFilters; //?? revisa si el valor es nulo y en caso de serlo permite la asignacion de un valor por defecto
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((element) {
      if (_selectedFilters[Filter.glutenFree]! && !element.isGlutenFree) {
        // se checa si el filtro es true y si la comida NO es gluten-free, entonces no se agrega a la lista
        //de modo que aqui se regresa false
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !element.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !element.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !element.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activepage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
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
