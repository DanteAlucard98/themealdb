part of 'specific_bloc.dart';

enum SpecificStatus { initial, loading, success, failure }

class SpecificState {
  final SpecificStatus status;
  final Meal? meal;
  final String errorMessage;
  final String idMeal;
  SpecificState({
    this.status = SpecificStatus.initial,
    this.meal,
    this.errorMessage = '',
    this.idMeal = '',
  });

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

