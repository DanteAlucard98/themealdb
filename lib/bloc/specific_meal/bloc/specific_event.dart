abstract class SpecificEvent {}

class FetchMealById extends SpecificEvent {
  final String mealId;

  FetchMealById(this.mealId);
}

// Evento para cargar los últimos detalles guardados
class LoadLastMealDetails extends SpecificEvent {}