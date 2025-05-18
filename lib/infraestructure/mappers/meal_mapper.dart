import 'package:recetas_adpp_2025/domain/entities/meal.dart';

//Clase para obtener la comida específica
class MealMapper {
 static Meal fromJson(Map<String, dynamic> json) {
  List<String> ingredients = [];
  List<String> measures = [];

  for (int i = 1; i <= 20; i++) {
    final ingredient = json['strIngredient$i'];
    final measure = json['strMeasure$i'];

    if (ingredient != null && ingredient.isNotEmpty) {
      ingredients.add(ingredient);
      measures.add(measure ?? '');
    }
  }

  return Meal(
    idMeal: json['idMeal'] ?? '',
    strMeal: json['strMeal'] ?? '',
    strDrinkAlternate: json['strDrinkAlternate'] ?? '',
    strCategory: json['strCategory'] ?? '',
    strArea: json['strArea'] ?? '',
    strInstructions: json['strInstructions'] ?? '',
    strMealThumb: json['strMealThumb'] ?? '',
    strTags: json['strTags'] ?? '',
    strYoutube: json['strYoutube'] ?? '',
    strSource: json['strSource'] ?? '',
    strImageSource: json['strImageSource'] ?? '',
    strCreativeCommonsConfirmed: json['strCreativeCommonsConfirmed'] ?? '',
    dateModified: json['dateModified'] ?? '',
    ingredients: ingredients,
    measures: measures,
  );
}
}