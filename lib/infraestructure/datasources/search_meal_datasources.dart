import 'package:dio/dio.dart';
import 'package:recetas_adpp_2025/constants/enviroment.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/infraestructure/mappers/meal_mapper.dart';
import 'package:recetas_adpp_2025/infraestructure/models/list_model.dart';

// Class to fetch meals based on search
class SearchMealDatasource {
  final Dio dio;
  SearchMealDatasource() : dio = Dio(BaseOptions(baseUrl: Environment.urlBase));

  // Method to fetch meals based on search query
  Future<List<Meal>> getSearchMeal(String namePlate) async {
    try {
      final response = await dio.get('search.php?s=$namePlate');
      final purpleList = PurpleList.fromJson(response.data);
      
      if (purpleList.meals.isNotEmpty) {
        return purpleList.meals.map((mealJson) => MealMapper.fromJson(mealJson)).toList();
      } else {
        throw Exception('No meals found with the given name');
      }
    } on DioException catch (e) {
      throw Exception('${e.response?.data['error']}');
    } catch (e) {
      throw Exception('${e.toString()}');
    }
  }
}