part of 'favorite_meals_bloc.dart';

//Estado de los favoritos
enum FavoriteMealsStatus { initial, loading, success, failure }

class FavoriteMealsState {
  final FavoriteMealsStatus status;
  final List<Meal> meals;
  final String errorMessage;

  //Constructor de los favoritos
  FavoriteMealsState({
    this.status = FavoriteMealsStatus.initial,
    this.meals = const [],
    this.errorMessage = '',
  });

  //Copiar los favoritos
  FavoriteMealsState copyWith({
    FavoriteMealsStatus? status,
    List<Meal>? meals,
    String? errorMessage,
  }) {
    //Devolver los favoritos
    return FavoriteMealsState(
      status: status ?? this.status,
      meals: meals ?? this.meals,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
} 