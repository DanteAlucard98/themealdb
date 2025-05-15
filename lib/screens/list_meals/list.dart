import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recetas_adpp_2025/screens/list_meals/widgets/meal_card.dart';

class ListMealsScreen extends StatelessWidget {
  const ListMealsScreen({super.key});
  static const name = 'list-meals-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: listMeal());
  }
}

class listMeal extends StatelessWidget {
  const listMeal({super.key});

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
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: [
              buildMealCard('Pozole','https://www.cocinavital.mx/wp-content/uploads/2024/05/pozole-rojo-1-634x420.jpg'),
              buildMealCard('Pambazos',null),
              buildMealCard('Gorditas',null),
              // Add more cards as needed
            ],
          ),
        ),
      ],
    );
  }


}