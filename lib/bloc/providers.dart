import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recetas_adpp_2025/bloc/meals/meals_barrel.dart';
import 'package:recetas_adpp_2025/bloc/search_meal/search_meal_bloc.dart';
import 'package:recetas_adpp_2025/bloc/specific_meal/bloc/specific_bloc.dart';
import 'package:recetas_adpp_2025/bloc/favorite_meals/favorite_meals_bloc.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/list_meal_datasources.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/meal_datasources.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/search_meal_datasources.dart';
import 'package:recetas_adpp_2025/infraestructure/services/local_storage_service.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final localStorageService = LocalStorageService(snapshot.data!);

        return MultiBlocProvider(
          providers: [
            //Bloc para la lista de comidas
            BlocProvider(
              create: (context) => MealsBloc(
                listDatasource: ListDatasource(),
                localStorageService: localStorageService,
              ),
            ),
            //Bloc para la comida específica
            BlocProvider(
              create: (context) => SpecificBloc(
                mealDatasource: MealDatasource(),
                localStorageService: localStorageService,
              ),
            ),
            //Bloc para buscar comida
            BlocProvider(
              create: (context) => SearchMealBloc(
                searchMealDatasource: SearchMealDatasource(),
                localStorageService: localStorageService,
              ),
            ),
            //Bloc para favoritos
            BlocProvider(
              create: (context) => FavoriteMealsBloc(
                mealDatasource: MealDatasource(),
              ),
            ),
          ],
          child: child,
        );
      },
    );
  }
} 