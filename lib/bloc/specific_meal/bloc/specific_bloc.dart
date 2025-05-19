import 'package:bloc/bloc.dart';
import 'package:recetas_adpp_2025/bloc/specific_meal/bloc/specific_event.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/meal_datasources.dart';
import 'package:recetas_adpp_2025/infraestructure/services/local_storage_service.dart';

part 'specific_state.dart';

class SpecificBloc extends Bloc<SpecificEvent, SpecificState> {
  final MealDatasource _mealDatasource;
  final LocalStorageService _localStorageService;

  SpecificBloc({
    required MealDatasource mealDatasource,
    required LocalStorageService localStorageService,
  }) : _mealDatasource = mealDatasource,
       _localStorageService = localStorageService,
       super(SpecificState()) {
    on<FetchMealById>(_onSpecificEvent);
    on<LoadLastMealDetails>(_onLoadLastMealDetails);
  }

  Future<void> _onSpecificEvent(FetchMealById event, Emitter<SpecificState> emit) async {
    try {
      emit(state.copyWith(
        status: SpecificStatus.loading,
        idMeal: event.mealId,
        meal: null,
      ));

      Meal? meal;
      try {
        // Intentar obtener los datos de la API
        meal = await _mealDatasource.getMeal(event.mealId);
        // Guardar los detalles en el almacenamiento local
        await _localStorageService.saveLastMealDetails(meal);
      } catch (e) {
        // Si falla la API, intentar cargar los datos locales
        meal = _localStorageService.getLastMealDetails();
        if (meal == null) {
          throw Exception('No se pudieron cargar los datos de la receta');
        }
      }

      emit(state.copyWith(
        status: SpecificStatus.success,
        meal: meal,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SpecificStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadLastMealDetails(LoadLastMealDetails event, Emitter<SpecificState> emit) async {
    try {
      final lastMeal = _localStorageService.getLastMealDetails();
      if (lastMeal != null) {
        emit(state.copyWith(
          status: SpecificStatus.success,
          meal: lastMeal,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SpecificStatus.failure,
        errorMessage: 'Error al cargar los últimos detalles: ${e.toString()}',
      ));
    }
  }
}
