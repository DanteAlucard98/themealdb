// search_meal_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/search_meal_datasources.dart';
import 'package:recetas_adpp_2025/infraestructure/services/local_storage_service.dart';

part 'search_meal_event.dart';
part 'search_meal_state.dart';

class SearchMealBloc extends Bloc<SearchMealEvent, SearchMealState> {
  final SearchMealDatasource _searchMealDatasource;
  final LocalStorageService _localStorageService;

  SearchMealBloc({
    required SearchMealDatasource searchMealDatasource,
    required LocalStorageService localStorageService,
  }) : _searchMealDatasource = searchMealDatasource,
       _localStorageService = localStorageService,
       super(SearchMealState()) {
    on<FetchSearchMeal>(_onFetchSearchMeal);
    on<LoadLastSearchResults>(_onLoadLastSearchResults);
  }

  Future<void> _onFetchSearchMeal(FetchSearchMeal event, Emitter<SearchMealState> emit) async {
    try {
      // Set state to loading and reset the found meals
      emit(state.copyWith(status: SearchMealStatus.loading, searchMeals: []));
      
      List<Meal> searchMeals;
      try {
        // Intentar obtener los datos de la API
        searchMeals = await _searchMealDatasource.getSearchMeal(event.namePlate);
        // Guardar los resultados en el almacenamiento local
        await _localStorageService.saveLastSearchResults(searchMeals);
      } catch (e) {
        // Si falla la API, intentar cargar los datos locales
        searchMeals = _localStorageService.getLastSearchResults();
        if (searchMeals.isEmpty) {
          throw Exception('No se pudieron cargar los datos');
        }
      }
      
      // Emit success state with the list of meals
      emit(state.copyWith(status: SearchMealStatus.success, searchMeals: searchMeals));
    } catch (e) {
      // Emit failure state with error message
      emit(state.copyWith(status: SearchMealStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onLoadLastSearchResults(LoadLastSearchResults event, Emitter<SearchMealState> emit) async {
    try {
      final lastSearchResults = _localStorageService.getLastSearchResults();
      if (lastSearchResults.isNotEmpty) {
        emit(state.copyWith(
          status: SearchMealStatus.success,
          searchMeals: lastSearchResults,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SearchMealStatus.failure,
        errorMessage: 'Error al cargar los últimos resultados: ${e.toString()}',
      ));
    }
  }
}