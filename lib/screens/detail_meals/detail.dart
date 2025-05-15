import 'package:flutter/material.dart';

class DetailMealsScreen extends StatelessWidget {
  const DetailMealsScreen({super.key});
  static const name = 'detail-meals-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: detailmeals(),
    );
  }
}

class detailmeals extends StatelessWidget {
  const detailmeals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('detail meals'),
      ],
    );
  }
}