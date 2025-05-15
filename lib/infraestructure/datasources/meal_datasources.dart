import 'package:dio/dio.dart';
import 'package:recetas_adpp_2025/constants/enviroment.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/infraestructure/mappers/meal_mapper.dart';
import 'package:recetas_adpp_2025/infraestructure/models/list_model.dart';

class ListDatasource {
  final Dio dio;
  ListDatasource() : dio = Dio(BaseOptions(baseUrl: Environment.urlBase));

  Future<List<Meal>> getListMeals(String letra) async {
    try {
      final response = await dio.get('search.php?f=$letra');
      final purpleList = PurpleList.fromJson(response.data);
      
      // Convert each meal in the list to a Meal entity using the mapper
      final meals = purpleList.meals.map((mealJson) => 
        MealMapper.fromJson(mealJson)
      ).toList();
      
      return meals;
    } on DioException catch (e) {
      // Manejar errores de Dio
      throw Exception('${e.response?.data['error']}');
    } catch (e) {
      // Manejar cualquier otro error
      throw Exception('${e.toString()}');
    }
  }
}