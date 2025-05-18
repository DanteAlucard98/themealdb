import 'package:flutter/material.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/main.dart';
import 'package:go_router/go_router.dart';

// Class to display a list of found meals
class MealSearch extends StatelessWidget {
  final List<Meal> meals;
  const MealSearch({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Navigate to the meal detail screen
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
      },
    );
  }
}