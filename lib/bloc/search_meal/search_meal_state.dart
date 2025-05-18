part of 'search_meal_bloc.dart';
enum SearchMealStatus { initial, loading, success, failure }

class SearchMealState {
  final SearchMealStatus status;
  final SearchMeal? searchMeal; //comidas encontrada
  final String errorMessage;
  final String idMeal; //id de la comida
  SearchMealState({
    this.status = SearchMealStatus.initial,
    this.searchMeal,
    this.errorMessage = '',
    this.idMeal = '',
  });

  SearchMealState copyWith({
    SearchMealStatus? status,
    SearchMeal? searchMeal,
    String ? idMeal,
    String? errorMessage,
  }) {
    return SearchMealState(
      status: status ?? this.status,
      searchMeal: searchMeal ?? this.searchMeal,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

