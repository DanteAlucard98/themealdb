import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recetas_adpp_2025/bloc/search_meal/search_meal_bloc.dart';
import 'package:recetas_adpp_2025/general_widgets/title_function.dart';
import 'package:recetas_adpp_2025/main.dart';
import 'package:recetas_adpp_2025/screens/detail_meals/widgets/meal_search.dart';

// Pantalla principal de búsqueda
class SearchMealsScreen extends StatelessWidget {
  const SearchMealsScreen({super.key});
  static const name = 'search-meals-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: searchmeals(),
    );
  }
}

// Widget para la funcionalidad de búsqueda
class searchmeals extends StatefulWidget {
  const searchmeals({super.key});

  @override
  State<searchmeals> createState() => _searchmealsState();
}

class _searchmealsState extends State<searchmeals> {
  // Controlador para el campo de búsqueda
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Encabezado con gradiente
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
              titleCase('search meals'),
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Contenido principal
        Expanded(
          child: Container(
            color: AppColors.background,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Campo de búsqueda
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for meals...',
                      hintStyle: TextStyle(color: AppColors.textPrimary.withOpacity(0.6)),
                      prefixIcon: Icon(Icons.search, color: AppColors.primary),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: AppColors.primary),
                        onPressed: () {
                          if (_searchController.text.isNotEmpty) {
                            context.read<SearchMealBloc>().add(
                              FetchSearchMeal(_searchController.text)
                            );
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      filled: true,
                      fillColor: AppColors.cardBackground,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: AppColors.primary, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: AppColors.secondary.withOpacity(0.5)),
                      ),
                    ),
                    style: TextStyle(color: AppColors.textPrimary),
                    cursorColor: AppColors.primary,
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        context.read<SearchMealBloc>().add(
                          FetchSearchMeal(value)
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  // Resultados de la búsqueda
                  Expanded(
                    child: BlocBuilder<SearchMealBloc, SearchMealState>(
                      builder: (context, state) {
                        // Estado inicial
                        if (state.status == SearchMealStatus.initial) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 60,
                                  color: AppColors.secondary.withOpacity(0.5),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Search for your favorite meals!',
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
                        // Estado de carga
                        else if (state.status == SearchMealStatus.loading) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                            ),
                          );
                        } 
                        // Estado de éxito con resultados
                        else if (state.status == SearchMealStatus.success && state.searchMeals.isNotEmpty) {
                          final meals = state.searchMeals;
                          return MealSearch(meals: meals);
                        } 
                        // Estado de error
                        else if (state.status == SearchMealStatus.failure) {
                          return Center(
                            child: Text(
                              'Unable to connect. Please check your internet connection and try again.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          );
                        } 
                        // Estado por defecto
                        else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}