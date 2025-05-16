import 'package:dio/dio.dart';
import 'package:recetas_adpp_2025/constants/enviroment.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/infraestructure/mappers/meal_mapper.dart';
import 'package:recetas_adpp_2025/infraestructure/models/list_model.dart';

class MealDatasource {
  final Dio dio;
  MealDatasource() : dio = Dio(BaseOptions(baseUrl: Environment.urlBase));

  Future<Meal> getMeal(String id) async {
    try {
      final response = await dio.get('lookup.php?i=$id');
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