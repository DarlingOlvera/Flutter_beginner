import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    //state[filter] = isActive; is not allowed => mutating state
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((element) {
    if (activeFilters[Filter.glutenFree]! && !element.isGlutenFree) {
      // se checa si el filtro es true y si la comida NO es gluten-free, entonces no se agrega a la lista
      //de modo que aqui se regresa false
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !element.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !element.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !element.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
