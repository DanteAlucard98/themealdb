part of 'favorite_meals_bloc.dart';

abstract class FavoriteMealsEvent {}

//Cargar los favoritos
class LoadFavoriteMeals extends FavoriteMealsEvent {}

//Refrescar los favoritos
class RefreshFavoriteMeals extends FavoriteMealsEvent {} 