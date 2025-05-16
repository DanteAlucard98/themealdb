import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:recetas_adpp_2025/main.dart';


class WidgetNavBar extends StatelessWidget {
    final PageController pageController;
    final int currentIndex;
  const WidgetNavBar({super.key, required this.pageController, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return CircleNavBar(
      activeIndex: currentIndex,
       activeIcons: [
          Icon(Icons.list,color: Colors.white,),
          Icon(Icons.search,color: Colors.white,),
        ],
        inactiveIcons: [
          Icon(Icons.list_alt,color: Colors.white,),
          Icon(Icons.search_outlined,color: Colors.white,),
        ],
        onTap: (index) {
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
