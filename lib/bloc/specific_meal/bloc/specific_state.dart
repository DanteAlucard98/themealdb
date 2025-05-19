part of 'specific_bloc.dart';

//Estado de la comida específica
enum SpecificStatus { initial, loading, success, failure }

class SpecificState {
  final SpecificStatus status;
  final Meal? meal;
  final String errorMessage;
  final String idMeal;

  //Constructor de la comida específica
  SpecificState({
    this.status = SpecificStatus.initial,
    this.meal,
    this.errorMessage = '',
    this.idMeal = '',
  });

  //Copiar la comida específica
  SpecificState copyWith({
    SpecificStatus? status,
    Meal? meal,
    String ? idMeal,
    String? errorMessage,
  }) {
    return SpecificState(
      status: status ?? this.status,
      meal: meal ?? this.meal,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

