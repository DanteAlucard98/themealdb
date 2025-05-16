abstract class SpecificEvent {}

class FetchMealById extends SpecificEvent {
  final String mealId;

  FetchMealById(this.mealId);
}