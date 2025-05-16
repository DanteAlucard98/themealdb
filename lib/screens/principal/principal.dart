import 'package:flutter/material.dart';
import 'package:recetas_adpp_2025/main.dart';
import 'package:recetas_adpp_2025/screens/principal/widgets/widget_nav_bar.dart';
import 'package:recetas_adpp_2025/screens/screens.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});
  static const name = 'principal-screen';

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const ListMealsScreen(),
    const SearchMealsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
           _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: WidgetNavBar(
        pageController: _pageController,
        currentIndex: _currentIndex,
      )
    );
  }
}

class principalScreen extends StatelessWidget {
  const principalScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    

    return Column(
      children: [
        Text('Principal'),
      ],
    );
  }
}
