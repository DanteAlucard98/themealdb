import 'package:recetas_adpp_2025/domain/entities/list_meal.dart';

//Clase para obtener la lista de comidas
class ListMealMapper {
  static ListMeal fromJson(Map<String, String?> json) {
    return ListMeal(
      idMeal: json['idMeal']??'',
      strMeal: json['strMeal']??'',
      strMealThumb: json['strMealThumb']??'',
     
    );
  }
} 