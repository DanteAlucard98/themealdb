import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_adpp_2025/bloc/meals/meals_barrel.dart';
import 'package:recetas_adpp_2025/bloc/search_meal/search_meal_bloc.dart';
import 'package:recetas_adpp_2025/bloc/specific_meal/bloc/specific_bloc.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/list_meal_datasources.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/meal_datasources.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/search_meal_datasources.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MealsBloc(
            listDatasource: ListDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => SpecificBloc(
            mealDatasource: MealDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => SearchMealBloc(
            searchMealDatasource: SearchMealDatasource(),
          ),
        ),
      ],
      child: child,
    );
  }
} 