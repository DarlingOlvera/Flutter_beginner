import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

//the class should extend StateNotifier and the name can be anything but its recomended that the
//name ends with Notifier. Its also necesary to define the type of the data soon to be manage
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  //in this case the constructor doesnt have initial parameters but instead an initial data
  //of the same type defined in the class
  FavoriteMealsNotifier()
      : super([]); //super is to call to the parent class (StateNotifier)

  bool toggleMealFavoriteStatus(Meal meal) {
    final isFavorite = state.contains(meal);

    if (isFavorite) {
      //si la comida ya se encuentra en la lista de favoritos entonces se elimina
      state = state.where((item) => item.id != meal.id).toList();
      return false;
    } else {
      //en caso contrario se agrega
      state = [...state, meal]; //el funcionamiento de spreat es igual que en js
      return true;
    }
  }
}

//this is the structure when the data is not static and a change of it is expected
//similar to a stateful widget this works with another class
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
