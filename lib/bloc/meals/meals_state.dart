import 'package:recetas_adpp_2025/domain/entities/list_meal.dart';

enum MealsStatus { initial, loading, success, failure, loadingMore }

class MealsState {
  final MealsStatus status;
  final List<ListMeal> meals;
  final String errorMessage;
  final String currentLetter;
  final bool hasReachedMax;
  final int currentPage;
  final int alphabet;

  MealsState({
    this.status = MealsStatus.initial,
    this.meals = const [], //lista de comidas
    this.errorMessage = '',
    this.currentLetter = 'a', // Por defecto comienza con la letra 'a'
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.alphabet = 0,  // 0 representa 'a', 1 representa 'b', etc.
  });

  MealsState copyWith({
    MealsStatus? status,
    List<ListMeal>? meals,
    String? errorMessage,
    String? currentLetter,
    bool? hasReachedMax,
    int? currentPage,
    int? alphabet,
  }) {
    return MealsState(
      status: status ?? this.status,
      meals: meals ?? this.meals,
      errorMessage: errorMessage ?? this.errorMessage,
      currentLetter: currentLetter ?? this.currentLetter,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      alphabet: alphabet ?? this.alphabet,
    );
  }
} 