// search_meal_state.dart
part of 'search_meal_bloc.dart';

//Estado de la búsqueda de comidas
enum SearchMealStatus { initial, loading, success, failure }

class SearchMealState {
  final SearchMealStatus status;
  final List<Meal> searchMeals; // Change to a list of meals
  final String errorMessage;

  //Constructor de la búsqueda de comidas
  SearchMealState({
    this.status = SearchMealStatus.initial,
    this.searchMeals = const [], // Initialize as an empty list
    this.errorMessage = '',
  });

  //Copiar la búsqueda de comidas
  SearchMealState copyWith({
    SearchMealStatus? status,
    List<Meal>? searchMeals,
    String? errorMessage,
  }) {
    return SearchMealState(
      status: status ?? this.status,
      searchMeals: searchMeals ?? this.searchMeals,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}