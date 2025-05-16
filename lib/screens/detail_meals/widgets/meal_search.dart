import 'package:flutter/material.dart';
import 'package:recetas_adpp_2025/domain/entities/search_meal.dart';
import 'package:recetas_adpp_2025/main.dart';
import 'package:go_router/go_router.dart';

class MealSearch extends StatelessWidget {
  final SearchMeal meal;
  const MealSearch({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        context.pushNamed('detail-meals-screen', pathParameters: {'mealId': meal.idMeal});
      },
      child: Card(
        color: AppColors.cardBackground,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              meal.strMealThumb,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            meal.strMeal,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            meal.strCategory,
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}





