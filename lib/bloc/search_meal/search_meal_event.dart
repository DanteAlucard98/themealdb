part of 'search_meal_bloc.dart';

abstract class SearchMealEvent {}

//Evento para buscar comida
class FetchSearchMeal extends SearchMealEvent {
  final String namePlate;

  FetchSearchMeal(this.namePlate);
}

// Evento para cargar los últimos resultados guardados
class LoadLastSearchResults extends SearchMealEvent {}