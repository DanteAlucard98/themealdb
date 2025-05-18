import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:recetas_adpp_2025/main.dart';

//Clase para obtener el nav bar
class WidgetNavBar extends StatelessWidget {
    final PageController pageController;
    final int currentIndex;
  const WidgetNavBar({super.key, required this.pageController, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    //Retorna el nav bar
    return CircleNavBar(
      activeIndex: currentIndex,
       activeIcons: [
        //Icono de la lista
          Icon(Icons.list,color: Colors.white,),
          //Icono de la búsqueda
          Icon(Icons.search,color: Colors.white,),
        ],
        inactiveIcons: [
          //Icono de la lista
          Icon(Icons.list_alt,color: Colors.white,),
          //Icono de la búsqueda
          Icon(Icons.search_outlined,color: Colors.white,),
        ],
        onTap: (index) {
          //Animación para cambiar de página
          pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        },
        color: AppColors.primary,
        height: 60,
        circleWidth: 60,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 8,
        circleColor: AppColors.secondary,
        circleShadowColor: Colors.black.withOpacity(0.2),
    );
  }
}
