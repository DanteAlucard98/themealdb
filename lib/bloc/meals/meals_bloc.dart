import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_adpp_2025/bloc/meals/meals_event.dart';
import 'package:recetas_adpp_2025/bloc/meals/meals_state.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/list_meal_datasources.dart';
import 'package:recetas_adpp_2025/infraestructure/services/local_storage_service.dart';

//Bloc para la lista de comidas
class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final ListDatasource _listDatasource;
  final LocalStorageService _localStorageService;
  final _totalLetters = 26; // De 'a' a 'z'

  MealsBloc({
    required ListDatasource listDatasource,
    required LocalStorageService localStorageService,
  }) : _listDatasource = listDatasource,
       _localStorageService = localStorageService,
       super(MealsState()) {
    on<GetMealsByLetter>(_onGetMealsByLetter);
    on<LoadMoreMeals>(_onLoadMoreMeals);
    on<NextLetterMeals>(_onNextLetterMeals);
    on<LoadLastListMeals>(_onLoadLastListMeals);
    
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

      try {
        // Intentar obtener los datos de la API
        final meals = await _listDatasource.getListMeals(event.letter);
        // Guardar los resultados en el almacenamiento local
        await _localStorageService.saveLastListMeals(meals);

        final hasReachedMax = meals.isEmpty;

        emit(state.copyWith(
          status: MealsStatus.success,
          meals: meals,
          hasReachedMax: hasReachedMax,
        ));
      } catch (e) {
        // Si falla la API, intentar cargar los datos locales
        final localMeals = _localStorageService.getLastListMeals();
        if (localMeals.isEmpty) {
          throw Exception('No se pudieron cargar los datos');
        }

        emit(state.copyWith(
          status: MealsStatus.success,
          meals: localMeals,
          hasReachedMax: true, // Asumimos que no podemos cargar más sin conexión
        ));
      }
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

      try {
        // Intentar obtener comidas de la siguiente letra desde la API
        final newMeals = await _listDatasource.getListMeals(nextLetter);
        // Guardar los resultados en el almacenamiento local
        await _localStorageService.saveLastListMeals(newMeals);

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
        // Si falla la API, intentar cargar los datos locales
        final localMeals = _localStorageService.getLastListMeals();
        if (localMeals.isEmpty) {
          throw Exception('No se pudieron cargar más datos');
        }

        // Combinar las comidas actuales con las locales
        final allMeals = List.of(state.meals)..addAll(localMeals);

        emit(state.copyWith(
          status: MealsStatus.success,
          meals: allMeals,
          currentLetter: nextLetter,
          alphabet: nextAlphabet,
          hasReachedMax: true, // Asumimos que no podemos cargar más sin conexión
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: MealsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadLastListMeals(LoadLastListMeals event, Emitter<MealsState> emit) async {
    try {
      final lastMeals = _localStorageService.getLastListMeals();
      if (lastMeals.isNotEmpty) {
        emit(state.copyWith(
          status: MealsStatus.success,
          meals: lastMeals,
          hasReachedMax: true, // Asumimos que no podemos cargar más sin conexión
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: MealsStatus.failure,
        errorMessage: 'Error al cargar la última lista: ${e.toString()}',
      ));
    }
  }
} 