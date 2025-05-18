// search_meal_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/search_meal_datasources.dart';

part 'search_meal_event.dart';
part 'search_meal_state.dart';

class SearchMealBloc extends Bloc<SearchMealEvent, SearchMealState> {
  final SearchMealDatasource _searchMealDatasource;

  SearchMealBloc({required SearchMealDatasource searchMealDatasource})
      : _searchMealDatasource = searchMealDatasource,
        super(SearchMealState()) {
    on<FetchSearchMeal>(_onFetchSearchMeal);
  }

  Future<void> _onFetchSearchMeal(FetchSearchMeal event, Emitter<SearchMealState> emit) async {
    try {
      // Set state to loading and reset the found meals
      emit(state.copyWith(status: SearchMealStatus.loading, searchMeals: []));
      
      // Fetch the list of meals
      final searchMeals = await _searchMealDatasource.getSearchMeal(event.namePlate);
      
      // Emit success state with the list of meals
      emit(state.copyWith(status: SearchMealStatus.success, searchMeals: searchMeals));
    } catch (e) {
      // Emit failure state with error message
      emit(state.copyWith(status: SearchMealStatus.failure, errorMessage: e.toString()));
    }
  }
}