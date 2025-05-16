import 'package:bloc/bloc.dart';
import 'package:recetas_adpp_2025/bloc/specific_meal/bloc/specific_event.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/meal_datasources.dart';

part 'specific_state.dart';

class SpecificBloc extends Bloc<SpecificEvent, SpecificState> {
  final MealDatasource _mealDatasource;
  SpecificBloc({required MealDatasource mealDatasource }) : _mealDatasource = mealDatasource, super(SpecificState()) {
    on<FetchMealById>(_onSpecificEvent);
  }

  Future<void> _onSpecificEvent(FetchMealById event, Emitter<SpecificState> emit) async {

    try{
      emit(state.copyWith(
        status: SpecificStatus.loading,
        idMeal:event.mealId,
        meal: null,
      ));

      final meal = await _mealDatasource.getMeal(event.mealId);

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
}
