import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recetas_adpp_2025/bloc/meals/meals_barrel.dart';
import 'package:recetas_adpp_2025/screens/list_meals/widgets/meal_card.dart';

class ListMealsScreen extends StatefulWidget {
  const ListMealsScreen({super.key});
  static const name = 'list-meals-screen';
  
  @override
  State<ListMealsScreen> createState() => _ListMealsScreenState();
}

class _ListMealsScreenState extends State<ListMealsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<MealsBloc>().add(LoadMoreMeals());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Cargamos más cuando está a 200 píxeles del final
    return currentScroll >= (maxScroll - 200);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListMealContent(scrollController: _scrollController));
  }
}

class ListMealContent extends StatelessWidget {
  final ScrollController scrollController;
  
  const ListMealContent({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue.withAlpha(400)],
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
              'list of meals',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<MealsBloc, MealsState>(
            builder: (context, state) {
              switch (state.status) {
                case MealsStatus.initial:
                case MealsStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                
                case MealsStatus.failure:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: ${state.errorMessage}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () {
                            context.read<MealsBloc>().add(GetMealsByLetter(state.currentLetter));
                          },
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  );
                
                case MealsStatus.success:
                case MealsStatus.loadingMore:
                  if (state.meals.isEmpty) {
                    return const Center(
                      child: Text('No se encontraron recetas'),
                    );
                  }
                  
                  return ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.all(8.0),
                    itemCount: state.meals.length + (state.hasReachedMax ? 0 : 1),
                    itemBuilder: (context, index) {
                      // Si estamos en el último elemento y no hemos alcanzado el máximo
                      if (index >= state.meals.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      
                      // Renderizar el widget de buildMealCard con los datos de la API
                      final meal = state.meals[index];
                      return buildMealCard(meal.idMeal,meal.strMeal, meal.strMealThumb.isNotEmpty ? meal.strMealThumb : null, context);
                    },
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}