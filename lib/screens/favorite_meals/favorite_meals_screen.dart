import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recetas_adpp_2025/bloc/favorite_meals/favorite_meals_bloc.dart';
import 'package:recetas_adpp_2025/general_widgets/title_function.dart';
import 'package:recetas_adpp_2025/main.dart';
import 'package:recetas_adpp_2025/screens/list_meals/widgets/meal_card.dart';

class FavoriteMealsScreen extends StatelessWidget {
  const FavoriteMealsScreen({super.key});
  static const name = 'favorite-meals-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            height: 100.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Center(
              heightFactor: 100.h,
              child: Text(
                titleCase('my favorites meals'),
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<FavoriteMealsBloc, FavoriteMealsState>(
              builder: (context, state) {
                if (state.status == FavoriteMealsStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.status == FavoriteMealsStatus.failure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.errorMessage ?? 'Error al cargar favoritos',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16.sp,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<FavoriteMealsBloc>().add(LoadFavoriteMeals());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  );
                }

                if (state.meals.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 60,
                          color: AppColors.secondary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No favorite yet!',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<FavoriteMealsBloc>().add(LoadFavoriteMeals());
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.meals.length,
                    itemBuilder: (context, index) {
                      final meal = state.meals[index];
                      return buildMealCard(
                        meal.idMeal,
                        meal.strMeal,
                        meal.strMealThumb,
                        context,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 