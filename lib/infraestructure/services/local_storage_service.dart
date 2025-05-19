import 'dart:convert';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/domain/entities/list_meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _lastSearchKey = 'last_search_results';
  static const String _lastMealKey = 'last_meal_details';
  static const String _lastListMealsKey = 'last_list_meals';
  
  final SharedPreferences _prefs;
  
  LocalStorageService(this._prefs);
  
  // Guardar resultados de búsqueda
  Future<void> saveLastSearchResults(List<Meal> meals) async {
    final mealsJson = meals.map((meal) => {
      'idMeal': meal.idMeal,
      'strMeal': meal.strMeal,
      'strDrinkAlternate': meal.strDrinkAlternate,
      'strCategory': meal.strCategory,
      'strArea': meal.strArea,
      'strInstructions': meal.strInstructions,
      'strMealThumb': meal.strMealThumb,
      'strTags': meal.strTags,
      'strYoutube': meal.strYoutube,
      'strSource': meal.strSource,
      'strImageSource': meal.strImageSource,
      'strCreativeCommonsConfirmed': meal.strCreativeCommonsConfirmed,
      'dateModified': meal.dateModified,
      'ingredients': meal.ingredients,
      'measures': meal.measures,
    }).toList();
    
    await _prefs.setString(_lastSearchKey, jsonEncode(mealsJson));
  }
  
  // Obtener últimos resultados de búsqueda
  List<Meal> getLastSearchResults() {
    final String? mealsJson = _prefs.getString(_lastSearchKey);
    if (mealsJson == null) return [];
    
    final List<dynamic> decodedMeals = jsonDecode(mealsJson);
    return decodedMeals.map((mealJson) => Meal(
      idMeal: mealJson['idMeal'] ?? '',
      strMeal: mealJson['strMeal'] ?? '',
      strDrinkAlternate: mealJson['strDrinkAlternate'] ?? '',
      strCategory: mealJson['strCategory'] ?? '',
      strArea: mealJson['strArea'] ?? '',
      strInstructions: mealJson['strInstructions'] ?? '',
      strMealThumb: mealJson['strMealThumb'] ?? '',
      strTags: mealJson['strTags'] ?? '',
      strYoutube: mealJson['strYoutube'] ?? '',
      strSource: mealJson['strSource'] ?? '',
      strImageSource: mealJson['strImageSource'] ?? '',
      strCreativeCommonsConfirmed: mealJson['strCreativeCommonsConfirmed'] ?? '',
      dateModified: mealJson['dateModified'] ?? '',
      ingredients: List<String>.from(mealJson['ingredients'] ?? []),
      measures: List<String>.from(mealJson['measures'] ?? []),
    )).toList();
  }
  
  // Guardar detalles de una receta específica
  Future<void> saveLastMealDetails(Meal meal) async {
    final mealJson = {
      'idMeal': meal.idMeal,
      'strMeal': meal.strMeal,
      'strDrinkAlternate': meal.strDrinkAlternate,
      'strCategory': meal.strCategory,
      'strArea': meal.strArea,
      'strInstructions': meal.strInstructions,
      'strMealThumb': meal.strMealThumb,
      'strTags': meal.strTags,
      'strYoutube': meal.strYoutube,
      'strSource': meal.strSource,
      'strImageSource': meal.strImageSource,
      'strCreativeCommonsConfirmed': meal.strCreativeCommonsConfirmed,
      'dateModified': meal.dateModified,
      'ingredients': meal.ingredients,
      'measures': meal.measures,
    };
    
    await _prefs.setString(_lastMealKey, jsonEncode(mealJson));
  }
  
  // Obtener detalles de la última receta
  Meal? getLastMealDetails() {
    final String? mealJson = _prefs.getString(_lastMealKey);
    if (mealJson == null) return null;
    
    final Map<String, dynamic> decodedMeal = jsonDecode(mealJson);
    return Meal(
      idMeal: decodedMeal['idMeal'] ?? '',
      strMeal: decodedMeal['strMeal'] ?? '',
      strDrinkAlternate: decodedMeal['strDrinkAlternate'] ?? '',
      strCategory: decodedMeal['strCategory'] ?? '',
      strArea: decodedMeal['strArea'] ?? '',
      strInstructions: decodedMeal['strInstructions'] ?? '',
      strMealThumb: decodedMeal['strMealThumb'] ?? '',
      strTags: decodedMeal['strTags'] ?? '',
      strYoutube: decodedMeal['strYoutube'] ?? '',
      strSource: decodedMeal['strSource'] ?? '',
      strImageSource: decodedMeal['strImageSource'] ?? '',
      strCreativeCommonsConfirmed: decodedMeal['strCreativeCommonsConfirmed'] ?? '',
      dateModified: decodedMeal['dateModified'] ?? '',
      ingredients: List<String>.from(decodedMeal['ingredients'] ?? []),
      measures: List<String>.from(decodedMeal['measures'] ?? []),
    );
  }
  
  // Guardar lista de recetas
  Future<void> saveLastListMeals(List<ListMeal> meals) async {
    final mealsJson = meals.map((meal) => {
      'idMeal': meal.idMeal,
      'strMeal': meal.strMeal,
      'strMealThumb': meal.strMealThumb,
    }).toList();
    
    await _prefs.setString(_lastListMealsKey, jsonEncode(mealsJson));
  }
  
  // Obtener última lista de recetas
  List<ListMeal> getLastListMeals() {
    final String? mealsJson = _prefs.getString(_lastListMealsKey);
    if (mealsJson == null) return [];
    
    final List<dynamic> decodedMeals = jsonDecode(mealsJson);
    return decodedMeals.map((mealJson) => ListMeal(
      idMeal: mealJson['idMeal'] ?? '',
      strMeal: mealJson['strMeal'] ?? '',
      strMealThumb: mealJson['strMealThumb'] ?? '',
    )).toList();
  }
} 