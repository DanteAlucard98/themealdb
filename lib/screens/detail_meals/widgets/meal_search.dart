import 'package:flutter/material.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';
import 'package:recetas_adpp_2025/main.dart';
import 'package:go_router/go_router.dart';
import 'package:recetas_adpp_2025/general_widgets/network_image_with_fallback.dart';
import 'package:recetas_adpp_2025/general_widgets/favorite_button.dart';

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
            child: Stack(
              children: [
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: NetworkImageWithFallback(
                      imageUrl: meal.strMealThumb,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(8),
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
                  contentPadding: const EdgeInsets.all(16),
                ),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: FavoriteButton(
                    mealId: meal.idMeal,
                    size: 24.0,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}