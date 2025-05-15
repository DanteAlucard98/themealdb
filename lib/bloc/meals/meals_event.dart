abstract class MealsEvent {}

// Evento para obtener comidas por letra (primera carga)
class GetMealsByLetter extends MealsEvent {
  final String letter;

  GetMealsByLetter(this.letter);
}

// Evento para cargar más comidas (infinite scroll)
class LoadMoreMeals extends MealsEvent {}

// Evento para avanzar a la siguiente letra del alfabeto
class NextLetterMeals extends MealsEvent {} 