import 'package:bloc/bloc.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/search_meal_datasources.dart';

part 'search_meal_event.dart';
part 'search_meal_state.dart';

class SearchMealBloc extends Bloc<SearchMealEvent, SearchMealState> {
  final SearchMealDatasource _searchMealDatasource;
  SearchMealBloc({required SearchMealDatasource searchMealDatasource}) : _searchMealDatasource = searchMealDatasource, super(SearchMealState()) {
    on<FetchSearchMeal>(_onFetchSearchMeal);
  }
  //Bloc para buscar comida
  Future<void> _onFetchSearchMeal(FetchSearchMeal event, Emitter<SearchMealState> emit) async {
    try {
      //Cambia el estado a loading y resetea la comida encontrada
      emit(state.copyWith(status: SearchMealStatus.loading, searchMeal: null));
      final searchMeal = await _searchMealDatasource.getSearchMeal(event.namePlate);
      emit(state.copyWith(status: SearchMealStatus.success, searchMeal: searchMeal));
      
    } catch (e) {
      emit(state.copyWith(status: SearchMealStatus.failure, errorMessage: e.toString()));
    }
  }
}
