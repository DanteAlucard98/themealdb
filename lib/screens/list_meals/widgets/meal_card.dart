import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildMealCard(String title, String? image, BuildContext context) {
  return InkWell(
    onTap: () {
      print('Meal tapped: $title');
      context.goNamed('detail-meals-screen');
    },
    child: Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 150.0.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(height: 8.h),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );
}