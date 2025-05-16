import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recetas_adpp_2025/bloc/search_meal/search_meal_bloc.dart';
import 'package:recetas_adpp_2025/main.dart';
import 'package:recetas_adpp_2025/screens/detail_meals/widgets/meal_search.dart';

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

class searchmeals extends StatefulWidget {
  const searchmeals({super.key});

  @override
  State<searchmeals> createState() => _searchmealsState();
}

class _searchmealsState extends State<searchmeals> {
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
              'search meals',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: AppColors.background,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
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
                  Expanded(
                    child: BlocBuilder<SearchMealBloc, SearchMealState>(
                      builder: (context, state) {
                        if (state.status == SearchMealStatus.initial) {
                          return Center(
                            child: Text(
                              'Search for your favorite meals!',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 16.sp,
                              ),
                            ),
                          );
                        } else if (state.status == SearchMealStatus.loading) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                            ),
                          );
                        } else if (state.status == SearchMealStatus.success && state.searchMeal != null) {
                          final meal = state.searchMeal!;
                          return MealSearch(meal: meal);
                        } else if (state.status == SearchMealStatus.failure) {
                          return Center(
                            child: Text(
                              'Error: ${state.errorMessage}',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.sp,
                              ),
                            ),
                          );
                        } else {
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