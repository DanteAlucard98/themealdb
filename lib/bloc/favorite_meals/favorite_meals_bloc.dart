import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/meal_datasources.dart';
import 'package:recetas_adpp_2025/services/favorites_service.dart';

part 'favorite_meals_event.dart';
part 'favorite_meals_state.dart';

class FavoriteMealsBloc extends Bloc<FavoriteMealsEvent, FavoriteMealsState> {
  final MealDatasource _mealDatasource;
  final FavoritesService _favoritesService;

  FavoriteMealsBloc({
    required MealDatasource mealDatasource,
  }) : _mealDatasource = mealDatasource,
       _favoritesService = FavoritesService(),
       super(FavoriteMealsState()) {
    on<LoadFavoriteMeals>(_onLoadFavoriteMeals);
    on<RefreshFavoriteMeals>(_onRefreshFavoriteMeals);
  }

  Future<void> _onLoadFavoriteMeals(
    LoadFavoriteMeals event,
    Emitter<FavoriteMealsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FavoriteMealsStatus.loading));

      final favoriteIds = await _favoritesService.getFavorites();
      final meals = <Meal>[];

      for (final id in favoriteIds) {
        try {
          final meal = await _mealDatasource.getMeal(id);
          meals.add(meal);
        } catch (e) {
          // Skip failed meals
          continue;
        }
      }

      emit(state.copyWith(
        status: FavoriteMealsStatus.success,
        meals: meals,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FavoriteMealsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshFavoriteMeals(
    RefreshFavoriteMeals event,
    Emitter<FavoriteMealsState> emit,
  ) async {
    try {
      final favoriteIds = await _favoritesService.getFavorites();
      final meals = <Meal>[];

      for (final id in favoriteIds) {
        try {
          final meal = await _mealDatasource.getMeal(id);
          meals.add(meal);
        } catch (e) {
          // Skip failed meals
          continue;
        }
      }

      emit(state.copyWith(
        status: FavoriteMealsStatus.success,
        meals: meals,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FavoriteMealsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
} 