// search_meal_state.dart
part of 'search_meal_bloc.dart';

enum SearchMealStatus { initial, loading, success, failure }

class SearchMealState {
  final SearchMealStatus status;
  final List<Meal> searchMeals; // Change to a list of meals
  final String errorMessage;

  SearchMealState({
    this.status = SearchMealStatus.initial,
    this.searchMeals = const [], // Initialize as an empty list
    this.errorMessage = '',
  });

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