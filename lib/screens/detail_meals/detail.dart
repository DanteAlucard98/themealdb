import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_adpp_2025/bloc/specific_meal/bloc/specific_bloc.dart';
import 'package:recetas_adpp_2025/bloc/specific_meal/bloc/specific_event.dart';
import 'package:recetas_adpp_2025/main.dart';
import 'package:recetas_adpp_2025/screens/detail_meals/widgets/detail_meals_content.dart';

class DetailMealsScreen extends StatelessWidget {
  const DetailMealsScreen({super.key, required this.mealId});
  static const name = 'detail-meals-screen';
  final String mealId;

  @override
  Widget build(BuildContext context) {
    //Accede al BLoC desde el provider
    final specificBloc = context.read<SpecificBloc>();
    specificBloc.add(FetchMealById(mealId));

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 16, top: 8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      //Bloc para obtener la comida específica
      body: BlocBuilder<SpecificBloc, SpecificState>(
        builder: (context, state) {
          if (state.status == SpecificStatus.loading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          } else if (state.status == SpecificStatus.success) {
            final meal = state.meal!;
            return DetailMealsContent(meal: meal);
          } else if (state.status == SpecificStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: AppColors.secondary),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.errorMessage}',
                    style: TextStyle(fontSize: 18, color: AppColors.textPrimary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 60, color: AppColors.secondary),
                  const SizedBox(height: 16),
                  Text(
                    'No data found',
                    style: TextStyle(fontSize: 18, color: AppColors.textPrimary),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

