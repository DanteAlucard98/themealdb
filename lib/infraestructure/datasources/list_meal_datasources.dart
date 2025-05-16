import 'package:dio/dio.dart';
import 'package:recetas_adpp_2025/constants/enviroment.dart';
import 'package:recetas_adpp_2025/domain/entities/list_meal.dart';
import 'package:recetas_adpp_2025/infraestructure/mappers/list_meal_mapper.dart';
import 'package:recetas_adpp_2025/infraestructure/models/list_model.dart';

class ListDatasource {
  final Dio dio;
  ListDatasource() : dio = Dio(BaseOptions(baseUrl: Environment.urlBase));

  Future<List<ListMeal>> getListMeals(String letra) async {
    try {
      final response = await dio.get('search.php?f=$letra');
      final purpleList = PurpleList.fromJson(response.data);
      
      final meals = purpleList.meals.map((mealJson) => 
        ListMealMapper.fromJson(mealJson)
      ).toList();
      
      return meals;
    } on DioException catch (e) {
      throw Exception('${e.response?.data['error']}');
    } catch (e) {
      throw Exception('${e.toString()}');
    }
  }
}