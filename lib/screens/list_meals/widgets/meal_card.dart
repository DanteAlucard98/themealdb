import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildMealCard(String title, String? image) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    child: SizedBox(
      height: 150.0.h,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center, 
          child: image != null
              ? Image.network(
                  image,
                  width: 100.0.w, 
                  height: 100.0.h, 
                  fit: BoxFit.cover,
                )
              : Icon(
                  Icons.fastfood,
                  size: 100.0.w, 
                  color: Colors.blue.withAlpha(200),
                ),
        ),
        Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}