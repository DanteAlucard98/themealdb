import 'package:flutter/material.dart';

class DetailMealsScreen extends StatelessWidget {
  const DetailMealsScreen({super.key, required this.mealId});
  static const name = 'detail-meals-screen';
  final String mealId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: detailmeals(mealId: mealId),
    );
  }
}

class detailmeals extends StatelessWidget {
  final String mealId;
  const detailmeals({
    super.key,
    required this.mealId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(mealId),
      ],
    );
  }
}