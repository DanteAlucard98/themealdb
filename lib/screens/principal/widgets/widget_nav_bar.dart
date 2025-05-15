import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';


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
        color: Colors.blue.withAlpha(200),
    );
  }
}
