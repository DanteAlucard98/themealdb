part of 'favorite_meals_bloc.dart';

enum FavoriteMealsStatus { initial, loading, success, failure }

class FavoriteMealsState {
  final FavoriteMealsStatus status;
  final List<Meal> meals;
  final String errorMessage;

  FavoriteMealsState({
    this.status = FavoriteMealsStatus.initial,
    this.meals = const [],
    this.errorMessage = '',
  });

  FavoriteMealsState copyWith({
    FavoriteMealsStatus? status,
    List<Meal>? meals,
    String? errorMessage,
  }) {
    return FavoriteMealsState(
      status: status ?? this.status,
      meals: meals ?? this.meals,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
} 