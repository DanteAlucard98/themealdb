import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_adpp_2025/bloc/favorite_meals/favorite_meals_bloc.dart';
import 'package:recetas_adpp_2025/main.dart';
import 'package:recetas_adpp_2025/screens/principal/widgets/widget_nav_bar.dart';
import 'package:recetas_adpp_2025/screens/screens.dart';
import 'package:recetas_adpp_2025/screens/favorite_meals/favorite_meals_screen.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});
  static const name = 'principal-screen';

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

//Clase para obtener la pantalla principal
class _PrincipalScreenState extends State<PrincipalScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const ListMealsScreen(),
    const SearchMealsScreen(),
    const FavoriteMealsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page != null) {
        final newIndex = _pageController.page!.round();
        if (newIndex != _currentIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
          // Cargar favoritos cuando se muestra la pantalla de favoritos
          if (newIndex == 2) {
            context.read<FavoriteMealsBloc>().add(LoadFavoriteMeals());
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      //Contenedor de la pantalla principal
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(), // Disable swipe navigation
      ),
      //Barra de navegación
      bottomNavigationBar: WidgetNavBar(
        pageController: _pageController,
        currentIndex: _currentIndex,
      )
    );
  }
}

