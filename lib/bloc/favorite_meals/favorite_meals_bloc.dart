import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/meal_datasources.dart';
import 'package:recetas_adpp_2025/services/favorites_service.dart';
import 'package:recetas_adpp_2025/services/connectivity_service.dart';
import 'package:recetas_adpp_2025/infraestructure/services/local_storage_service.dart';

part 'favorite_meals_event.dart';
part 'favorite_meals_state.dart';

class FavoriteMealsBloc extends Bloc<FavoriteMealsEvent, FavoriteMealsState> {
  final MealDatasource _mealDatasource;
  final FavoritesService _favoritesService;
  final LocalStorageService _localStorageService;
  final ConnectivityService _connectivityService = ConnectivityService();

  //Bloc para los favoritos
  FavoriteMealsBloc({
    required MealDatasource mealDatasource,
    required LocalStorageService localStorageService,
  }) : _mealDatasource = mealDatasource,
       _favoritesService = FavoritesService(),
       _localStorageService = localStorageService,
       super(FavoriteMealsState()) {
    on<LoadFavoriteMeals>(_onLoadFavoriteMeals);
    on<RefreshFavoriteMeals>(_onRefreshFavoriteMeals);
  }

  //Cargar los favoritos
  Future<void> _onLoadFavoriteMeals(
    LoadFavoriteMeals event,
    Emitter<FavoriteMealsState> emit,
  ) async {
    try {
      //Estado de carga
      emit(state.copyWith(status: FavoriteMealsStatus.loading));

      final favoriteIds = await _favoritesService.getFavorites();
      final meals = <Meal>[];

      // Si hay conexión a internet, intentamos obtener los datos de la API
      if (_connectivityService.hasInternet) {
        for (final id in favoriteIds) {
          try {
            final meal = await _mealDatasource.getMeal(id);
            meals.add(meal);
            // Guardamos cada comida en el almacenamiento local
            await _localStorageService.saveLastMealDetails(meal);
          } catch (e) {
            // Si falla la API para una comida, intentamos obtenerla del almacenamiento local
            final localMeal = _localStorageService.getLastMealDetails();
            if (localMeal != null && localMeal.idMeal == id) {
              meals.add(localMeal);
            }
          }
        }
      } else {
        // Sin conexión: intentamos obtener todas las comidas del almacenamiento local
        for (final id in favoriteIds) {
          final localMeal = _localStorageService.getLastMealDetails();
          if (localMeal != null && localMeal.idMeal == id) {
            meals.add(localMeal);
          }
        }
      }

      emit(state.copyWith(
        status: FavoriteMealsStatus.success,
        meals: meals,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: FavoriteMealsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  //Refrescar los favoritos
  Future<void> _onRefreshFavoriteMeals(
    RefreshFavoriteMeals event,
    Emitter<FavoriteMealsState> emit,
  ) async {
    try {
      //Obtener los favoritos
      final favoriteIds = await _favoritesService.getFavorites();
      final meals = <Meal>[];

      // Si hay conexión a internet, intentamos obtener los datos de la API
      if (_connectivityService.hasInternet) {
        for (final id in favoriteIds) {
          try {
            final meal = await _mealDatasource.getMeal(id);
            meals.add(meal);
            // Guardamos cada comida en el almacenamiento local
            await _localStorageService.saveLastMealDetails(meal);
          } catch (e) {
            // Si falla la API para una comida, intentamos obtenerla del almacenamiento local
            final localMeal = _localStorageService.getLastMealDetails();
            if (localMeal != null && localMeal.idMeal == id) {
              meals.add(localMeal);
            }
          }
        }
      } else {
        // Sin conexión: intentamos obtener todas las comidas del almacenamiento local
        for (final id in favoriteIds) {
          final localMeal = _localStorageService.getLastMealDetails();
          if (localMeal != null && localMeal.idMeal == id) {
            meals.add(localMeal);
          }
        }
      }

      emit(state.copyWith(
        status: FavoriteMealsStatus.success,
        meals: meals,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: FavoriteMealsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
