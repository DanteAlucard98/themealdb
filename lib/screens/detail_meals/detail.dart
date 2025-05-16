import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_adpp_2025/bloc/specific_meal/bloc/specific_bloc.dart';
import 'package:recetas_adpp_2025/bloc/specific_meal/bloc/specific_event.dart';
import 'package:recetas_adpp_2025/domain/entities/meal.dart';

class DetailMealsScreen extends StatelessWidget {
  const DetailMealsScreen({super.key, required this.mealId});
  static const name = 'detail-meals-screen';
  final String mealId;

  @override
  Widget build(BuildContext context) {
    // Access the BLoC from the provider
    final specificBloc = context.read<SpecificBloc>();
    specificBloc.add(FetchMealById(mealId));

    return Scaffold(
      appBar: AppBar(title: Text('Meal Details')),
      body: BlocBuilder<SpecificBloc, SpecificState>(
        builder: (context, state) {
          if (state.status == SpecificStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.status == SpecificStatus.success) {
            final meal = state.meal!;
            return detailmeals(meal: meal);
          } else if (state.status == SpecificStatus.failure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}

class detailmeals extends StatelessWidget {
  final Meal meal;
  const detailmeals({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(meal.strMealThumb, fit: BoxFit.cover, width: double.infinity),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Category: ${meal.strCategory}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Area: ${meal.strArea}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Instructions:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(meal.strInstructions),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Ingredients:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...List.generate(meal.ingredients.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text('${meal.ingredients[index]} - ${meal.measures[index]}'),
            );
          }),
        ],
      ),
    );
  }
}