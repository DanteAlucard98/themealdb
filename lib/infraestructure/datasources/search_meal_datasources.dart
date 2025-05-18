import 'package:dio/dio.dart';
import 'package:recetas_adpp_2025/constants/enviroment.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/infraestructure/mappers/meal_mapper.dart';
import 'package:recetas_adpp_2025/infraestructure/models/list_model.dart';

//Clase para obtener la comida encontrada
class SearchMealDatasource {
  final Dio dio;
  SearchMealDatasource() : dio = Dio(BaseOptions(baseUrl: Environment.urlBase));

  //Método para obtener la comida encontrada
  Future<Meal> getSearchMeal(String namePlate) async {
    try {
      final response = await dio.get('search.php?s=$namePlate');
      final purpleList = PurpleList.fromJson(response.data);
      
      if (purpleList.meals.isNotEmpty) {
        return MealMapper.fromJson(purpleList.meals.first);
      } else {
        throw Exception('No meal found with the given ID');
      }
    } on DioException catch (e) {
      throw Exception('${e.response?.data['error']}');
    } catch (e) {
      throw Exception('${e.toString()}');
    }
  }
}
