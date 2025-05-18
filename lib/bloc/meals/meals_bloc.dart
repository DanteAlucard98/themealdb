import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_adpp_2025/bloc/meals/meals_event.dart';
import 'package:recetas_adpp_2025/bloc/meals/meals_state.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/list_meal_datasources.dart';
//Bloc para la lista de comidas
class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final ListDatasource _listDatasource;
  final _totalLetters = 26; // De 'a' a 'z'

  MealsBloc({required ListDatasource listDatasource})
      : _listDatasource = listDatasource,
        super(MealsState()) {
    on<GetMealsByLetter>(_onGetMealsByLetter);
    on<LoadMoreMeals>(_onLoadMoreMeals);
    on<NextLetterMeals>(_onNextLetterMeals);
    
    // Cargar comidas iniciales con la letra 'a'
    add(GetMealsByLetter('a'));
  }

  Future<void> _onGetMealsByLetter(
    GetMealsByLetter event,
    Emitter<MealsState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: MealsStatus.loading,
        currentLetter: event.letter,
        alphabet: event.letter.codeUnitAt(0) - 'a'.codeUnitAt(0),
        meals: [], 
        currentPage: 1,
        hasReachedMax: false,
      ));

      final meals = await _listDatasource.getListMeals(event.letter);

      final hasReachedMax = meals.isEmpty;

      emit(state.copyWith(
        status: MealsStatus.success,
        meals: meals,
        hasReachedMax: hasReachedMax,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: MealsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreMeals(
    LoadMoreMeals event,
    Emitter<MealsState> emit,
  ) async {
    // Si ya llegamos al máximo o estamos cargando, no hacer nada
    if (state.hasReachedMax || 
        state.status == MealsStatus.loading || 
        state.status == MealsStatus.loadingMore) {
      return;
    }

    try {
      emit(state.copyWith(
        status: MealsStatus.loadingMore,
      ));

      // Si no hay más comidas en esta letra, pasamos a la siguiente
      add(NextLetterMeals());
    } catch (e) {
      emit(state.copyWith(
        status: MealsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onNextLetterMeals(
    NextLetterMeals event,
    Emitter<MealsState> emit,
  ) async {
    try {
      // Si ya estamos en la 'z', no hacer nada
      if (state.alphabet >= _totalLetters - 1) {
        emit(state.copyWith(
          hasReachedMax: true,
          status: MealsStatus.success,
        ));
        return;
      }

      // Calcular la siguiente letra
      final nextAlphabet = state.alphabet + 1;
      final nextLetter = String.fromCharCode('a'.codeUnitAt(0) + nextAlphabet);

      // Obtener comidas de la siguiente letra
      final newMeals = await _listDatasource.getListMeals(nextLetter);

      // Si no hay comidas, intentamos con la siguiente letra
      if (newMeals.isEmpty) {
        emit(state.copyWith(
          alphabet: nextAlphabet,
          currentLetter: nextLetter,
        ));
        // Intentar con la siguiente letra recursivamente
        add(NextLetterMeals());
        return;
      }

      // Combinar las comidas actuales con las nuevas
      final allMeals = List.of(state.meals)..addAll(newMeals);

      emit(state.copyWith(
        status: MealsStatus.success,
        meals: allMeals,
        currentLetter: nextLetter,
        alphabet: nextAlphabet,
        hasReachedMax: nextAlphabet >= _totalLetters - 1,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: MealsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
} 