import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_adpp_2025/bloc/meals/meals_barrel.dart';
import 'package:recetas_adpp_2025/infraestructure/datasources/meal_datasources.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MealsBloc(
            listDatasource: ListDatasource(),
          ),
        ),
        // Aquí puedes agregar más BlocProviders conforme tu aplicación crezca
      ],
      child: child,
    );
  }
} 